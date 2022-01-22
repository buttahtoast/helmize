+++
title = "Debug"
description = "Debug"
weight = 2
+++

With large file structures it's often difficult to understand, which files were merged or why content is missing.


# Summary

For such cases we have a summary which summarizes overything that happened during the helmize processing.

## Template

You can include the summary template, which returns the summary as YAML:

```
{{- $summary := fromYaml (include "inventory.entrypoint.func.summary" $) -}}
```

This way you could further process the output of helmize or eg. generate a good overview in the `NOTES.txt` of your chart.

### Deploy

When you have included the deploy template:

```
{{- include "inventory.entrypoint.func.deploy" $ | nindent 0 -}}
``` 

You can display the summary via values:

```Shell
helm template . --set summary=true
```

## Reference 

See all the fields which are returned in the summary

{{< expand "Reference" "..." >}}

This is the summary output for the [reference]() chart.

```YAML
## Contains all conditions
conditions:

  # Each Condition returns the same fields, so here's the reference for one
  ...

  # Condition Name
- name: environment

  # Source configuration from configuration file
  config:
    default: test
    filter:
    - test
    - prod
    key: Values.env
    key_types:
    - string
    - slice
    name: environment
    path: env/
    reverse_filter: true

  # Resulting Keys based on configuration  
  keys:
  - test

  # Resulting paths based on keys and root_path
  paths:
  - structure/env/test/

  # Root path 
  root_path: env/

## Errors
# Any errors that were found during processing
errors: []

## Files
# Contains all the files with extra information. Files are grouped based on the merge_strategy
files:

  # Each file returns the same fields, so here's the reference for one
  ...
 
  ## Checksum
  # SHA1 Checksum of the file's content field
  - checksum: 180fcd1de54e143f1304991d9cf801262001f43287e78734e3b9e1e44dd694a0

  ## Identifiert
  # Identifier for file, varies based on merge strategy
    identifier: podinfo/deploy.yaml
 
  ## Content
  # Content of all the files based on merge strategy 
    content: ...

  ## Dropins
  # Result of dropins which matched for this file
    dropins:

    ## Data
    # All data fields of matched dropins merged together 
      data:
        labels:
          custom.label: data
          registy.template: label

    ## Lookup
    # Which Template Files were looked up during dropin evaluation (useful when u are not explicit with your template paths)
      lookup:
      - tpls/registry.tpl

    ## Patterns
    # Which Dropin Patterns matched   
      patterns:
      - .*

    ## Templates
    # Templates which were successfully executed   
      templates:
      - tpls/registry.tpl

  ## Errors
  # Errors encountered during file merges (is given to parent errors field as well)
  errors: []

  ## Files
  # All Files with their path (given from condition) which were considered
  files:
  - file: structure/base/podinfo/deploy.yaml
    path: structure/base/
  - file: structure/env/test/podinfo/deploy.yaml
    path: structure/env/test/

## Paths
# All Files with their path (given from condition) which were considered for all files
paths:
- file: structure/base/podinfo/deploy.yaml
  path: structure/base/
- file: structure/base/podinfo/service.yaml
  path: structure/base/
- file: structure/env/test/podinfo/deploy.yaml
  path: structure/env/test/
- file: structure/env/test/podinfo/hpa.yaml
  path: structure/env/test/
```


{{< /expand >}}