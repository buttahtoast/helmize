
+++ 
title = "Quickstart" 
description = "Quickstart" 
weight = 2 
+++

{{< hint "info" >}}If you encounter any problems during the quickstart make sure to use the [flags](../../usage/flags). They help to understand what's going on and what might be the problem.

[https://github.com/buttahtoast/helmize/tree/main/examples/reference](https://github.com/buttahtoast/helmize/tree/main/examples/reference){{< /hint >}}

First we create a new helm chart which is going to contain the entire deployment structure for helmize. We can simply do that with the following comment (In this case I will call the new chart `reference`, chose the name you would like):

```Shell
helm create reference && cd reference/
```

We can clear the `templates/*` content and the ǜalues.yaml, since we are going to recreate them.

```Shell
rm -rf templates/* && rm -f values.yaml && cd reference/
```

Now we add **helmize** as new [chart dependency](https://helm.sh/docs/helm/helm_dependency/) (Check out the release page or artifacthub to get the latest helmize version):

```Shell
cat << EOF >> ./Chart.yaml
dependencies:
- name: helmize
  # Make sure to use a fixed version
  version: ">=0.0.0-0"
  repository: "https://helmize.dev/"
EOF
```

Update dependencies to download the specified version for helmize:

```Shell
helm dependency update
```

Now we need to add a template which includes the entrypoint for helmize:


```Shell
cat << EOF > ./templates/deploy.yaml
{{- include "helmize.deploy" $ | nindent 0 }}
EOF
```

Now we create a very simplistic configuration in the chart root. This configuration reads all files which are located in `structure/base/`

```Shell
cat << EOF > ./helmize.yaml
inventory_directory: "structure/"
conditions:
  - name: "base"
    path: "/base/"
    any: true
EOF
```

With this initial configuration we have added a base directory which will lookup all files within (it's not reuired to have a base condition).

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
# Identifers: [service-frontend.yaml]
# Subpath: podinfo
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
# Identifers: [deployment-frontend.yaml]
# Subpath: podinfo
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

## Conditions

[Read more on conditions](../../configuration/helmize/conditions/)

For the quickstart we are going to add two conditions on top of the base condition called `environment` and `location`

### Environment

Now we want to add a condition, that podinfo is different names on different environments. The environment can be controlled via the values of the chart. The Value which is considered is defined under `key` which points to `$.Values.env`. If no value is given the `default` of `test` is applied. With the `filter` we define, that only `test` and `prod` are accepted as value. Files for this condition are located under `structure/env/{value}`:

```Shell
cat << EOF > ./helmize.yaml
inventory_directory: "structure/"
conditions:
  - name: "base"
    path: "/base/"
    any: true

  - name: "environment"
    key: "env"
    path: "env/"
    default: "test"
    filter: [ "test", "prod" ]
    reverse_filter: true
EOF    
```

Now we add two new structures for the environment `test`and `prod`


{{< expand "Test Environment" "..." >}}

Create Directory based on condition configuration
```Shell
mkdir -p structure/env/test/podinfo/
```

Create under the same path as in the base (`podinfo/deploy.yaml`) we want to merge over the file from the base. In this case we make some adjustments to the base deployment. We inject a different log level, change the UI color and overwrite the port number for the grpc port ([Read More on how the merge works](../../usage/templating#recursive-merges)). You can access to condition's Value via `$.Value`, that's not possible in the base deployment file.

```Shell
 cat << EOF > ./structure/env/test/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    env: {{ $.value }}
spec:
  progressDeadlineSeconds: 120
  template:
    spec:
      containers:
      - name: frontend
        command:
        - __inject__
        - --level=debug
        env:
        - name: PODINFO_UI_COLOR
          value: '#FAB418'
        ports:
        - __inject__
        - containerPort: 20000
          name: grpc
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

Since we defined `test` as `default` for the environment we can template via

```Shell
helm template .
```

or with explicit value

```Shell
helm template . --set "env=test"
```

If you try with any other environment Helmize will fail:

```
$ helm template . --set "env=dev"
Error: execution error at (reference/templates/deploy.yaml:1:4):

Found errors, please resolve those errors or use the force option (--set helmize.force=true):

  - condition: environment
    error: 'Value dev is not allowed (Allowed values: test, prod)'
```

When you try with `env=prod` you will get the same output as with the base. Since we don't have anything below `structure/env/prod/`. This condition slecets based on the value of `$.Values.env`.


Both will result in the same output. Based on the output you can see that the `hpa.yaml` file is now rendered as well, but only if the environment is `test`. The Deployment files were also merged, since they both resolve into the subpath `podinfo/deploy.yaml`underneath their condition folders.

{{< expand "Test Environment" "..." >}}

```YAML
---
# Source: reference/templates/deploy.yaml
# Identifers: [service-frontend.yaml]
# Subpath: podinfo
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
# Identifers: [deployment-frontend.yaml]
# Subpath: podinfo
# Checksum 576057612df9b3ceaae50d87000ad7b171deb16d870cd284e21a41b1bbb9248f
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    env: test
  name: frontend
spec:
  minReadySeconds: 3
  progressDeadlineSeconds: 120
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
        - --level=debug
        env:
        - name: PODINFO_UI_COLOR
          value: '#FAB418'
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
        - containerPort: 20000
          name: grpc
          protocol: TCP
        - containerPort: 9898
          name: http
          protocol: TCP
        - containerPort: 9797
          name: http-metrics
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
# Identifers: [horizontalpodautoscaler-frontend.yaml]
# Subpath: podinfo
# Checksum b3e231fd6bc48aa8e1c94208952372b01cec1f7afb7b756c386cd38d007bb976
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
    name: frontend-test
```    
{{< /expand >}}


{{< /expand >}}

{{< expand "Prod Environment" "..." >}}

Create Directory based on condition configuration
```Shell
mkdir -p structure/env/prod/podinfo/
```

Create under the same path as in the base (`podinfo/deploy.yaml`) we want to merge over the file from the base. For prod we just change the log level for the frontend.  You can access to condition's Value via `$.Value`, that's not possible in the base deployment file.

```Shell
cat << EOF > ./structure/env/prod/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    env: {{ $.value }}
spec:
  template:
    spec:
      containers:
      - name: frontend
        command:
        - __inject__
        - --level=info
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
# Identifers: [service-frontend.yaml]
# Subpath: podinfo
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
# Identifers: [deployment-frontend.yaml]
# Subpath: podinfo
# Checksum 927e03253e8b730aa0b982bba87da4eeab0349419e120476446823b95e0ba7a1
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    env: prod
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
        - --level=info
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
conditions:
  - name: "base"
    path: "/base/"
    any: true

  - name: "environment"
    key: "env"
    path: "env/"
    default: "test"
    filter: [ "test", "prod" ]
    reverse_filter: true

  - name: "location"
    key: "location"
    default: "east"
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
    location: {{ $.value }}
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

Found errors, please resolve those errors or use the force option (--set helmize.force=true):

  - error: 'error converting YAML to JSON: yaml: line 5: mapping values are not allowed
      in this context'
    file: structure/location/east/podinfo/deploy.yaml
    trace: |
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels
          location: east

Use --debug flag to render out invalid YAML
```
{{< /expand >}}

Let's fix this error

```Shell
cat << EOF > ./structure/location/east/podinfo/deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    location: {{ $.value }}
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
  name: frontend
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

As seen with these two examples, conditions are a great mechanism to combine different indepdendent factors. You can extended the conditions at anytime without restructering the entire folder structure.

### Conditional Data

Throughout the entire rendering process you can access the different data contexts and add logic to the given values. Now we add a new condition, which evaluates the required data, to atuomaticaly adjust the ingress based on previous cdonditions.


```Shell
cat << EOF > ./helmize.yaml
inventory_directory: "structure/"
conditions:
  - name: "base"
    path: "/base/"
    any: true

  - name: "environment"
    key: "env"
    path: "env/"
    default: "test"
    filter: [ "test", "prod" ]
    reverse_filter: true

  - name: "location"
    key: "location"
    default: "east"

  - name: "expose"
    any: true
    data:
      ingress_class: "company-domain"
    tpls:
      - tpls/ingress.tpl
EOF    
```

This condition implements a [data template](../../configuration/helmize/conditions#tpls) which evaluates data. This template can use sprig. and you can add as many as you want, just make sure they return valid yaml. In addition we declare static [data](../../configuration/helmize/conditions#data). Now let's create the template:


```Shell
mkdir -p tpls/
```

This template evaluates the field `ingress_name` based on the previous values from conditions. This is a very simple example, you can increase the complexity by as much as you are comfortable with :).

```Shell
cat << EOF > ./helmize.yaml
{{/* Default Variables */}}
{{- $env := "" -}}
{{- $location := "" -}}

{{/* Iterate over previous Conditions */}}
{{- range $c := $.conditions -}}

  {{/* Evaluate Environment */}}
  {{- if (eq $c.name "environment") -}}
    {{- $env = default "" $c.value -}}

  {{/* Evaluate Location */}}
  {{- else if (eq $c.name "location") -}}
    {{- $location = default "" $c.value -}}
  {{- end -}}

{{- end -}}

{{/* Return Data */}}
ingress_name: frontend.{{ $env }}.{{ $location }}.company.com
EOF    
```

Now lets create the file which will implement this data.

```Shell
mkdir -p structure/expose/
```

This template accesses the data. Since it's coming from the condition, which sources the ingress, it can directly access the data via `$.data`. You could also do the same evaluation within this template, since you can access `$.conditions` in this context as well. This decision really comes down to how reusable the data must be and how many files implement it.

```Shell
cat << EOF > ./structure/expose/ingress.tpl
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: frontend
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  {{- with $.data.ingress_class }}
  ingressClassName: {{ . }}
  {{- end }}
  tls:
  - hosts:
      - {{ $.data.ingress_name }}
    secretName: frontend-tls
  rules:
  - http:
      paths:
      - host: {{ $.data.ingress_name }}
        path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
EOF    
```

Templating this, will result in a different ingress based on previous conditions, truly value driven. These were some very simple examples on how Helmize works.

**Helmize has a lot to offer, are you ready to explore it's possabilities?**