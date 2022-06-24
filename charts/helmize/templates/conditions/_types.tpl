{{/* Condition <Type>

  Defines the Type Definition for one Condition Type
  
*/}}
{{- define "inventory.conditions.types.condition" -}}
{{ include "inventory.conditions.defaults.conditions.name" $ }}:
  types: [ "string" ]
  required: true
{{ include "inventory.conditions.defaults.conditions.key" $ }}:
  types: [ "string" ]
{{ include "inventory.conditions.defaults.conditions.key_types" $ }}:
  types: [ "slice" ]
  default: [ "string", "slice" ]
{{ include "inventory.conditions.defaults.conditions.required" $ }}:
  types: [  "bool" ]
{{ include "inventory.conditions.defaults.conditions.default" $ }}:
  types: [ "string" ]
{{ include "inventory.conditions.defaults.conditions.path" $ }}:
  types: [ "string" ]
{{ include "inventory.conditions.defaults.conditions.filter" $ }}: 
  types: [ "string", "slice" ]
{{ include "inventory.conditions.defaults.conditions.reverse_filter" $ }}:
  types: [ "int", "bool" ]
  default: false
{{ include "inventory.conditions.defaults.conditions.allow_root" $ }}:
  types: [ "int", "bool" ]
  default: false
{{ include "inventory.conditions.defaults.conditions.data" $ }}:
  types: [ "map" ]
{{ include "inventory.conditions.defaults.conditions.tpls" $ }}:
  types: [ "slice" ]
file_cfg:
  _props: {{- include "inventory.render.types.file_configuration.shared" $ | nindent 4 }}
{{ include "inventory.postrenders.defaults.cfg.post_renderers" $ }}:
  types: [ "slice" ]
{{- end -}}