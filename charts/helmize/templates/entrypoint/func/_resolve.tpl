{{/* Resolve <Template> 

  Entrypoint to resolve Render Data
  
  params <dict>: Global Context

*/}}
{{- define "helmize.entrypoint.func.resolve" -}}
    {{- $render_raw := include "helmize.render.func.resolve" $ -}}
    {{- $render := fromYaml ($render_raw) -}}
    {{- if (not (include "lib.utils.errors.unmarshalingError" $render)) -}}
        {{- $benchmark := (fromYaml (include "lib.utils.dicts.lookup" (dict "data" $.Values "path" (include "helmize.entrypoint.defaults.benchmark_value" $)))).res -}}
        {{- if $benchmark -}}
          {{- printf "%s" (toYaml $render) -}}
        {{- else -}}
          {{- printf "%s" (toYaml (omit $render "timestamps")) -}}
        {{- end -}}
    {{- else -}}
      {{- include "lib.utils.errors.fail" (printf "Template helmize.render.func.resolve returned invalid YAML:%s" (toYaml $render_raw | nindent 2)) -}}
    {{- end -}}
{{- end -}}