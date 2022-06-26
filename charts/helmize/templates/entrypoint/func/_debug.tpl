{{/* Debug <Template> 

  Returns True if Debug is Enabled
  
  params <dict>: Global Context

*/}}
{{- define "helmize.entrypoint.func.debug" -}}
  {{- $debug := (fromYaml (include "lib.utils.dicts.lookup" (dict "data" $.Values "path" (include "helmize.entrypoint.defaults.debug_value" $)))).res -}}
  {{- if $debug -}}
    {{- true -}}  
  {{- end -}}
{{- end -}}