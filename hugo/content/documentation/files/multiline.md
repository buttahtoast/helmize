+++
title = "Multi YAML"
description = "Multi YAML Files"
weight = 3
+++

Helmize supports multi YAML files (Multiple YAMLs in one file separeted by ). The implementation is relativ primitive: If a file contains it's split into multiple sub files, which then are treated as seperated files for further processing.

<h1>Limitation</h1>

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
  {{- if ($c | nospace) -}}
    {{- toYaml (fromYaml ($c)) | nindent 0}}
  {{- end -}}
{{- end -}}
```

The result for the above template is:

```yaml
$ helm template .

---
# Source: test/templates/test.yaml
First: release-name
Second: YAML
third: YAML
```

Understanding this might help working with multi YAML files.

<h1>Examples</h1>

Some Examples for Multi YAML files with the above snippet

{{< expand "Repository Iteration" "..." >}}
Hello


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


**values.yaml**
```yaml
repo:
  interval: "1m"
public_repos:
  metallb: https://metallb.github.io/metallb
  jetstack: https://charts.jetstack.io
  external_dns: https://kubernetes-sigs.github.io/external-dns/
```

**Result**

{{< /expand >}}


