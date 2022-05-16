{{/* Custom Labels PostRenderer <Template> 

  Adds given Labels for component and labels from values.

*/}}
{{- define "reference.postrenderers.labels" -}}
  {{- if $.content -}}
    {{- if $.content.metadata -}}
      {{- if $.ctx.Values.labels -}}
        {{- $_ := set $.content.metadata "labels" (mergeOverwrite (default $.content.metadata.labels) $.ctx.Values.labels) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
