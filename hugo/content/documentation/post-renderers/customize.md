+++
title = "Customize"
description = "Customize"
weight = 2
+++

You can add your own post renderers within your chart. Let’s see how it’s done.

# Context

A Post-Renderer template receives the following context:

```
## Shared Data Across Files
data:
  ...

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
File:
  debug: []
  errors: []
  id: service

## Global Helm Context
ctx:
  ...
```

# Return

An Post-Renderer templkate can have following return values (YAML Print):

* `content` - `<map>` <br>
  Content after post-renderer template. The content won't be merged with the content before the post-renderer. So you need to return the entire content.

* `errors` - `<list>` <br>
  A list of errors which occured during post-rendering. The error will make helmize fail with your error message. 

* `debug` - `<list>` <br>
  Debug output which can be seen in summary (If something isn't doing what you thought it does).


# Example

Let's create a new Post-Renderer which let's us enable file contents via dropins. We must create our Post-Renderer in the `templates` directory of our chart.

```Shell
mkdir -p templates/post-renders/
```
A Post-Renderer template is always expected to return a YAML with at least a `content` field

Then Let's add this Template under `templates/post-renders/_disabler.tpl`

```
{{- define "reference.post-renders.disabler" -}}
  {{- $return := dict "content" $.content -}}
  {{- if $.Data.disabled -}}
     {{- $_ := set $return "content" dict -}}
  {{- end -}}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}
```

NOTE


  {{- if $.content.metadata -}}
    {{- if $.ctx.Values.labels -}}
      {{- $_ := set $.content.metadata "labels" (mergeOverwrite (default $.content.metadata.labels) $.ctx.Values.labels) -}}
    {{- end -}}
    {{- if $.Data.labels -}}
      {{- $_ := set $.content.metadata "labels" (mergeOverwrite (default $.content.metadata.labels) $.Data.labels) -}}
    {{- end -}}
  {{- end -}}
  {{- $_ := set $.content.metadata "meow" (deepCopy $) -}}
  {{- printf "%s" (toYaml $.content) -}}




Now our post renderer is not yet included, we need to add it into the include template. 

Then Let's add this Template under `templates/post-renders/_includes.tpl`

```
{{- define "inventory.postrenders.includes" -}}
reference.post-renders.disabler
{{ include "inventory.postrenders.defaults.renders" $ }}
{{- end -}}
```
The include of `inventory.postrenders.defaults.renders` adds all the [built-in post-renderers](../built-in). If you don't add it, they won't be executed.





Since we include any files with the `*.tpl` ending in the `templates` directory this template will be used. If you want to be more explicit you would need to add only the `registry.tpl`


```Shell
cat << EOF >> ./helmize.yaml
dropins: 
  - patterns: [ ".*" ]
    data:
      labels:
        "custom.label": "data"
    tpls:
      - "registry.tpl"
EOF    
```

In the `structure/base/podinfo/deploy.yaml` we change the image to default on the registry if it's set, others use `ghcr.io`:

```
...
      - name: frontend
        image: {{ default "ghcr.io" $.Data.registry }}/stefanprodan/podinfo:6.0.3
        imagePullPolicy: IfNotPresent
...
```

Now if we template with the `registry` set, we should see it

```
helm template . --set registry="custom.registry"
```

So we can access the results of dropings via the `$.Data` map in our file structure. [Read More](../documentation/structure/files/)






# Errors

If you wan't to create an error in your Post-Renderer, you can return `errors` as list.



{{- define "inventory.postrenders.renders.annotations" -}}
  {{- $return := dict "content" $.content "errors" list -}}
  {{- if $return.content.metadata -}}
    {{- if $.ctx.Values.annotations -}}
      {{- $_ := set $return.content.metadata "annotations" (mergeOverwrite (default dict $return.content.metadata.annotations) $.ctx.Values.annotations) -}}
    {{- end -}}
    {{- if $.Data.annotations -}}
      {{- $_ := set $return.content.metadata "annotations" (mergeOverwrite (default dict $return.content.metadata.annotations) $.Data.annotations) -}}
    {{- end -}}
  {{- end -}}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}


# Context

This is the Context given to every Post-Renderer function

```YAML
## Under $.Data you can access all the data that's created from Dropins
Data:
  labels:
    custom.label: data
    registy.template: label

## Under $.File you can access all the file's current properties (including dropins)    
File:
  dropins:
    data:
      labels:
        custom.label: data
        registy.template: label
    lookup:
    - tpls/registry.tpl
    patterns:
    - .*
    templates:
    - tpls/registry.tpl
  errors: []
  files:
  - file: structure/base/podinfo/service.yaml
    path: structure/base/
  identifier: podinfo/service.yaml

## Under $.content you can access the file's content  
content:
  apiVersion: v1
  kind: Service
  metadata:
    labels:
      custom.label: data
      registy.template: label
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

## Under $.ctx you can access the global Helm context    
ctx:
  Capabilities:
    APIVersions:
    - v1
    - admissionregistration.k8s.io/v1
    - admissionregistration.k8s.io/v1beta1
    - internal.apiserver.k8s.io/v1alpha1
    - apps/v1
    - apps/v1beta1
    - apps/v1beta2
    - authentication.k8s.io/v1
    - authentication.k8s.io/v1beta1
    - authorization.k8s.io/v1
    - authorization.k8s.io/v1beta1
    - autoscaling/v1
    - autoscaling/v2beta1
    - autoscaling/v2beta2
    - batch/v1
    - batch/v1beta1
    - certificates.k8s.io/v1
    - certificates.k8s.io/v1beta1
    - coordination.k8s.io/v1beta1
    - coordination.k8s.io/v1
    - discovery.k8s.io/v1
    - discovery.k8s.io/v1beta1
    - events.k8s.io/v1
    - events.k8s.io/v1beta1
    - extensions/v1beta1
    - flowcontrol.apiserver.k8s.io/v1alpha1
    - flowcontrol.apiserver.k8s.io/v1beta1
    - networking.k8s.io/v1
    - networking.k8s.io/v1beta1
    - node.k8s.io/v1
    - node.k8s.io/v1alpha1
    - node.k8s.io/v1beta1
    - policy/v1
    - policy/v1beta1
    - rbac.authorization.k8s.io/v1
    - rbac.authorization.k8s.io/v1beta1
    - rbac.authorization.k8s.io/v1alpha1
    - scheduling.k8s.io/v1alpha1
    - scheduling.k8s.io/v1beta1
    - scheduling.k8s.io/v1
    - storage.k8s.io/v1beta1
    - storage.k8s.io/v1
    - storage.k8s.io/v1alpha1
    - apiextensions.k8s.io/v1beta1
    - apiextensions.k8s.io/v1
    HelmVersion:
      git_commit: 663a896f4a815053445eec4153677ddc24a0a361
      git_tree_state: clean
      go_version: go1.16.10
      version: v3.7.2
    KubeVersion:
      Major: "1"
      Minor: "22"
      Version: v1.22.0
  Chart:
    IsRoot: true
    apiVersion: v2
    appVersion: 1.16.0
...
```