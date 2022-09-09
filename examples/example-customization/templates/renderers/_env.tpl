{{- define "customization.renderers.env" -}}
  {{- $return := dict "errors" list "debug" list -}}
  {{- $kind := (lower (default "" $.content.kind) | toString) -}}

  {{/* Label Variable */}}
  {{- $label := "metadata.labels.k8s$io/inject_port" -}}

  {{/* Verify if Kind persent */}}
  {{- if $kind -}}
    {{- if (has $kind (list "deployment" "statefulset" "daemonset")) -}}
      {{- $d := (fromYaml (include "lib.utils.dicts.get" (dict "path" $label "data" $.content))).res -}}
      {{- if (eq (default "false" (fromYaml (include "lib.utils.dicts.get" (dict "path" $label "data" $.content))).res) "true") -}}

        {{/* Iterate over containers and combine env (via merge function) */}}
        {{- range $m := $.content.spec.template.spec.containers -}}
          {{- include "lib.utils.dicts.merge" (dict "base" $m "data" (fromYaml (include "customization.renderers.env.values" $)) "ctx" $.ctx) -}}

          {{/* Emit Debug Message */}}
          {{- $_ := set $return "debug" (append $return.debug (printf "%s/%s/%s injected labels" $kind $.content.metadata.name $m.name)) -}}

        {{- end -}}

        {{/* Remove Inject Label */}}
        {{- include "lib.utils.dicts.unset" (dict "path" $label "data" $.content) -}}

      {{- end -}}
    {{- end -}}

  {{- end -}}

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}

{{- define "customization.renderers.env.values" -}}
env:
- __inject__
- name: EXISTING_VAR
  value: "Overwrite Value"
- name: "injected"
  value: "env"
{{- end -}}