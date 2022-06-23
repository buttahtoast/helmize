+++
title = "Configuration"
description = "Configuration"
weight = 1
+++

The configuration is the core component which defines how your deployment structure will be organized

# Values

{{< hint "info" >}}Using configuration via Values is great for testing or subcharts{{< /hint >}}

All configurations can be set via values under the key `config`. 


# File 

{{< hint "info" >}}Using a file for configuration has the advantage, that you can use templating within the file, which is not possible with the Values approach.{{< /hint >}}


By default the configuration is located in a `helmize.yaml` file within your charts root folder. You will get errors if the configuration file is missing, has wrong formatting or types.


## Templating

The entire configuration file is templated. So you can also use sprig within the configuration file. You must make sure that after the templating the content resolves to valid YAML, otherwise the exection will fail. The file must be within the chart directry but **not within the templates/ folder**.


{{< expand "Example" "..." >}}

**chart/helmize.yaml**
```yaml
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
{{< /expand >}}