+++
title = "Files"
description = "Files"
weight = 1
+++

{{< toc-tree >}}



# Context

Within the Root context per File `$` you can access the global Helm context, as usual.

## Dropins

In Files you can access the data from Dropins via `$.Data`. So if you configured a dropin like this:

**helmize.yaml**
```YAML
...

dropins: 
  - patterns: [ ".*" ]
    data:
      elasticsearch:
        endpoint: "http://logging.company.com"
        port: 9200

``` 

You can access it in a file via: 

**structure/base/beat.yaml**
``` 
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: filebeat
  namespace: kube-system
  labels:
    k8s-app: filebeat
spec:
  selector:
    matchLabels:
      k8s-app: filebeat
  template:
    metadata:
      labels:
        k8s-app: filebeat
    spec:
      containers:
      - name: filebeat
        image: docker.elastic.co/beats/filebeat:8.0.0
        env:
        - name: ELASTICSEARCH_HOST
          value: {{ $.Data.elasticsearch.endpoint }}
        - name: ELASTICSEARCH_PORT
          value: {{ $.Data.elasticsearch.port }}
...
``` 

