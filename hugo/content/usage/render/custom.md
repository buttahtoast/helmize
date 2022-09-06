+++
title = "Custom Template"
description = "Custom Render Template"
weight = 3
+++

{{< hint "info" >}}**Example** [https://github.com/buttahtoast/helmize/tree/main/examples/example-customization](https://github.com/buttahtoast/helmize/tree/main/examples/example-customization){{< /hint >}}


You can implement your own render template. The render template constructs the output YAML when templating the entire structure.

## Configuration

General configuration for a Render Template.

### Template

Here’s a minimalstic Renderer Template to get started.

```go-text-template
{{- define "render.template" -}}
  {{- range $wagon := $.train.wagons -}}

   {{/* Render Logic */}}

   {{/* Include Default Wagon Render Template (If you still want to use our template) */}}
   {{- include "helmize.entrypoint.templates.render.wagon" (dict "wagon" $wagon "ctx" $.ctx) -}}

  {{- end -}}
{{- end -}}
```

### Context

An Identifier template receives the following context (Values Change per File):

{{< expand "Context" "..." >}}


## Example

{{< hint "info" >}}**Example** [https://github.com/buttahtoast/helmize/tree/main/examples/customization](https://github.com/buttahtoast/helmize/tree/main/examples/customization){{< /hint >}}


In the `helmize.yaml` which template we want to use ():


{{< expand "templates/_render.tpl" "..." >}}

The identifier calls the default identifier template first. Then it's checked if there's a field set in the content of a file called `super_identifier`. If that's true, the value of said field is matched against a dns-1123 regex. If the regex matches, the value is set as only identifier for the file, overwriting all the other identifiers. A debug message is added indicating, that a super identifier was assigned. If the regex does not match, an error is thrown. If the field `super_identifier` is not set, nothing happens.


```go-text-template
{{- define "customization.render.template" -}}
  {{- range $wagon := $.train.wagons -}}

   {{/* Validate Annotations */}}
   {{- if (get (default dict $wagon.content.metadata.labels) "render")  -}}
     {{- $_ := set $wagon "render" false -}}
   {{- end -}}

   {{/* Include Default Wagon Render Template */}}
   {{- include "helmize.entrypoint.templates.render.wagon" (dict "wagon" $wagon "ctx" $.ctx) -}}

  {{- end -}}
{{- end -}}
```

{{< /expand >}}

Once the render template is created we need to reference in the [configuration](../../configuration/helmize/#render_template):

```yaml
render_template: "customization.render.template"
conditions:
  - name: "resources"
    any: true
  - name: "additional"
    any: true
```