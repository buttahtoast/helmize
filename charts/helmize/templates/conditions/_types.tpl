{{/* Condition <Type>

  Defines the Type Definition for one Condition Type
  
*/}}
{{- define "inventory.conditions.types.condition" -}}
name:
  types: [ "string" ]
  required: true
{{ include "inventory.conditions.defaults.conditions.key" $ }}:
  types: [ "string" ]
key_types:
  types: [ "slice" ]
  default: [ "string", "slice" ]
{{ include "inventory.conditions.defaults.conditions.required" $ }}:
  types: [  "bool" ]
{{ include "inventory.conditions.defaults.conditions.default" $ }}:
  types: [ "string" ]
path:
  types: [ "string" ]
filter: 
  types: [ "string", "slice" ]
reverse_filter:
  types: [ "int", "bool" ]
allow_root:
  types: [ "int", "bool" ]
  default: true
{{ include "inventory.conditions.defaults.conditions.data" $ }}:
  types: [ "map" ]
{{ include "inventory.conditions.defaults.conditions.tpls" $ }}:
  types: [ "slice" ]
file_cfg:
  _props: {{- include "inventory.render.types.file_configuration.shared" $ | nindent 4 }}
{{ include "inventory.postrenders.defaults.cfg.post_renderers" $ }}:
  types: [ "slice" ]
{{- end -}}