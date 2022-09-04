{{/* GET POSTRENEDERS */}}
{{- define "helmize.renderers.func.get" -}}
  {{- $return := (dict "renderers" list) -}}
  {{- $cfg_renders := (fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.renderers" $) "ctx" $.ctx))).res -}}
  {{- $_ := set $return "renderers" $cfg_renders -}}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}  