+++
title = "Debug"
description = "Debug"
weight = 4
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

# Debug

You can see extended information in the summary by adding the debug flag (not the helm debug flag):

```Shell
helm template . --set summary=true --set debug=true
```