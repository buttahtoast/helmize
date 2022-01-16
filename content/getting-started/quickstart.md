
+++ 
title = "Quickstart" 
description = "Quickstart" 
weight = 2 
+++

First we create a new helm chart which is going to contain the entire deployment structure for helmize. We can simply do that with the following comment (In this case I will call the new chart `reference`, chose the name you would like):

```Shell
helm create reference && cd reference/
```

We can clear the `templates/*` content and the ǜalues.yaml, since we are going to recreate them.

```Shell
rm -rf templates/* && rm -f values.yaml
```

Now we add **helmize** as new [chart dependency](https://helm.sh/docs/helm/helm_dependency/) (Check out the release page or artifacthub to get the latest helmize version):

```Shell
# Chart.yaml
...
dependencies:
- name: helmize
  # Make sure to use a fixed version
  version: ">=0.0.0-0"
  repository: "https://buttahtoast.github.io/helm-charts/"
...
```

Update dependencies to download the specified version for helmize:

```Shell
helm dependency update
```

Now we need to add a template which includes the entrypoint for helmize:


```Shell
cat << EOF > ./templates/deploy.yaml
{{- include "inventory.entrypoint.func.deploy" $ | nindent 0 }}
EOF
```

Now we create a very simplistic configuration in the chart root:

```Shell
cat << EOF > ./helmize.yaml
inventory_directory: "structure/"
templates_directory: "tpls/"
conditions:
  - name: "base"
    path: "/base/"
    allow_root: true
EOF
```

With this initial configuration we have added a base directory which will lookup all files within.

## Structure

Now we start creating our structure for the chart. We want to deploy [podinfo](https://github.com/stefanprodan/podinfo) (just the deployment) in the referenced base:

```Shell
mkdir -p structure/base/podinfo
```

Under the structure we create some files so we can see the influence of helmize

{{< expand "Base Files" "..." >}}

Create Deployment file

```Shell
cat << EOF > ./structure/base/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  minReadySeconds: 3
  revisionHistoryLimit: 5
  progressDeadlineSeconds: 60
  strategy:
    rollingUpdate:
      maxUnavailable: 0
    type: RollingUpdate
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9797"
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: ghcr.io/stefanprodan/podinfo:6.0.3
        imagePullPolicy: IfNotPresent
        ports:
        - name: http
          containerPort: 9898
          protocol: TCP
        - name: http-metrics
          containerPort: 9797
          protocol: TCP
        - name: grpc
          containerPort: 9999
          protocol: TCP
        command:
        - ./podinfo
        - --port=9898
        - --port-metrics=9797
        - --level=info
        - --backend-url=http://backend:9898/echo
        - --cache-server=cache:6379
        env:
        - name: PODINFO_UI_COLOR
          value: "#34577c"
        livenessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/healthz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        readinessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/readyz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        resources:
          limits:
            cpu: 1000m
            memory: 128Mi
          requests:
            cpu: 100m
            memory: 32Mi
EOF
```

Create Service file

```Shell
cat << EOF > ./structure/base/podinfo/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend
spec:
  type: ClusterIP
  selector:
    app: frontend
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: http
EOF
```
{{< /expand >}}

After you have added those files and execute a template command:

```Shell
helm template . 
```

The result should not be surprising, for now the two new added files are just rendererd with additional comments.

{{< expand "Template Result" "..." >}}
```YAML
---
# Source: reference/templates/deploy.yaml
# File: podinfo/service.yaml
# Checksum 08b06c48a587e3fe6179875f70331bb97562a6e584dcb32807ce9eac7572fc8d
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
---
# Source: reference/templates/deploy.yaml
# File: podinfo/deploy.yaml
# Checksum 71f6b6d50be2ddace75a2259b577150467e85a80c2c29a10dd402446edb028b8
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  minReadySeconds: 3
  progressDeadlineSeconds: 60
  revisionHistoryLimit: 5
  selector:
    matchLabels:
      app: frontend
  strategy:
    rollingUpdate:
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        prometheus.io/port: "9797"
        prometheus.io/scrape: "true"
      labels:
        app: frontend
    spec:
      containers:
      - command:
        - ./podinfo
        - --port=9898
        - --port-metrics=9797
        - --level=info
        - --backend-url=http://backend:9898/echo
        - --cache-server=cache:6379
        env:
        - name: PODINFO_UI_COLOR
          value: '#34577c'
        image: ghcr.io/stefanprodan/podinfo:6.0.3
        imagePullPolicy: IfNotPresent
        livenessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/healthz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        name: frontend
        ports:
        - containerPort: 9898
          name: http
          protocol: TCP
        - containerPort: 9797
          name: http-metrics
          protocol: TCP
        - containerPort: 9999
          name: grpc
          protocol: TCP
        readinessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/readyz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        resources:
          limits:
            cpu: 1000m
            memory: 128Mi
          requests:
            cpu: 100m
            memory: 32Mi
```
{{< /expand >}}

## Condition

[Read more on conditions](../documentation/configuration/conditions/)

For the quickstart we are going to add two conditions on top of the base condition called `environment` and `location`

### Environment

Now we want to add a condition, that podinfo is different names on different environments. The environment can be controlled via the values of the chart. 

```Shell
cat << EOF > ./helmize.yaml
inventory_directory: "structure/"
templates_directory: "tpls/"
conditions:

  - name: "base"
    path: "/base/"
    allow_root: true

  - name: "environment"
    key: "Values.env"
    path: "env/"
    default: "test"
    filter: [ "test", "prod" ]
    reverseFilter: true
EOF    
```

Now we add two new structures for the environment `test`and `prod`


{{< expand "Test Environment" "..." >}}

Create Directory based on condition configuration
```Shell
mkdir -p structure/env/test/podinfo/
```

Create under the same path as in the base (`podinfo/deploy.yaml`) we want to merge over the file from the base. In thase case we adjust the `name` and the `minReadySeconds` properties.

```Shell
cat << EOF > ./structure/env/test/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-test
spec:
  minReadySeconds: 10
EOF        
```

Create a HPA resource which should only be deployed on test 

```Shell
cat << EOF > ./structure/env/test/podinfo/hpa.yaml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: frontend
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: frontend-test
  minReplicas: 1
  maxReplicas: 4
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 99
EOF
```

Since we defined `test` as default for the environment we can template via

```Shell
helm template .
```

or with explicit value

```Shell
helm template . --set "env=test"
```

Both will result in the same output. Based on the output you can see that the `hpa.yaml` file is now rendered as well, but only if the environment is `test`. The Deployment files were also merged, since they both resolve into the subpath `podinfo/deploy.yaml`underneath their condition folders.

{{< expand "Test Environment" "..." >}}

```YAML
---
# Source: reference/templates/deploy.yaml
# File: podinfo/service.yaml
# Checksum 08b06c48a587e3fe6179875f70331bb97562a6e584dcb32807ce9eac7572fc8d
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
---
# File: podinfo/deploy.yaml
# Checksum 30852c17c788e196ef62884c2e5bb092472a3b6b02d035bf39cdcbf6b54fc5e3
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-test
spec:
  minReadySeconds: 10
  progressDeadlineSeconds: 60
  revisionHistoryLimit: 5
  selector:
    matchLabels:
      app: frontend
  strategy:
    rollingUpdate:
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        prometheus.io/port: "9797"
        prometheus.io/scrape: "true"
      labels:
        app: frontend
    spec:
      containers:
      - command:
        - ./podinfo
        - --port=9898
        - --port-metrics=9797
        - --level=info
        - --backend-url=http://backend:9898/echo
        - --cache-server=cache:6379
        env:
        - name: PODINFO_UI_COLOR
          value: '#34577c'
        image: ghcr.io/stefanprodan/podinfo:6.0.3
        imagePullPolicy: IfNotPresent
        livenessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/healthz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        name: frontend
        ports:
        - containerPort: 9898
          name: http
          protocol: TCP
        - containerPort: 9797
          name: http-metrics
          protocol: TCP
        - containerPort: 9999
          name: grpc
          protocol: TCP
        readinessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/readyz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        resources:
          limits:
            cpu: 1000m
            memory: 128Mi
          requests:
            cpu: 100m
            memory: 32Mi
---
# Source: reference/templates/deploy.yaml
# File: podinfo/hpa.yaml
# Checksum 4669de4bb6631c64c7459e44b38c32a1236a0b7fb419b642d4a52b76ff51747c
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
```    
{{< /expand >}}


{{< /expand >}}

{{< expand "Prod Environment" "..." >}}

Create Directory based on condition configuration
```Shell
mkdir -p structure/env/prod/podinfo/
```

Create under the same path as in the base (`podinfo/deploy.yaml`) we want to merge over the file from the base. In thase case we adjust the `name` and the `minReadySeconds` properties.

```Shell
cat << EOF > ./structure/env/prod/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-prod
spec:
  minReadySeconds: 10
EOF
```

For production we have to set the environment explicit

```Shell
helm template . --set "env=prod"
```

The Deployment files were also merged, since they both resolve into the subpath `podinfo/deploy.yaml` underneath their condition folders.

{{< expand "Prod Environment" "..." >}}

```YAML
---
# Source: reference/templates/deploy.yaml
# File: podinfo/service.yaml
# Checksum 08b06c48a587e3fe6179875f70331bb97562a6e584dcb32807ce9eac7572fc8d
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
---
# File: podinfo/deploy.yaml
# Checksum f5f1922876fe509774c40afbd4576984bd3a952f248a3601a424966544a33892
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-prod
spec:
  minReadySeconds: 10
  progressDeadlineSeconds: 60
  revisionHistoryLimit: 5
  selector:
    matchLabels:
      app: frontend
  strategy:
    rollingUpdate:
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        prometheus.io/port: "9797"
        prometheus.io/scrape: "true"
      labels:
        app: frontend
    spec:
      containers:
      - command:
        - ./podinfo
        - --port=9898
        - --port-metrics=9797
        - --level=info
        - --backend-url=http://backend:9898/echo
        - --cache-server=cache:6379
        env:
        - name: PODINFO_UI_COLOR
          value: '#34577c'
        image: ghcr.io/stefanprodan/podinfo:6.0.3
        imagePullPolicy: IfNotPresent
        livenessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/healthz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        name: frontend
        ports:
        - containerPort: 9898
          name: http
          protocol: TCP
        - containerPort: 9797
          name: http-metrics
          protocol: TCP
        - containerPort: 9999
          name: grpc
          protocol: TCP
        readinessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/readyz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        resources:
          limits:
            cpu: 1000m
            memory: 128Mi
          requests:
            cpu: 100m
            memory: 32Mi
```    
{{< /expand >}}

{{< /expand >}}

As you can see the output changes based on the input of the chart. 

### Location 

Let's add a condition for the location. The location should also be controllable via Values of the chart.

```Shell
cat << EOF > ./helmize.yaml
inventory_directory: "structure/"
templates_directory: "tpls/"
conditions:

  - name: "base"
    path: "/base/"
    allow_root: true

  - name: "environment"
    key: "Values.env"
    path: "env/"
    default: "test"
    filter: [ "test", "prod" ]
    reverseFilter: true

  - name: "location"
    key: "Values.location"
EOF    
```

Now we add two new structures for the location `east` and `west`


{{< expand "East Environment" "..." >}}

Create Directory based on condition configuration
```Shell
mkdir -p structure/location/east/podinfo/
```

Create under the same path as in the base (`podinfo/deploy.yaml`) we want to merge over the file from the base. We just add a location label to identify the deployment.

```Shell
cat << EOF > ./structure/location/east/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels
    location: "east"
EOF        
```

{{< hint info >}}
There is on purpose an error in the above YAML to show you what happens in such a case
{{< /hint >}}

Now we can start combining two condiditions. So for now let's select `prod` as environment and `east` as location

```Shell
helm template . --set "env=prod" --set "location=east"
```

There's an error!

{{< expand "Template Error" "..." >}}
```Shell
Error: execution error at (reference/templates/deploy.yaml:1:4): 
Found errors in render manifest, please resolve those errors or use the force options:
  - error: 'error converting YAML to JSON: yaml: line 5: mapping values are not allowed
      in this context'
    file: structure/location/east/podinfo/deploy.yaml
    trace: |
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels
          location: "east"
```
{{< /expand >}}

Let's fix this error

```Shell
cat << EOF > ./structure/location/east/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    location: "east"
EOF        
```

Now if we try the same template command again we get a result that looks much more like what we are looking for. As you can see we combined the two conditions `prod` and `east`. But we can do the exact same thing with every environment with every location, just by changing the values.


{{< /expand >}}

{{< expand "West Environment" "..." >}}

Create Directory based on condition configuration

```Shell
mkdir -p structure/location/west/podinfo/
```

Create under the same path as in the base (`podinfo/deploy.yaml`) we want to merge over the file from the base. We just add a location label to identify the deployment.

```Shell
cat << EOF > ./structure/location/west/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    location: "west"
EOF        
```

Now we can start combining two condiditions. So for now let's select `test` as environment and `west` as location

```Shell
helm template . --set "env=test" --set "location=west"
```

Now if we try the same template command again we get a result that looks much more like what we are looking for. As you can see we combined the two conditions `test` and `west`. But we can do the exact same thing with every environment with every location, just by changing the values.

{{< expand "Test & West Environment" "..." >}}
```YAML
---
# Source: reference/templates/deploy.yaml
# File: podinfo/service.yaml
# Checksum 08b06c48a587e3fe6179875f70331bb97562a6e584dcb32807ce9eac7572fc8d
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
---
# File: podinfo/deploy.yaml
# Checksum 3e8abeffd025ba5352bc97ab5cfb545902285dec8d27b6d1d46b8f44affd633b
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    location: west
  name: frontend-test
spec:
  minReadySeconds: 10
  progressDeadlineSeconds: 60
  revisionHistoryLimit: 5
  selector:
    matchLabels:
      app: frontend
  strategy:
    rollingUpdate:
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        prometheus.io/port: "9797"
        prometheus.io/scrape: "true"
      labels:
        app: frontend
    spec:
      containers:
      - command:
        - ./podinfo
        - --port=9898
        - --port-metrics=9797
        - --level=info
        - --backend-url=http://backend:9898/echo
        - --cache-server=cache:6379
        env:
        - name: PODINFO_UI_COLOR
          value: '#34577c'
        image: ghcr.io/stefanprodan/podinfo:6.0.3
        imagePullPolicy: IfNotPresent
        livenessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/healthz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        name: frontend
        ports:
        - containerPort: 9898
          name: http
          protocol: TCP
        - containerPort: 9797
          name: http-metrics
          protocol: TCP
        - containerPort: 9999
          name: grpc
          protocol: TCP
        readinessProbe:
          exec:
            command:
            - podcli
            - check
            - http
            - localhost:9898/readyz
          initialDelaySeconds: 5
          timeoutSeconds: 5
        resources:
          limits:
            cpu: 1000m
            memory: 128Mi
          requests:
            cpu: 100m
            memory: 32Mi
---
# Source: reference/templates/deploy.yaml
# File: podinfo/hpa.yaml
# Checksum 4669de4bb6631c64c7459e44b38c32a1236a0b7fb419b642d4a52b76ff51747c
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
```    
{{< /expand >}}

{{< /expand >}}