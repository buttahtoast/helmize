+++
title = "Templating"
description = "Templating"
weight = 1
+++

## Files 

You can use templating in any file, with any extension. Helmize renders each file with [sprig](https://masterminds.github.io/sprig/) any validates, if it generates YAML output. You have access to the [file context](#file-context) within each file. Lets template! :) 
## Library

Helmize comes with our helm library as dependency. The library provides a lot of functions which simplify the maniplution of dicts, slices, etc. You should definitly make use of it's functionalities. See the full documentation of the library chart here:

  * [https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates](https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates)


### Recursive Merges

The mergering of files is not implement with the normal `merge` function from sprig. We have implemented our own merge function which allows the recusrive merging of list elements, which is per default not possible. Meaning you can merge the list objects from base data and new data and merge list elements of type dict based on an attribute. Which are crucial functionalities to reduce code and make life easier. See the documentation:

  * [https://artifacthub.io/packages/helm/buttahtoast/library#merge](https://artifacthub.io/packages/helm/buttahtoast/library#merge)

This function might have some bugs, but we are doing our best to unit test it and make sure it works as expected.

## Contexts

Contexts are data structures. In Sprig a template receives a context. Based on which context is given, you have acces to certain data.

### File Context

{{< hint "info" >}}With this example [https://github.com/buttahtoast/helmize/tree/main/examples/data](https://github.com/buttahtoast/helmize/tree/main/examples/data) you can see the file contexts. `helm template . --set showContext=true` {{< /hint >}}


The context available in each file:

  1. See [Condition Context](#condition-context)
  2. See [Global Context](#condition-context)


{{< expand "File Context" "..." >}}
```YAML
# Condition Context of current file (1)
<Condition Context>

# Global Context (2)
<Global Context>
```
{{< /expand >}}

### Train Context

The train is a construct which mainly holds the general configuration and consists of [wagons](#wagon).

{{< expand "Train Context" "..." >}}
```YAML
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

### Condition Context

The Condition is always available.

  1. All (previously) evaluated conditions can be accessed under `$.conditions`. The `$.conditions.[*].value` holds the resolved value from the `$.conditions.[*].key` property.
  2. When you template wagons, you can access the conditions Data field which selected this file via `$.data` (Reference to `$.Conditions.[*].data` field)
  3.  When you template wagons, you can access the conditions Value field which selected this file via `$.value` (Reference to `$.Conditions.[*].value` field). 


{{< expand "Condition Context" "..." >}}
```
# Evaluated Conditions (1)
conditions:

  # Condition Name
- name: base

  # Applied Config for Condition
  config:
    any: true
    key_types:
    - string
    - slice
    name: base
    path: /base/

  # Evaluated Data from templates
  data: {}

  # Errors
  errors: []

  # Evaluated Keys
  keys:
  - /

  # Condition paths (for lookup)
  paths:
  - structure/base/

  # Condition Root-Path (without inventory directoy)
  root_path: /base/

  # Value evaluated from key
  value: {}

- config:
    any: false
    default: test
    filter:
    - test
    - prod
    key: env
    key_types:
    - string
    - slice
    name: environment
    path: env/
    reverse_filter: true
  data: {}
  errors: []
  keys:
  - test
  name: environment
  paths:
  - structure/env/test/
  root_path: env/
  value: test

# Condition Data (2)  
data: {}

# Condition Value (3)
value: {}
```
{{< /expand >}}