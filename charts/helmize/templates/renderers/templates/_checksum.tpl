{{/* Checksum <PostRenderer> 

  Set a Timestamp annotation with the current time (useful for force redeployments).
  The difference of this checksum and the wagon checksum is, that this checksum is included 
  in the wagon checksum and depending on the order of the post-renderers, this checksum might not be accurate.

  NOTE: This is influenced if the timestamp renderer is used as well

*/}}
{{- define "helmize.postrenders.templates.checksum" -}}
  {{- $_ := set $.content.metadata "annotations" (mergeOverwrite (default $.content.metadata.annotations) (dict "helmizde.dev/checksum" (sha256sum (toYaml $.content)))) -}}
{{- end -}}