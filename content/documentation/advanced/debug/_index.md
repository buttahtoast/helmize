+++
title = "Debug"
description = "Debug"
weight = 4
+++

With large file structures it's often difficult to understand, which files were merged or why content is missing.


# Summary

For such cases we have a summary which summarizes overything that happened during the helmize processing.

You can display the summary via values:

```Shell
helm template . --set summary=true
```

## Template

You can include the summary template, which returns the summary as YAML:

```
{{- $summary := fromYaml (include "inventory.entrypoint.func.summary" $) -}}
```

This way you could further process the output of helmize or eg. generate a good overview in the `NOTES.txt` of your chart.

# Debug

You can see extended information in the summary by adding the debug flag (not the helm debug flag):

```Shell
helm template . --set summary=true --set debug=true
```

## Template 

If you want to include more information, when the `debug` flag is set to `true`, you can include the following statement. This template will return `true` if the debug flag was set:

```Shell
include "inventory.entrypoint.func.debug" $.ctx
```

Here as example for a custom identifier template:

{{< hint "info" >}}
The template expects the global helm context as argument. For the most time this is innherited trough `$.ctx`
{{< /hint >}}

```Shell
{{- define "reference.identifier.template" -}}
  {{- $return := dict "id" "" "errors" list "debug" list -}}

  {{/* Identifier Stuff */}}
  {{- if $.content.helmize_identifier -}}
    {{- $_ := set $return "id" $.content.helmize_identifier -}}
    {{- $_ := unset $.content "helmize_identifier" -}}
  {{- else -}}
    {{- $_ := set $return "errors" (append $return.errors (dict "error" "Missing field helmize_identifier")) -}}
  {{- end }}

  ...

  {{/* Returns Debug Data, if Debug enabled */}}
  {{- if (include "inventory.entrypoint.func.debug" $.ctx) -}}
    {{- $_ := set $ "debug" (append $.debug (dict "msg" "More debug information" "trace" (toYaml $))) -}}
  {{- end -}}

  ...

{{- end -}}
```

This should improve the experience and help you to debug your own templates.
