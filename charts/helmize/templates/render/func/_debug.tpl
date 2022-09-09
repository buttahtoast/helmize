{{/* Debug <Template> 

  Returns True if Debug is enabled via configuration.

*/}}
{{- define "helmize.render.func.debug" -}}
  {{- $debug := (fromYaml (include "lib.utils.dicts.get" (dict "data" $.Values "path" (include "helmize.render.defaults.debug_value" $)))).res -}}
  {{- if $debug -}}
    {{- true -}}  
  {{- end -}}
{{- end -}}