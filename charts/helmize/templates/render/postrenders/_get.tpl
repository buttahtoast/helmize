{{/* GET POSTRENEDERS */}}
{{- define "helmize.render.func.postrenders.get" -}}
  {{- $return := (dict "renders" list) -}}
  {{- $cfg_renders := (fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.post_renderers" $) "ctx" $.ctx))).res -}}
  {{- $_ := set $return "renders" $cfg_renders -}}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}  