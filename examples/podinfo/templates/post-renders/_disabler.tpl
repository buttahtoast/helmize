{{- define "reference.post-renders.disabler" -}}
  {{- $return := dict "content" $.content "errors" list "debug" list -}}
  {{- if $.Data.disabled -}}
     {{- $_ := set $return "content" dict -}}
  {{- end -}}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}