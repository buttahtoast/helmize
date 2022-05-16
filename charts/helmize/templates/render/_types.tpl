{{/* File Config <Type>

  Defines the Type Definition for the configuration (Per File)
  
*/}}
{{- define "inventory.render.types.file_configuration" -}}
{{ include "inventory.render.defaults.file_cfg.identifier" $ }}:
  types: [ "string", "slice" ]
{{ include "inventory.render.types.file_configuration.shared" $ }}
{{- end -}}

{{/* Shared File Config <Type>

  Defines the Type Definition for the configuration which is used for other configurations
  
*/}}
{{- define "inventory.render.types.file_configuration.shared" -}}
{{ include "inventory.render.defaults.file_cfg.subpath" $ }}:
  types: [ "bool" ]
  default: true
{{ include "inventory.render.defaults.file_cfg.pattern" $ }}:
  types: [ "bool" ]
  default: false
{{ include "inventory.render.defaults.file_cfg.render" $ }}:
  types: [ "bool" ]
  default: true
{{ include "inventory.render.defaults.file_cfg.no_match" $ }}:
  types: [ "string" ]
  default: "append"
  values: [ "append", "skip" ]
{{ include "inventory.render.defaults.file_cfg.max_match" $ }}:
  types: [ "float64" ]
  default: 0
{{ include "inventory.render.defaults.file_cfg.fork" $ }}:
  types: [ "bool" ]
  default: false
{{- end -}}