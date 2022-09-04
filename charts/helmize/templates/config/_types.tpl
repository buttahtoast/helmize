{{/* Config <Type>

  Defines the Type Definition for the configuration
  
*/}}
{{- define "helmize.config.types.config" -}}
{{ include "helmize.config.defaults.inv_dir" $ }}:
  types: [ "string" ]
  default: {{ include "helmize.config.defaults.inv_dir.value" $ }}
{{ include "helmize.config.defaults.conditions" $ }}:
  types: [ "slice" ]
{{ include "helmize.config.defaults.force" $ }}:
  types: [ "bool", "int" ]
  default: false
{{ include "helmize.config.defaults.file_excludes" $ }}:
  types: [ "string", "slice" ]
{{ include "helmize.config.defaults.file_extensions" $ }}:
  types: [ "string", "slice" ]
  default: [ ".yaml", ".yml", ".tpl" ]
{{ include "helmize.config.defaults.identifier_template" $ }}:
  types: [ "string" ]
  default: {{ include "helmize.config.defaults.identifier_template.value" $ }}
{{ include "helmize.config.defaults.render_template" $ }}:
  types: [ "string" ]
  default: {{ include "helmize.config.defaults.render_template.value" $ }} 
{{ include "helmize.config.defaults.renderers" $ }}:
  types: [ "slice" ]
{{ include "helmize.config.defaults.file_cfg_key" $ }}:
  types: [ "string" ]
  default: {{ include "helmize.config.defaults.file_cfg_key.value" $ }}
{{- end -}}