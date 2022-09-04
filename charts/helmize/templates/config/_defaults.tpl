{{/* Config Location <Template> 

  Config File location

*/}}
{{- define "helmize.config.defaults.config_location" -}}
  {{- default "helmize.yaml" $.Values.helmize_file -}}
{{- end }}

{{/* Values Config <Template> 

  Values Key for Helmize configuration

*/}}
{{- define "helmize.config.defaults.config_values" -}}
helmize
{{- end }}


{{/* Force (Config Type) <Template> 

  Force Configuration Key

*/}}
{{- define "helmize.config.defaults.force" -}}
force
{{- end -}}


{{/* Inventory Directory (Config Type) <Template> 

  Inventory Directory Configuration Key

*/}}
{{- define "helmize.config.defaults.inv_dir" -}}
inventory_directory
{{- end }}


{{/* Inventory Directory Value (Config Type) <Template> 

  Default Value for Inventory Directory Configuration

*/}}
{{- define "helmize.config.defaults.inv_dir.value" -}}
structure/
{{- end }}


{{/* Conditions (Config Type) <Template> 

  Conditions Configuration Key

*/}}
{{- define "helmize.config.defaults.conditions" -}}
conditions
{{- end }}


{{/* Excludes (Config Type) <Template> 

  Excludes Configuration Key

*/}}
{{- define "helmize.config.defaults.file_excludes" -}}
file_excludes
{{- end -}}


{{/* Extensions (Config Type) <Template> 

  Extensions Configuration Key

*/}}
{{- define "helmize.config.defaults.file_extensions" -}}
file_extensions
{{- end -}}


{{/* Identifier Template (Config Type) <Template> 

  Identifier Template Configuration Key

*/}}
{{- define "helmize.config.defaults.identifier_template" -}}
identifier_template
{{- end -}}


{{/* Identifier Template Value (Config Type) <Template> 

  Default Value for Identifier Template Configuration

*/}}
{{- define "helmize.config.defaults.identifier_template.value" -}}
helmize.render.templates.identifier
{{- end -}}


{{/* Render Template (Config Type) <Template> 

  Render Template Configuration Key

*/}}
{{- define "helmize.config.defaults.render_template" -}}
render_template
{{- end -}}


{{/* Render Template Value (Config Type) <Template> 

  Default Value for Render Template Configuration

*/}}
{{- define "helmize.config.defaults.render_template.value" -}}
helmize.entrypoint.templates.default
{{- end -}}


{{/* Post Renderers (Config Type) <Template> 

  Post Renderers Configuration Key

*/}}
{{- define "helmize.config.defaults.renderers" -}}
renderers
{{- end -}}


{{/* File Configuration Key (Config Type) <Template> 

  File Configuration Key Configuration Key

*/}}
{{- define "helmize.config.defaults.file_cfg_key" -}}
file_config_key
{{- end -}}


{{/* File Configuration Key Value (Config Type) <Template> 

  Default Value for File Configuration Key Configuration

*/}}
{{- define "helmize.config.defaults.file_cfg_key.value" -}}
helmize
{{- end -}}