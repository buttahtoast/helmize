{{/* Custom Annotations PostRenderer <Template> 

  Adds given annotations for component and annotations from values.

*/}}
{{- define "reference.postrenderers.annotations" -}}
  {{- if $.content -}}
    {{- if $.content.metadata -}}
      {{- if $.ctx.Values.annotations -}}
        {{- $_ := set $.content.metadata "annotations" (mergeOverwrite (default dict $.content.metadata.annotations) $.ctx.Values.annotations) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}