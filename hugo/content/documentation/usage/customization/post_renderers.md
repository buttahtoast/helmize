+++
title = "Post Renderers"
description = "Custom Post Renderers"
weight = 4
+++

You can implement your own post renderer templates. Post Renderers are executed after all the files are merged within the train. They allow to make changes on the resulting manifests or even validate the integrity of the content.

# Configuration

General configuration for Post Renderers.

## Reference

Post Renderers must be referenced via configuration. You can either enable post renderers for all files via [the helmize configuration]() or [based on condition](../../configuration/conditions/#post_renderers).

## Predefined

We will start adding predefined post-renderers in the future, if the seam useful for general use. You are welcome to contribute post-renderes as well. Just open a issue on the github project.
## Assignment

Content is not returned via YAML but directly performed on the `$.content` map. Since map operations in sprig are directly performed on the given structure, it's unessecary to abstract it via a return value. The below example implements functions of our [library chart](../templating/#library). The advantage of the library functions is they accept key paths and don't fail if a child element does not exist.


```go-html-template
{{- define "customization.postrenderers.content" -}}

  {{/* Add a new Field to the Content/Overwrite */}}
    {{- $_ := set $.content.metadata.labels (dict "new_label" "new_value") -}}

    {{/* Library Set Function */}}
    {{- include "lib.utils.dicts.set" (dict "path" "metadata.labels" "data" $.content "value" (dict "new_label" "new_value")) -}}


  {{/* Remove a field from the Content */}}
    {{- $_ := unset $.content.metadata "labels" -}}

    {{/* Library Unset Function */}}
    {{- include "lib.utils.dicts.unset" (dict "path" "metadata.labels" "data" $.content) -}}

{{- end -}}
```


After each post renderer is executed, it's checked, if the `$.content` key is still of kind `map`. If not, an error is thrown.


If you would like to redirect content from the root context, you need to create a new variable with the dereferenced context. Then you can redirect the data to the content map:

```go-text-template
{{- define "customization.postrenderers.context" -}}

  {{/* Dereference (No Pointer) */}}
  {{- $ctx := (fromYaml (toYaml $)) -}}

  {{/* Set Context (Here we need to dereference $ to dump it's content. Otherwise it breaks the set function */}}
  {{- $_ := set $.content "ctx" $ctx -}}

{{- end -}}
```

## Return

The following return values (YAML Print) are considered:

* `errors` - `<slice>` <br>
  A list of errors which occured during identifier evaluation. The error will make helmize fail with your error message. 

* `debug` - `<slice>` <br>
  Debug output which can be seen in summary (If something isn't doing what you thought it does).

The Values are not required to be returned, only if you would like to invoke error/debug messages

## Template

Here's a minimalstic Post Renderer template to get started.

```go-text-template
{{- define "customization.postrenderers.sidecar" -}}
  {{- $return := dict "errors" list "debug" list -}}

  {{/* Post Renderer Logic */}}
  ... 

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}
```

## Context

That's how the Root Context (`$`) looks like given to the post-renderer templates.

{{< expand "Context" "..." >}}

```yaml
## Content Of the current file
content:
  apiVersion: apps/v1
  kind: StatefulSet
  metadata:
    labels:
      app: web
      inject_port: "true"
    name: octopus-deployment
  spec:
    podManagementPolicy: OrderedReady
    replicas: 1
    selector:
      matchLabels:
        octopusexport: OctopusExport
    template:
      metadata:
        labels:
          app: web
          octopusexport: OctopusExport
      spec:
        affinity:
          podAntiAffinity:
            preferredDuringSchedulingIgnoredDuringExecution:
            - podAffinityTerm:
                labelSelector:
                  matchExpressions:
                  - key: app
                    operator: In
                    values:
                    - web
                topologyKey: kubernetes.io/hostname
              weight: 100
        containers:
        - env:
          - name: EXISTING_VAR
            value: Overwrite Value
          - name: DEMO_GREETING
            value: Hello from the environment
          - name: DEMO_FAREWELL
            value: Such a sweet sorrow
          - name: injected
            value: env
          image: nginx
          name: nginx
          ports:
          - containerPort: 80
        - command:
          - java
          - -XX:+UnlockExperimentalVMOptions
          - -XX:+UseCGroupMemoryLimitForHeap
          - -XX:MaxRAMFraction=1
          - -XshowSettings:vm
          - -jar
          - jmx_prometheus_httpserver.jar
          - "90001"
          - /opt/jmx-config/jmx-prometheus.yml
          env:
          - name: EXISTING_VAR
            value: Overwrite Value
          - name: injected
            value: env
          name: jmx
          ports:
          - containerPort: 9001
            name: jmx
    updateStrategy:
      type: RollingUpdate


## File Information
File:
  debug: []
  errors: []
  files:
  - _order: 4
    config:
      fork: false
      no_match: append
      pattern: false
      render: true
      subpath: true
    data: {}
    file: structure/resources/statefulset.yaml
    ids:
    - statefulset-octopus-deployment.yaml
    path: structure/resources/
    post_renderers: []
    value: {}
  id:
  - statefulset-octopus-deployment.yaml
  post_renders:
  - customization.postrenderers.sidecar
  - customization.postrenderers.env
  - customization.postrenderers.context
  render: true
  subpath: .

## Global Helm Context
ctx:
  ...
```
{{< /expand >}}

# Example

Let's create a new Post-Renderer which injects a jmx sidecar to all pod parent manifests. We must create our Post-Renderer in the `templates` directory of our chart.

```Shell
mkdir -p templates/post-renders/
```

Then Let's add this Template under `templates/post-renders/_sidecar.tpl`

{{< expand "templates/post-renders/_sidecar.tpl" "..." >}}

This Post Renderer checks the `kind` field within the content. If no `kind` field is present, an error is returned reflecting that. If a kind is set, it's compared if it's  any of `deployment`, `statefulset`, `daemonset`or `pod`. If any of those match, a predefined container template for the sidecar is appended to the container spec directly in the content. The path is different pod, since all the other kind's implement as template a pod spec. 


```go-text-template
{{- define "customization.postrenderers.sidecar" -}}
  {{- $return := dict "errors" list "debug" list -}}
  {{- $kind := (lower (default "" $.content.kind) | toString) -}}

  {{/* Verify if Kind persent */}}
  {{- if $kind -}}

    {{/* Same Spec Path */}}
    {{- if (has $kind (list "deployment" "statefulset" "daemonset")) -}}
      {{- $_ := set $.content.spec.template.spec "containers" (append $.content.spec.template.spec.containers (fromYaml (include "customization.postrenderers.sidecar.template" $))) -}}
  
    {{/* Different Path for Pods */}}
    {{- else if (eq $kind "pod") -}}
      {{- $_ := set $.content.spec "containers" (append $.content.spec.containers (fromYaml (include "customization.postrenderers.sidecar.template" $))) -}}
  
    {{- end -}}

  {{/* Set Error on empty Kind */}}
  {{- else -}}
    {{- $_ := set $return "errors" (append $return.errors "No Kind Defined") -}}

  {{- end -}}

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}


{{/* JMX Sidecar Container Template */}}
{{- define "customization.postrenderers.sidecar.template" -}}
name: "jmx"
command:
  - java
  - -XX:+UnlockExperimentalVMOptions
  - -XX:+UseCGroupMemoryLimitForHeap
  - -XX:MaxRAMFraction=1
  - -XshowSettings:vm
  - -jar
  - jmx_prometheus_httpserver.jar
  - "90001"
  - /opt/jmx-config/jmx-prometheus.yml
ports:
  - name: "jmx"
    containerPort: 9001
{{- end -}}
```
{{< /expand >}}

Once the post-render is created we need to reference in the [configuration](#reference). In this case we want the post renderer to be executed for all files. So the config would look like this:

```yaml
inventory_directory: "structure/"
file_config_key: "metadata.helmize"
force: false
conditions:
  - name: "resources"
    allow_root: true
post_renderers:
  - "customization.postrenderers.sidecar"
```