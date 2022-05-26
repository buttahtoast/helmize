{{/* Config Location <Template> 

  Config File location

*/}}
{{- define "inventory.config.defaults.config_location" -}}
  {{- default "helmize.yaml" $.Values.config_file -}}
{{- end }}

{{/* Values Config <Template> 

  Values Key for Helmize configuration

*/}}
{{- define "inventory.config.defaults.config_values" -}}
config
{{- end }}