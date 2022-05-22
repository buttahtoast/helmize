{{/* 
  Template To Evaluate Ingress Class based on domain
*/}}
{{- if (contains "horizontal" $.Data.domain) -}}
class: "horizontal-class"
{{- else if (contains "vertical" $.Data.domain) -}}
class: "vertical-class"
{{- else }}
class: "default-class"
{{- end }}