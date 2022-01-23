{{- define "inventory.postrenders.includes" -}}
reference.post-renders.disabler
{{ include "inventory.postrenders.defaults.renders" $ -}}
{{- end -}}