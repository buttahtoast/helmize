+++
title = "Identifiers"
description = "Identifiers"
weight = 1
+++

Since Helmize supports multi YAML files each element within a file 

{{< hint "warning" >}}
Regardless if you are using the default identifier template or your own. If the template returns an empty ID the file name where the resource originate from is used. Should two resources from the same file use the file's id it's considered an error.
{{< /hint >}}

# Default Template

Currently if a element has the field `kind` and `metadata.name` it's combined to `{kind}-{metadata.name}.yaml`. This way you can merge on file and metadata basis.

The current template can be found here:

  * [https://github.com/buttahtoast/helm-charts/blob/master/charts/helmize/templates/render/func/files/_identifier.tpl](https://github.com/buttahtoast/helm-charts/blob/master/charts/helmize/templates/render/func/files/_identifier.tpl)






# Customize

You can implement your own identifier template, if ours is not practical for you. Let's see how it's done.

## Context

An Identifier template receives the following context:

```
## Content Of the Resources
content:
  apiVersion: v1
  kind: Service
  metadata:
    name: frontend
  spec:
    ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: http
    selector:
      app: frontend
    type: ClusterIP


## File Information
id:
  file: structure/base/podinfo/service.yaml
  filename: service.yaml
  fix: ""
  path: structure/base/


## Global Helm Context
ctx:
  ...
```

## Return

An Identifier can have following return values (YAML Print):

* `id` - `<string>` <br>
  The evaluated ID. If empty uses file name.

* `errors` - `<list>` <br>
  A list of errors which occured during identifier evaluation. The error will make helmize fail with your error message. 

* `debug` - `<list>` <br>
  Debug output which can be seen in summary (If something isn't doing what you thought it does).

* `requireId` - `<string/bool>` <br>
  For every evulated id (`$.id`) the result can not be empty. If it's empty, it's an error.  

## Example

In the `helmize.yaml` which template we want to use:

```
..
custom_identifier_template: "reference.identifier.template"
..
```

Let's create a simple custom identifier template. This template searches each received file for the field `$.content.helmize_identifier`. If the field is set, then it's value is used as identifier. If it's not set, an error is returned.


{{< expand "templates/_identifier.tpl" "..." >}}
```
{{- define "reference.identifier.template" -}}
  {{- $return := dict "id" "" "errors" list "debug" list -}}
  {{- if $.content.helmize_identifier -}}
    {{- $_ := set $return "id" $.content.helmize_identifier -}}
    {{- $_ := unset $.content "helmize_identifier" -}}
  {{- else -}}
    {{- $_ := set $return "errors" (append $return.errors (dict "error" "Missing field helmize_identifier")) -}}
  {{- end }}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}
```
{{< hint "info" >}}
The template must be in der templates/ directory, otherwise it can't be resolved.
{{< /hint >}}

{{< hint "info" >}}
The `{{- $_ := unset $.content "helmize_identifier" -}}` removes the field `helmize_identifier`, since this wouldn't be a valid kubernetes manifest. Since everything under `$` is a pointer we can manipulate it's context via it's root context path. You could also implement a post-renderer which would get rid of the field.
{{< /hint >}}
{{< /expand >}}

If we run this for the first time, we will get errors on all of our files, since none of them have set the field yet:

```
$ helm template examples/reference

Found errors, please resolve those errors or use the force options:

  - errors:
    - error: Missing field helmize_identifier
    file: structure/base/podinfo/deploy.yaml
  - errors:
    - error: Missing field helmize_identifier
    file: structure/base/podinfo/service.yaml
  - errors:
    - error: Missing field helmize_identifier
    file: structure/env/test/podinfo/deployment-frontend.yaml
  - errors:
    - error: Missing field helmize_identifier
    file: structure/env/test/podinfo/hpa.yaml
  - errors:
    - error: Missing field helmize_identifier
    file: structure/location/east/podinfo/deploy.yaml
```

To make it work let's add to each of the files a `helmize_identifier`. Each Kubernetes kind is it's own identifier:

  * *service.yaml -> `helmize_identifier: service` etc.

If we rerun in summary mode, we will see, that the identifiers were taken from the attribute, but the attribute is no longer in the content. The identifier is represented via the `id` field:

```
$ helm template . --set debug=true --set summary=true

...

- checksum: 4669de4bb6631c64c7459e44b38c32a1236a0b7fb419b642d4a52b76ff51747c
  content:
    apiVersion: autoscaling/v2beta2
    kind: HorizontalPodAutoscaler
    metadata:
      name: frontend
    spec:
      maxReplicas: 4
      metrics:
      - resource:
          name: cpu
          target:
            averageUtilization: 99
            type: Utilization
        type: Resource
      minReplicas: 1
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: frontend
  debug: []
  errors: []
  id: hpa
- checksum: 08b06c48a587e3fe6179875f70331bb97562a6e584dcb32807ce9eac7572fc8d
  content:
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
    spec:
      ports:
      - name: http
        port: 80
        protocol: TCP
        targetPort: http
      selector:
        app: frontend
      type: ClusterIP
  debug: []
  errors: []
  id: service

...
```

And that's how you can write your own identifier.