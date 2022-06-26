{{/* File Config <Type>

  Defines the Type Definition for the configuration (Per File)
  
*/}}
{{- define "helmize.render.types.file_configuration" -}}
{{ include "helmize.render.defaults.file_cfg.identifier" $ }}:
  types: [ "string", "slice" ]
{{ include "helmize.render.types.file_configuration.shared" $ }}
{{- end -}}

{{/* Shared File Config <Type>

  Defines the Type Definition for the configuration which is used for other configurations
  
*/}}
{{- define "helmize.render.types.file_configuration.shared" -}}
{{ include "helmize.render.defaults.file_cfg.subpath" $ }}:
  types: [ "bool" ]
  default: true
{{ include "helmize.render.defaults.file_cfg.pattern" $ }}:
  types: [ "bool" ]
  default: false
{{ include "helmize.render.defaults.file_cfg.render" $ }}:
  types: [ "bool" ]
  default: true
{{ include "helmize.render.defaults.file_cfg.no_match" $ }}:
  types: [ "string" ]
  default: "append"
  values: [ "append", "skip" ]
{{ include "helmize.render.defaults.file_cfg.max_match" $ }}:
  types: [ "float64" ]
  default: 0
{{ include "helmize.render.defaults.file_cfg.fork" $ }}:
  types: [ "bool" ]
  default: false
{{- end -}}