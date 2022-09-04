+++
title = "Reference"
description = "Helmize Reference"
weight = 4
+++

Example configuration reference with documentation links.

```YAML
## Inventory Directory
# http://helmize.dev/documentation/configuration/general/#inventory_directory
inventory_directory: "groups/"

## Force
# http://helmize.dev/configuration/general/#force
force: false 

## File Extensions
# http://helmize.dev/configuration/general/#file_extensions
file_extensions: [ "yaml" ]

## File Excludes
# http://helmize.dev/configuration/general/#file_excludes
file_excludes: [ "kustomization" ]

## Identifier Template
# http://helmize.dev/configuration/general/#identifier_template
identifier_template: "custom.identifier.template"

## Render Template
# http://helmize.dev/configuration/general/#render_template
render_template: "custom.render.template"

## File Configuration Key
# http://helmize.dev/configuration/general/#file_config_key
file_config_key: "custom.config.key"

## General Renderers
# http://helmize.dev/configuration/general/#post_renderers
renderers:
  - "custom.post-renderer.1"
  - "custom.post-renderer.2"

## Conditions
# http://helmize.dev/configuration/conditions/
conditions:

  # Condition "Base"

  ## Name
  # http://helmize.dev/configuration/conditions/#name
  - name: "base"

  ## Path
  # http://helmize.dev/configuration/conditions/#path
    path: "/base/"

  ## Allow Root
  # http://helmize.dev/configuration/conditions/#allow_root
    allow_root: false

  # Condition "Environment"

  ## Name
  # http://helmize.dev/configuration/conditions/#name  
  - name: "environment"

  ## Key
  # http://helmize.dev/configuration/conditions/#key
    key: "config.environment"

  ## Key Types
  # http://helmize.dev/configuration/conditions/#key_types
    key_types: [ "string" ]

  ## Required
  # http://helmize.dev/configuration/conditions/#required  
    required: false

  ## Default
  # http://helmize.dev/configuration/conditions/#default 
    default: "default"

  ## Filter
  # http://helmize.dev/configuration/conditions/#filter 
    filter: [ "dev" ]

  ## Reverse Filter
  # http://helmize.dev/configuration/conditions/#reverse_filter
    reverse_filter: false

  ## File Config
  # http://helmize.dev/configuration/conditions/#file_cfg
    file_cfg: 
      pattern: true
      render: false

  ## Data
  # http://helmize.dev/configuration/conditions/#data
    data:
      static:
        condition: data

  ## Data Templates
  # http://helmize.dev/configuration/conditions/#tpls
    tpls:
      - "ingress.tpl"

  ## Renderers
  # http://helmize.dev/configuration/conditions/#renderers
    renderers:
      - "custom.condition.post-renderer.1"
      - "custom.condition.post-renderer.2"
```