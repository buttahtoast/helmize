+++
title = "Custom"
description = "Custom Renderers"
weight = 4
+++

You can implement your own Renderer templates.

# Configuration

General configuration for Renderers.

## Assignment

Content is not returned via YAML but directly performed on the `$.content` map. Since map operations in sprig are directly performed on the given structure, it's unessecary to abstract it via a return value. The below example implements functions of our [library chart](../templating/#library). The advantage of the library functions is they accept key paths and don't fail if a child element does not exist.


```go-html-template
{{- define "customization.renderer.content" -}}

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


After each renderer is executed, it's checked, if the `$.content` key is still of kind `map`. If not, an error is thrown.


If you would like to redirect content from the root context, you need to create a new variable with the dereferenced context. Then you can redirect the data to the content map:

```go-text-template
{{- define "customization.renderer.context" -}}

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

Here's a minimalstic Renderer template to get started.

```go-text-template
{{- define "customization.renderer.template" -}}
  {{- $return := dict "errors" list "debug" list -}}

  {{/* Renderer Logic */}}
  ... 

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}
```

## Context

That's how the Root Context (`$`) looks like given to the renderer templates.

{{< expand "Context" "..." >}}

Key population:

  1. `$.Wagon` - [Wagon Context (without `.content`)](#wagon-context)
  2. `$.ctx` - [Global Context](../../templating/#global-context)

```yaml
# Content Of the current file
content:
  # Content omitted
  # ...

## Wagon Context (1)
Wagon:
  ...

## Global Context (2)
ctx:
  ...
```
{{< /expand >}}

# Example

Let's create a new Renderer which injects a jmx sidecar to all pod parent manifests. We must create our Renderer in the `templates` directory of our chart.

```Shell
mkdir -p templates/renderer/
```

Then Let's add this Template under `templates/renderer/_sidecar.tpl`

{{< expand "templates/renderer/_sidecar.tpl" "..." >}}

This Renderer checks the `kind` field within the content. If no `kind` field is present, an error is returned reflecting that. If a kind is set, it's compared if it's  any of `deployment`, `statefulset`, `daemonset`or `pod`. If any of those match, a predefined container template for the sidecar is appended to the container spec directly in the content. The path is different pod, since all the other kind's implement as template a pod spec. 


```go-text-template
{{- define "customization.renderers.sidecar" -}}
  {{- $return := dict "errors" list "debug" list -}}
  {{- $kind := (lower (default "" $.content.kind) | toString) -}}

  {{/* Verify if Kind persent */}}
  {{- if $kind -}}

    {{/* Same Spec Path */}}
    {{- if (has $kind (list "deployment" "statefulset" "daemonset")) -}}
      {{- $_ := set $.content.spec.template.spec "containers" (append $.content.spec.template.spec.containers (fromYaml (include "customization.renderers.sidecar.template" $))) -}}
  
    {{/* Different Path for Pods */}}
    {{- else if (eq $kind "pod") -}}
      {{- $_ := set $.content.spec "containers" (append $.content.spec.containers (fromYaml (include "customization.renderers.sidecar.template" $))) -}}
  
    {{- end -}}

  {{/* Set Error on empty Kind */}}
  {{- else -}}
    {{- $_ := set $return "errors" (append $return.errors "No Kind Defined") -}}

  {{- end -}}

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}


{{/* JMX Sidecar Container Template */}}
{{- define "customization.renderers.sidecar.template" -}}
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

Once the Renderer is created we need to reference in the [configuration](#reference). In this case we want the Renderer to be executed for all files. So the config would look like this:

```yaml
inventory_directory: "structure/"
file_config_key: "metadata.helmize"
force: false
conditions:
  - name: "resources"
    allow_root: true
renderers:
  - "customization.renderers.sidecar"
```