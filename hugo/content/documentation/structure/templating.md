+++
title = "Templating"
description = "Templating"
weight = 2
+++


# Context 


  * **$.Value**: The Value of the condition which is running (selected the file)
  * **$.Data**: The Shared Data Structure. [Read More](../data).


Here as visualization: 

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

## Value 
Value: ...

## Data
Data:
  ...

## Global Helm Context
ctx:
  ...
```


