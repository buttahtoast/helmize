+++
title = "Post Renderers"
description = "Custom Post Renderers"
weight = 3
+++

You can implement your own post renderer templates. Post Renderers are executed after all the files are merged within the train. They allow to make changes on the resulting manifests or even validate the integrity of the content.

# Configuration


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