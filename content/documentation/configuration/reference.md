+++
title = "Reference"
description = "Reference"
weight = 4
+++

Example configuration reference with documentation links.

```YAML
## Inventory Directory
# http://helmize.dev/documentation/configuration/general/#inventory_directory
inventory_directory: "groups/"

## Templates Directory
# http://helmize.dev/documentation/configuration/general/#templates_directory
templates_directory: "tpls/"

## Force
# http://helmize.dev/documentation/configuration/general/#force
force: false 

## File Extensions
# http://helmize.dev/documentation/configuration/general/#file_extensions
file_extensions: [ "yaml" ]

## File Excludes
# http://helmize.dev/documentation/configuration/general/#file_excludes
file_excludes: [ "kustomization" ]

## Merge Strategy
# http://helmize.dev/documentation/configuration/general/#merge_strategy
merge_strategy: "path"

## Custom Identifier Template
# http://helmize.dev/documentation/configuration/general/#custom_identifier_template
custom_identifier_template: "custom.identifier"

## Conditions
# http://helmize.dev/documentation/configuration/conditions/
conditions:

  # Condition "Base"
  ## Name
  # http://helmize.dev/documentation/configuration/conditions/#name
  - name: "base"

  ## Path
  # http://helmize.dev/documentation/configuration/conditions/#path
    path: "/base/"

  ## Allow Root
  # http://helmize.dev/documentation/configuration/conditions/#allow_root
    allow_root: true

  # Condition "Environment"
  - name: "environment"

  ## Key
  # http://helmize.dev/documentation/configuration/conditions/#key
    key: "Values.config.environment"

  ## Key Types
  # http://helmize.dev/documentation/configuration/conditions/#key_types
    key_types: [ "string" ]

  ## Required
  # http://helmize.dev/documentation/configuration/conditions/#required  
    required: false

  ## Default
  # http://helmize.dev/documentation/configuration/conditions/#default 
    default: "default"

  ## Filter
  # http://helmize.dev/documentation/configuration/conditions/#filter 
    filter: [ "dev" ]

  ## Reverse Filter
  # http://helmize.dev/documentation/configuration/conditions/#reverse_filter
    reverse_filter: false

## Dropins
# http://helmize.dev/documentation/configuration/dropins/
dropins:

  ## Patterns
  # http://helmize.dev/documentation/configuration/dropins/#patterns
  - patterns: [ ".*" ]

  ## Data 
  # http://helmize.dev/documentation/configuration/dropins/#data
    data:
      labels:
        "custom.label": "data"

  ## Templates
  # http://helmize.dev/documentation/configuration/dropins/#tpls
    tpls:
      - "registry.tpl"
```