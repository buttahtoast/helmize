{{- define "reference.identifier.template" -}}
  {{- $return := dict "id" "" "errors" list "debug" list -}}
  {{- if $.content.helmize_identifier -}}
    {{- $_ := set $return "id" $.content.helmize_identifier -}}
    {{- $_ := set $return "debug" (append $return.debug ($)) -}}
    {{- $_ := unset $.content "helmize_identifier" -}}
  {{- else -}}
    {{- $_ := set $return "errors" (append $return.errors (dict "error" "Missing field helmize_identifier")) -}}
  {{- end }}
  {{- printf "%s" (toYaml $return) -}}
{{- end -}}