+++
title = "Flags"
description = "Flags"
weight = 10
+++

Flags are given as values

## Helmize File 

`--set helmize_file=<string>`

Define a custom location for the [helmize configuraiton](../../configuration) file. The path is realtiv to the chart root directory.

```Shell
helm template  . --set helmize_file=custom.yaml
```

## Force

`--set helmize.force=<bool>`

The Force flag is useful when you have errors while templating, but want to skip the errors:

```Shell
Found errors, please resolve those errors or use the force option (--set helmize.force=true):

  - error: No Kind Defined
    file:
    - super
    renderer: customization.renderers.sidecar
```

This flag can also be set in the [configuration]()

## Show Config

`--set show_config=<bool>`

Just prints the resulting config, for validation if you use templating:

```Shell
helm template  . --set show_config=true

---
# Source: example-customization/templates/deploy.yaml
config:
  benchmark: false
  conditions:
  - allow_root: true
    name: resources
  - allow_root: true
    data:
      sample: data
    default: resources
    file_cfg:
      subpath: false
    name: additional
    renderers:
    - customization.renderers.additional
  debug: false
  file_config_key: metadata.helmize
  file_extensions:
  - .yaml
  - .yml
  - .tpl
  force: false
  global: {}
  helmize: {}
  helmize_file: ""
  identifier_template: customization.identifier.template
  inventory_directory: structure/
  library:
    global: {}
  render_template: customization.render.template
  renderers:
  - customization.renderers.sidecar
  - customization.renderers.env
  show_config: false
  summary: false
```

## Summary

`--set summary=<bool>`

For such cases we have a summary which summarizes overything that happened during the helmize processing.

You can display the summary via values:

```Shell
helm template . --set summary=true
```

### Template

You can include the summary template, which returns the summary as YAML:

```
{{- $summary := fromYaml (include "inventory.render.func.summary" $) -}}
```

This way you could further process the output of helmize or eg. generate a good overview in the `NOTES.txt` of your chart.

## Debug

`--set debug=<bool>`

You can see extended information in the summary by adding the debug flag (not the helm debug flag):

```Shell
helm template . --set summary=true --set debug=true
```

### Template 

If you want to include more information, when the `debug` flag is set to `true`, you can include the following statement. This template will return `true` if the debug flag was set:

```Shell
include "inventory.entrypoint.func.debug" $.ctx
```

This should improve the experience and help you to debug your own templates.

## Benchmark

`--set benchmark=<bool>`

Templates benchmarks for different checkpoints. This can be combined with the summary flag. Mainly for development purposes.