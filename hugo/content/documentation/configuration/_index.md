+++
title = "Configuration"
description = "Configuration"
weight = 1
+++

The configuration is the core component which defines how your deployment structure will be organized

# File 

By default the configuration is located in a `helmize.yaml` file within your charts root folder. You will get errors if the configuration file is missing, has wrong formatting or types.


# Templating

The entire configuration file is templated. So you can also use sprig within the configuration file. You must make sure that after the templating the content resolves to valid YAML, otherwise the exection will fail.

A simple example:

```
inventory_directory: "structure/"
conditions:

{{- if $.Values.exclude_base }}
  - name: "base"
    path: "/base/"
    allow_root: true
{{- end }}

  - name: "environment"
    key: {{ default "Values.env" $.Values.overwrite_env_key }}
    path: "env/"
    default: "test"
```

When `exclude_base`is set to `false`, the base condition won't be used, since it's not rendered in the configuration file:

``` 
helm template . --set exclude_base=false
```