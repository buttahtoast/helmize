+++
title = "Reference"
description = "File Reference"
weight = 4
+++

Example configuration reference for files

```YAML
## File Configuration Key
# http://helmize.dev/configuration/helmize/#file_config_key
helmize:

  ## Identifiers
  # http://helmize.dev/configuration/files/#id
  id: 
    - deploy
    - nginx

  ## No Match
  # http://helmize.dev/configuration/files/#no_match
  no_match: "skip"
  
  ## Max Match
  # http://helmize.dev/configuration/files/#max_match
  no_match: 5

  ## Render
  # http://helmize.dev/configuration/files/#render
  render: false

  ## Subpath
  # http://helmize.dev/configuration/files/#subpath
  subpath: false

  ## Pattern
  # http://helmize.dev/configuration/files/#pattern
  pattern: true

  ## Fork
  # http://helmize.dev/configuration/files/#fork
  fork: true
```