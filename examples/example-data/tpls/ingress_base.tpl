{{/* 
  Template To Evaluate ingress top domain based on location 
*/}}
{{- if (or (eq $.Value "east") (eq $.Value "west"))  -}}
domain: {{ $.Value }}.vertical.public.domain
{{- else }}
domain: {{ $.Value }}.horizontal.public.domain
{{- end }}