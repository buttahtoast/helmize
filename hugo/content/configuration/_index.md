+++
title = "Configuration"
description = "General Configuration"
weight = 2
+++

{{< hint "info" >}}**Example** [https://github.com/buttahtoast/helmize/tree/main/examples/example-file-cfg](https://github.com/buttahtoast/helmize/tree/main/examples/example-file-cfg){{< /hint >}}


The configuration is the core component which defines how your deployment structure will be organized. [See which options you can configure](helmize/)

# Values

{{< hint "info" >}}Using configuration via Values is great for testing or subcharts{{< /hint >}}

All configurations can be set via values under the key `helmize`:

```
helmize:
  conditions:
  - __inject__
  - name: "patches"
    file_cfg:
      pattern: false
      render: false
    required: false
  - name: "render_all"
    file_cfg:
      render: true
    data: 
      additional: true
```

The configuration via values is merged on top of the [helmize configuration from file](#file), should it exist.


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