{{/* 
  Template To Evaluate Ingress Class based on domain
*/}}
{{- if (contains "horizontal" $.data.domain) -}}
class: "horizontal-class"
{{- else if (contains "vertical" $.data.domain) -}}
class: "vertical-class"
{{- else }}
class: "default-class"
{{- end }}