+++
title = "YAML"
description = "Advanced YAML Files"
weight = 5
+++

{{< hint "info" >}}**Example** [https://github.com/buttahtoast/helmize/tree/main/examples/yaml](https://github.com/buttahtoast/helmize/tree/main/examples/yaml){{< /hint >}}

There's currently one known limitation with YAML and go sprig. Should we discover more, we will add it to this section.

<h1>Multi YAML</h1>

Helmize supports multi YAML files (Multiple YAMLs in one file separeted by ). The implementation is relativ primitive: If a file contains it's split into multiple sub files, which then are treated as seperated files for further processing.

<h2>Limitation</h2>

The `fromYaml` function can not parse multiple yaml files, but is aware of the delimiter. If you have the following example:

```yaml
{{- define "sample.data" -}}
---
First: YAML
---
Second: YAML
{{- end -}}

{{- $t := (fromYaml (include "sample.data" $)) -}}
{{- toYaml $t -}}
```

You will get the following output:

```yaml
$ helm template .

---
# Source: test/templates/test.yaml
First: YAML
```

Meaning the function only parses the first YAML found.

<h2>Workaround</h2>

This is simplified version of how helmize parses multi YAML files. In the first step the entire file is templated (So it's also possible to generate more files via templating within a file). The input is still of type string.  No the entire content is split by `---` resulting in sub files. In the iteration it's checked if there is any content (when two `---` come after each other the `splitList` function will create a entry with `" "`. Therefor we check if its empy without spaces). Then the content is loaded to yaml (and verified if the yaml is valid). 

**NOTE: The split looks for `\n---`. So make sure YAML indicators come after a linebreak.**

```yaml
{{- define "sample.data" -}}
---
First: {{ $.Release.Name }}
---
Second: YAML
---
---
third: YAML
{{- end -}}

{{- $t := (tpl (include "sample.data" $) $) -}}
{{- $f := splitList "---" $t | compact -}}
{{- range $i, $c := $f -}}
  {{- if ($c | nospace | trimAll "\n") }}
{{ $i }}: {{- toYaml (fromYaml ($c)) | nindent 0 }}
  {{- end }}
{{- end -}}
```

The result for the above template is:

```yaml
$ helm template .

---
# Source: test/templates/test.yaml
0:
First: release-name
1:
Second: YAML
3:
third: YAML
```

Understanding this might help working with multi YAML files.

<h2>Hints</h2>

Here are some hints regarding Multi YAML files

<h3>Nested YAML Data</h3>

You can still use multi line YAML's, our implementation should not interefer with them:

**structure/resources/multi-line.yaml**

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  entrypoint.sh: |-
    #!/bin/bash
    echo "Do this"
  game.properties: |
    ---
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
```

<h3>Wrong Templating</h3>

There might be cases where to templating does not validate correctly and therefor you might have unexpected output. Take for example this template:

**structure/resources/wrong-template.yaml**

```yaml
{{- range $f, $d := (fromYaml (include "data" $)).data -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap-{{ $f }}
data:
  field: {{ $d }}
{{- end -}}

{{- define "data" -}}
data: 
  name_1: val_1
  name_2: val_2
  name_3: val_3
{{- end -}}
```

But as output we only get:

```
# Source: multi-yaml/templates/deploy.yaml
# File: [configmap-configmap-name_3.yaml]
# Checksum 7cc3553b2b3ec675cbdad142ce0293cc4f523d3d5aed8bd46d42451f82c3d7bc
apiVersion: v1
data:
  field: val_3
kind: ConfigMap
metadata:
  name: configmap-name_3
```

The other two configmaps are missing. With the summary we can see what happened:

{{< expand "Summary" "..." >}}
```yaml
helm template . --set summary=true --set debug=true

...
paths:
  ...
  - _order: 5
  config:
    no_match: append
    subpath: true
  file: structure/resources/wrong-template.yaml
  ids:
  - configmap-configmap-name_3.yaml
  partial_files:
  - |-
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: configmap-name_1
    data:
      field: val_1---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: configmap-name_2
    data:
      field: val_2---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: configmap-name_3
    data:
      field: val_3
  path: structure/resources/
```
{{< /expand >}}

Under `partial_files` we should see 3 entries. Instead it's a single entry. That's because the split does not match `\n---` because the template does not print a new line after each iteration. Let's fix that in the template (Note the missing `-` in the closing brackets):

**structure/resources/wrong-template.yaml**

```yaml
{{- range $f, $d := (fromYaml (include "data" $)).data }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap-{{ $f }}
data:
  field: {{ $d }}
{{- end }}
```

Now if we look again at the summary, we see three entries and all three configmaps are printed:

{{< expand "Summary" "..." >}}
```yaml
helm template . --set summary=true --set debug=true

...
paths:
  ...
  - _order: 5
  config:
    no_match: append
    subpath: true
  file: structure/resources/wrong-template.yaml
  ids:
  - configmap-configmap-name_3.yaml
  partial_files:
  - |2-

    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: configmap-name_1
    data:
      field: val_1
  - |2-

    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: configmap-name_2
    data:
      field: val_2
  - |2-

    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: configmap-name_3
    data:
      field: val_3

  path: structure/resources/
```
{{< /expand >}}

<h2>Examples</h2>

[You can find this example here](https://github.com/buttahtoast/helmize/tree/main/examples/multi-yaml)

{{< expand "Helm Repository Iteration" "..." >}}

Create an iteration creates multiple [Helm Repositories](https://fluxcd.io/docs/components/source/helmrepositories/) based on values:

**structure/resources/repositories.yaml**
```yaml 
{{- if $.Values.public_repos -}}
  {{- range $repo_name, $repo_url := $.Values.public_repos }}
---  
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: {{ $repo_name }}
spec:
  url: {{ $repo_url }}
  interval: {{ default "5m0s" $.Values.repo.interval }}
  {{- end }}
{{- end -}}
```

Values which feed the tempalte:

**values.yaml**
```yaml
repo:
  interval: "1m"
public_repos:
  metallb: https://metallb.github.io/metallb
  jetstack: https://charts.jetstack.io
  external_dns: https://kubernetes-sigs.github.io/external-dns/
```

For each entry under `public_repos` we expect a dedicated YAML:

{{< expand "Result" "..." >}}
```yaml
---
# Source: multi-yaml/templates/deploy.yaml
# File: [helmrepository-external_dns.yaml]
# Checksum 7ae7ae809c40251fb91209b1afe4bd864657667ef828df5a9cd9455af576fc22
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: external_dns
spec:
  interval: 1m
  url: https://kubernetes-sigs.github.io/external-dns/
---
# Source: multi-yaml/templates/deploy.yaml
# File: [helmrepository-jetstack.yaml]
# Checksum c879ba5993cc035b2d9dfc9a7fa7987662da78ce85264ce29105136049de01ed
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: jetstack
spec:
  interval: 1m
  url: https://charts.jetstack.io
---
# Source: multi-yaml/templates/deploy.yaml
# File: [helmrepository-metallb.yaml]
# Checksum 6eb95220b4e806bf10faf4b880ee57f7874d72c9e85043d16e59f22a5af1027d
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: metallb
spec:
  interval: 1m
  url: https://metallb.github.io/metallb
```
{{< /expand >}}

{{< /expand >}}


