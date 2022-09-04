{{/* Timestamp <Renderer> 

  Set a Timestamp annotation with the current time (useful for force redeployments)

*/}}
{{- define "helmize.renderers.templates.timestamp" -}}
  {{- $_ := set $.content.metadata "annotations" (mergeOverwrite (default $.content.metadata.annotations) (dict "helmizde.dev/timestamp" now)) -}}
{{- end -}}