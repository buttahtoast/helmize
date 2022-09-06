+++
title = "Templating"
description = "Templating"
weight = 1
+++

## Library

Helmize comes with our helm library as dependency. The library provides a lot of functions which simplify the maniplution of dicts, slices, etc. You should definitly make use of it's functionalities. See the full documentation of the library chart here:

  * [https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates](https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates)

## Contexts

Contexts are data structures. In Sprig a template receives a context. Based on which context is given, you have acces to certain data.

### Train Context

The train is a construct which mainly holds the general configuration and consists of [wagons](#wagon).

{{< expand "Train Context" "..." >}}
```
# Conditions from Configuration
conditions:
- config:
    any: true
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
    any: true
    key_types:
    - string
    - slice
    name: additional
    post_renderers:
    - customization.renderers.additional
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
    # Content omitted
    # ...
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
       # Content omitted
       # ...
    path: structure/resources/
    renderers: []
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
  renderer: customization.postrenderers.sidecar
```
{{< /expand >}}

### Wagon Context

A wagon is the construct which abstracts a group of files into one file. The files are grouped into wagons based on their identifier. The Train is a list of wagon contexts.


{{< expand "Wagon Context" "..." >}}
```
# Checksum is added after all the content is templated. The checksum is based on the value of the content field.
checksum: 89b40c1c4e999c31f80f37a5cd49e582e81a15a6ed64b97f64921c3bfeeb29cc

# Combined content of all files
content: {}

# Render State
render: true

# Indicates if this wagon was forked, only present when Wagon is a fork.
fork: true

# Holds all identifiers for this file
id:
- deployment
- deployment.yaml

# The subpath the files originated from
subpath: .

# All Executed Post-Renderers for this file in execution order
renderers: 
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

  # Renderers given by Conditions
  renderers: []

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
  renderers: []
  value: {}

# Debug Messages (Given by Identifier/Post Render Templates)
debug: []

# Error Messages (Given by Identifier/Post Render Templates)
errors:
  - error: No Kind Defined
    file:
    - deployment
    renderer: customization.postrenderers.sidecar
```
{{< /expand >}}


### Global Context

The Global Context is the default helm context for a chart enriched with some extra fields for helmize.

{{< expand "Global Context" "..." >}}
```
# Helmize Configuration (1)
Config:
  benchmark: false
  conditions:
  - any: true
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
  renderers:
  - customization.postrenderers.sidecar
  - customization.postrenderers.env
  - customization.postrenderers.context
  render_template: helmize.entrypoint.templates.render
  show_config: false
  summary: false

# Condition Data (2)  
Data: {}

# Condition Value (3)
Value: {}

# Wagon Context of current file (4)
Wagon: <Wagon Context>


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
```
{{< /expand >}}