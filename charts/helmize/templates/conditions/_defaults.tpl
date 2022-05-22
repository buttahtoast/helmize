
{{/* Conditions <Template> 

  Default Configuration Key within configuration file for conditions option

*/}}
{{- define "inventory.conditions.defaults.conditions" -}}
conditions
{{- end }}

{{/* Inventory Directory <Template> 

  Default Configuration Key within configuration file for inventory directory option

*/}}
{{- define "inventory.conditions.defaults.inv_dir" -}}
inventory_directory
{{- end }}

{{/* Key (Conditions Type) <Template> 

   Key Configuration Key

*/}}
{{- define "inventory.conditions.defaults.conditions.key" -}}
key
{{- end -}}

{{/* Required (Conditions Type) <Template> 

   Required Configuration Key

*/}}
{{- define "inventory.conditions.defaults.conditions.required" -}}
required
{{- end -}}

{{/* Default (Conditions Type) <Template> 

   Default Configuration Key

*/}}
{{- define "inventory.conditions.defaults.conditions.default" -}}
default
{{- end -}}

{{/* Data (Conditions Type) <Template> 

   Data Configuration Key

*/}}
{{- define "inventory.conditions.defaults.conditions.data" -}}
data
{{- end -}}

{{/* Templates (Conditions Type) <Template> 

   Templates Configuration Key

*/}}
{{- define "inventory.conditions.defaults.conditions.tpls" -}}
tpls
{{- end -}}
