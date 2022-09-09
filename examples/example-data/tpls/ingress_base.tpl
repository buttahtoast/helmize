{{/* 
  Template To Evaluate ingress top domain based on location 
*/}}
{{- if (or (eq $.value "east") (eq $.value "west"))  -}}
domain: {{ $.value }}.vertical.public.domain
{{- else }}
domain: {{ $.value }}.horizontal.public.domain
{{- end }}