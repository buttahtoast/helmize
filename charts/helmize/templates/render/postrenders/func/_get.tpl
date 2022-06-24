{{/* GET POSTRENEDERS */}}
{{- define "inventory.postrenders.func.get" -}}
  {{- $return := (dict "renders" list) -}}
  {{- $cfg_renders := (fromYaml (include "inventory.config.func.resolve" (dict "path" (include "inventory.postrenders.defaults.cfg.post_renderers" $) "ctx" $.ctx))).res -}}
  {{- $_ := set $return "renders" $cfg_renders -}}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}  