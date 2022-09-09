+++
title = "Custom Template"
description = "Custom Identifier Template"
weight = 3
+++

{{< hint "info" >}}**Example** [https://github.com/buttahtoast/helmize/tree/main/examples/example-customization](https://github.com/buttahtoast/helmize/tree/main/examples/example-customization){{< /hint >}}

You can implement your own identifier template, if ours is not practical for you. Let's see how it's done.

## Configuration

General configuration for Identifiers.

### Assignment

After the Identifier template is executed, the content in `$.wagon.id` is considered as the result of the template and is used for each file. Should the value of this field be unset or empty, the filename of the current executed file is used. You should avoid using the filename because it may result in unwanted behavior if you have [multi yaml files](../../yaml). The value for `$.wagon.id` is directly set on the context eg.

```
{{- define "customization.identifier.template" -}}
  {{- $_ := set $.wagon "id" "sample" -}}
{{- end -}}
```

### Return

The following return values (YAML Print) are considered:

* `errors` - `<slice>` <br>
  A list of errors which occured during identifier evaluation. The error will make helmize fail with your error message. 

* `debug` - `<slice>` <br>
  Debug output which can be seen in summary (If something isn't doing what you thought it does).

The Values are not required to be returned, only if you would like to invoke error/debug messages. 

#### Validation

The returned YAML is validated, if the YAML is not valid an error is thrown:

```
Template customization.identifier.template returned invalid YAML (error converting YAML to JSON: yaml: line 1: did not find expected key):

  debug: []
  errors: []debug: []
  errors: []
```

In this case your printed YAML from the template is wrong, please fix.

### Template

Here's a minimalstic Post Renderer template to get started.

```go-text-template
{{- define "customization.identifier.template" -}}
  {{- $return := dict "errors" list "debug" list -}}

  {{/* Identifier Logic */}}
  ... 

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}
```


### Context

An Identifier template receives the following context (Values Change per File):

{{< expand "Context" "..." >}}
```yaml
# Wagon (Current File) information
wagon:
  config:
    fork: false
    no_match: append
    pattern: false
    render: true
    subpath: true
  debug: []
  errors: []
  file_id:
    file: structure/additional/new_deploy.yaml
    filename: new_deploy.yaml
    path: structure/additional
  id: []
  post_renderers:
  - customization.postrenderers.additional
  render: true
  subpath: .
  content:
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        app: web
      name: new-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: new-deployment
      strategy:
        type: RollingUpdate
      template:
        metadata:
          labels:
            app: new-deployment
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
            - name: DEMO_GREETING
              value: Hello from the environment
            - name: DEMO_FAREWELL
              value: Such a sweet sorrow
            - name: EXISTING_VAR
              value: Some existing value
            image: nginx
            name: nginx
            ports:
            - containerPort: 80

## Global Helm Context
ctx:
  ...
```
{{< /expand >}}

## Example


Let's create a new Render template which only renders resources, if a specific annotation is set.

{{< expand "templates/_identifier.tpl" "..." >}}

The identifier calls the default identifier template first. Then it's checked if there's a field set in the content of a file called `super_identifier`. If that's true, the value of said field is matched against a dns-1123 regex. If the regex matches, the value is set as only identifier for the file, overwriting all the other identifiers. A debug message is added indicating, that a super identifier was assigned. If the regex does not match, an error is thrown. If the field `super_identifier` is not set, nothing happens.


```go-text-template
{{- define "customization.identifier.template" -}}
  {{- $return := dict "errors" list "debug" list -}}

  {{/* Execute the default identifier Template (Redirect it's output into nowhere) */}}
  {{- $_ := include (include "helmize.config.defaults.identifier_template.value" $) $ -}}

  {{/* Lookup field super identifier, an Overwrite existing ids, if present */}}
  {{- $content_path := "super_identifier" -}}
  {{- $super_identifier := (default "" (fromYaml (include "lib.utils.dicts.get" (dict "path" $content_path "data" $.wagon.content))).res) -}}
       
  {{/* Super Identifier */}}
  {{- if $super_identifier -}}

    {{/* DNS1123 Regex (Simplified) */}}
    {{- $regex := "^[A-Za-z0-9_.]{1,63}$" -}}

    {{/* Verify if name matches DNS1123 Regex */}}
    {{- if (regexMatch $regex $super_identifier) -}}
      
       {{/* Assign Identifier */}}
       {{- $_ := set $.wagon "id" $super_identifier -}}

       {{/* Debug */}}
       {{- $_ := set $return "debug" (append $return.debug (printf "%s is a super identifier" $super_identifier)) -}}
    
       {{/* Remove Field from Content */}}
       {{- include "lib.utils.dicts.unset" (dict "path" $content_path "data" $.wagon.content) -}}

    {{/* Throw Error */}}
    {{- else -}}
      {{- $_ := set $return "errors" (append $return.errors (printf "%s did not match regex %s" $super_identifier $regex)) -}}
    {{- end -}}
  {{- end -}}

  {{- printf "%s" (toYaml $return) -}}
{{- end -}}
```
{{< /expand >}}

Once the identifier template is created we need to reference in the [configuration](#reference):

```yaml
identifier_template: "customization.identifier.template"
conditions:
  - name: "resources"
    allow_root: true
  - name: "additional"
    allow_root: true
```