{{/* Identifier (File Configuration Type) <Template> 

   Match Strategy Key

*/}}
{{- define "helmize.render.defaults.file_cfg.identifier" -}}
id
{{- end -}}


{{/* No Match (File Configuration Type) <Template> 

   Match Strategy Key

*/}}
{{- define "helmize.render.defaults.file_cfg.no_match" -}}
no_match
{{- end -}}


{{- define "helmize.render.defaults.file_cfg.subpath" -}}
subpath
{{- end -}}


{{- define "helmize.render.defaults.file_cfg.max_match" -}}
max_match
{{- end -}}

{{/* Render (File Configuration Type, Local) <Template> 

   Configure if a file should be rendered in the final output. Note that it will still show up in the Summary

*/}}
{{- define "helmize.render.defaults.file_cfg.render" -}}
render
{{- end -}}

{{/* Pattern (File Configuration Type, Local) <Template> 

   IDs are used as Patterns to match against other ids. If Enabled the file won't be added if nothing matches.

*/}}
{{- define "helmize.render.defaults.file_cfg.fork" -}}
fork
{{- end -}}

{{/* Pattern (File Configuration Type, Local) <Template> 

   IDs are used as Patterns to match against other ids. If Enabled the file won't be added if nothing matches.

*/}}
{{- define "helmize.render.defaults.file_cfg.pattern" -}}
pattern
{{- end -}}
