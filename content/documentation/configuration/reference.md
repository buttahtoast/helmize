+++
title = "Reference"
description = "Reference"
weight = 4
+++

Configuration Reference

```YAML
inventory_directory: "groups/"
templates_directory: "tpls/"
force: false 
file_extensions: [ "yaml" ]
file_excludes: [ "kustomization" ]
merge_strategy: "path"

## Conditions <slice>
conditions:

  # Location Condition
  - name: "location"
    key: "Values.config.location"
    default: "default"

  # Location
  - name: "environment"
    key: "Values.config.environment"
    required: false
    default: "default"
    path: "/custom/path"
    filter: [ "dev" ]
    reverseFilter: false
    allow_root: true
...