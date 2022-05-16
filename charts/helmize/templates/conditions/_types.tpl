{{/* Condition <Type>

  Defines the Type Definition for one Condition Type
  
*/}}
{{- define "inventory.conditions.types.condition" -}}
name:
  types: [ "string" ]
  required: true
key:
  types: [ "string" ]
key_types:
  types: [ "slice" ]
  default: [ "string", "slice" ]
required:
  types: [ "int", "bool" ]
default:
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
file_cfg:
  _props: {{- include "inventory.render.types.file_configuration.shared" $ | nindent 4 }}
{{ include "inventory.postrenders.defaults.cfg.post_renderers" $ }}:
  types: [ "slice" ]
{{- end -}}