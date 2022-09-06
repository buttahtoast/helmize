{{- define "customization.renderers.additional" -}}
  {{- include "lib.utils.dicts.set" (dict "path" "metadata.labels" "value" (dict "additional_label1" "value_1" "additional_label2" "value2") "data" $.content) }}
{{- end -}}