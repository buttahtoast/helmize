{{/* Context <PostRenderer> 

  Sets the entire context for each wagon in the content under $.ctx

*/}}
{{- define "helmize.postrenders.templates.context" -}}

  {{/* Dereference (No Pointer) */}}
  {{- $ctx := (fromYaml (toYaml $)) -}}

  {{/* Set Context (Here we need to dereference $ to dump it's content. Otherwise it breaks the set function */}}
  {{- $_ := set $.content "ctx" $ctx -}}

{{- end -}}