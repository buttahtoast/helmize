+++
title = "Templating"
description = "Templating"
weight = 1
+++


# Library

Helmize comes with our helm library as dependency. The library provides a lot of functions which simplify the maniplution of dicts, slices, etc. You should definitly make use of it's functionalities. See the full documentation of the library chart here:

  * [https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates](https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates)


# Templates


## Library


## Access Configuration




# Contexts

Contexts are data structures. Templates 

## Train Context

{{< expand "Train Context" "..." >}}
```
# Conditions from Configuration
conditions:
- config:
    allow_root: true
    key_types:
    - string
    - slice
    name: resources
  data: {}
  errors: []
  keys:
  - /
  name: resources
  paths:
  - structure/resources/
  root_path: resources
  value: {}
- config:
    allow_root: true
    key_types:
    - string
    - slice
    name: additional
    post_renderers:
    - customization.postrenderers.additional
  data: {}
  errors: []
  keys:
  - /
  name: additional
  paths:
  - structure/additional/
  root_path: additional
  value: {}

# Origins of files
paths:
- _order: 0
  config:
    fork: false
    no_match: append
    pattern: false
    render: true
    subpath: true
  data: {}
  file: structure/resources/daemonset.yaml
  ids:
  - daemonset-octopus-deployment.yaml
  partial_files:
  - |-
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: octopus-deployment
      labels:
        app: web
    spec:
      selector:
        matchLabels:
          octopusexport: OctopusExport
      updateStrategy:
        type: RollingUpdate
      template:
        metadata:
          labels:
            app: web
            octopusexport: OctopusExport
        spec:
          containers:
            - name: nginx
              image: nginx
              ports:
                - containerPort: 80
              env:
                - name: DEMO_GREETING
                  value: "Hello from the environment"
                - name: DEMO_FAREWELL
                  value: "Such a sweet sorrow"
                - name: EXISTING_VAR
                  value: "Some existing value"
          affinity:
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
                - weight: 100
                  podAffinityTerm:
                    labelSelector:
                      matchExpressions:
                        - key: app
                          operator: In
                          values:
                            - web
                    topologyKey: kubernetes.io/hostname
  path: structure/resources/
  post_renderers: []
  value: {}
  - _order: 1
    config:
      fork: false
      no_match: append
      pattern: false
      render: true
      subpath: true
    data: {}
    file: structure/resources/deploy.yaml
    ids:
    - deployment-octopus-deployment.yaml
    partial_files:
    - |-
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: octopus-deployment
        labels:
          app: web
      spec:
        selector:
          matchLabels:
            octopusexport: OctopusExport
        replicas: 1
        strategy:
          type: RollingUpdate
        template:
          metadata:
            labels:
              app: web
              octopusexport: OctopusExport
          spec:
            containers:
              - name: nginx
                image: nginx
                ports:
                  - containerPort: 80
                env:
                  - name: DEMO_GREETING
                    value: "Hello from the environment"
                  - name: DEMO_FAREWELL
                    value: "Such a sweet sorrow"
                  - name: EXISTING_VAR
                    value: "Some existing value"
            affinity:
              podAntiAffinity:
                preferredDuringSchedulingIgnoredDuringExecution:
                  - weight: 100
                    podAffinityTerm:
                      labelSelector:
                        matchExpressions:
                          - key: app
                            operator: In
                            values:
                              - web
                      topologyKey: kubernetes.io/hostname
    path: structure/resources/
    post_renderers: []
    value: {}
  - _order: 2
    config:
      fork: false
      no_match: append
      pattern: false
      render: true
      subpath: true


# List of Wagons
wagons:
  - <Wagon Context>
  - <Wagon Context>

# Debug Messages (Transfered from Wagons)
debug: []

# Error Messages (Transfered from Wagons)
errors:
- error: No Kind Defined
  file:
  - deployment
  post-renderer: customization.postrenderers.sidecar
```
{{< /expand >}}

## Wagon Context

A wagon is the construct which abstracts a group of files into one file. The files are grouped into wagons based on their identifier. The Train is a list of wagon contexts.


{{< expand "Wagon Context" "..." >}}
```
# Checksum is added after all the content is templated. The checksum is based on the value of the content field.
checksum: 89b40c1c4e999c31f80f37a5cd49e582e81a15a6ed64b97f64921c3bfeeb29cc

# Combined content of all files
content: {}

# Render State
render: true

# Holds all identifiers for this file
id:
- deployment
- deployment.yaml

# The subpath the files originated from
subpath: .

# All Executed Post-Renderers for this file in execution order
post_renderers: 
  - customization.postrenderers.additional
  - customization.postrenderers.sidecar
  - customization.postrenderers.env

# Files which belong to this wagon (raw files)
files:

  # Order the file was processed
- _order: 1
   
  # Applied File Configuration
  config:
    fork: false
    no_match: append
    pattern: false
    render: true
    subpath: true

  # Data given by condition
  data: {}

  # File path in structure
  file: structure/resources/deploy.yaml

  # Folder path in structure
  path: structure/resources/

  # File Identifiers
  ids:
  - deployment-octopus-deployment.yaml

  # Post-Renderers given by Condition
  post_renderers: []

  # Condition Value
  value: {}

- _order: 5
  config:
    fork: false
    no_match: append
    pattern: false
    render: true
    subpath: true
  data: {}
  file: structure/additional/existing_deploy.yaml
  ids:
  - deployment-octopus-deployment.yaml
  path: structure/additional/
  post_renderers: []
  value: {}

# Debug Messages (Given by Identifier/Post Render Templates)
debug: []

# Error Messages (Given by Identifier/Post Render Templates)
errors:
  - error: No Kind Defined
    file:
    - deployment
    post-renderer: customization.postrenderers.sidecar
```
{{< /expand >}}


## Global Context

  * **$.Value**: The Value of the condition which is running (selected the file)
  * **$.Data**: The Shared Data Structure. [Read More](../data).


## Global Context

The Global Context is the default helm context for a chart enriched with some extra fields for helmize.

{{< expand "Global Context" "..." >}}
```
# Helmize Configuration
Config:
  benchmark: false
  conditions:
  - allow_root: true
    name: resources
  debug: false
  file_config_key: metadata.helmize
  file_extensions:
  - .yaml
  - .yml
  - .tpl
  force: true
  global: {}
  helmize: {}
  helmize_file: ""
  identifier_template: helmize.render.templates.identifier
  inventory_directory: structure/
  library:
    global: {}
  post_renderers:
  - customization.postrenderers.sidecar
  - customization.postrenderers.env
  - customization.postrenderers.context
  render_template: helmize.entrypoint.templates.render
  show_config: false
  summary: false

## Usual Helm Context

Values:
  given_values: "test"
  ...

Release:
  IsInstall: true
  IsUpgrade: false
  Name: release-name
  Namespace: default
  Revision: 1
  Service: Helm 

Template:
  BasePath: example-customization/templates
  Name: example-customization/templates/deploy.yaml

etc..

## The following 

# Combined Data (Influenced by )  
Data: {}

# The Value of the condition which selected this
Value: {}
```
{{< /expand >}}