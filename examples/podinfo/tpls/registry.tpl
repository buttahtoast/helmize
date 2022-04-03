{{/* Does not do much, but you can use templating to map values or use defaulting */}}
{{- if $.Values.registry }}
registry: {{ $.Values.registry }}
{{- end }}

{{/*
  Adds Another Label for the Post Renderer
*/}}
labels:
  registy.template: "label"