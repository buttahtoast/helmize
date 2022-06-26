{{/* Condition <Type>

  Defines the Type Definition for one Condition Type
  
*/}}
{{- define "helmize.conditions.types.condition" -}}
{{ include "helmize.conditions.defaults.conditions.name" $ }}:
  types: [ "string" ]
  required: true
{{ include "helmize.conditions.defaults.conditions.key" $ }}:
  types: [ "string" ]
{{ include "helmize.conditions.defaults.conditions.key_types" $ }}:
  types: [ "slice" ]
  default: [ "string", "slice" ]
{{ include "helmize.conditions.defaults.conditions.required" $ }}:
  types: [  "bool" ]
{{ include "helmize.conditions.defaults.conditions.default" $ }}:
  types: [ "string" ]
{{ include "helmize.conditions.defaults.conditions.path" $ }}:
  types: [ "string" ]
{{ include "helmize.conditions.defaults.conditions.filter" $ }}: 
  types: [ "string", "slice" ]
{{ include "helmize.conditions.defaults.conditions.allow_root" $ }}:
  types: [ "int", "bool" ]
  default: false
{{ include "helmize.conditions.defaults.conditions.data" $ }}:
  types: [ "map" ]
{{ include "helmize.conditions.defaults.conditions.tpls" $ }}:
  types: [ "slice" ]
file_cfg:
  _props: {{- include "helmize.render.types.file_configuration.shared" $ | nindent 4 }}
{{ include "helmize.config.defaults.post_renderers" $ }}:
  types: [ "slice" ]
{{- end -}}