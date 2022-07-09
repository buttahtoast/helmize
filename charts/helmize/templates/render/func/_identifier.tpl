{{/* Identifier <Template>
  
  Calls Identifier Template
*/}}
{{- define "helmize.render.func.identifier" -}}
  {{- if and $.wagon $.ctx -}}

    {{/* Run Identifiert Template */}}
    {{- $identifier_tpl_name := (fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.identifier_template" $.ctx) "ctx" $.ctx))).res -}}
    {{- if $identifier_tpl_name -}}

      {{/* included evaluated Template with current Root context */}}
      {{- $identifier_result_raw := include $identifier_tpl_name $ -}}
      {{- $identifier_result := fromYaml ($identifier_result_raw) -}}

      {{/* Handle ID */}}
      {{- if not ($.wagon.id) -}}
        {{/* Set Filename as default, if nothing set */}}
        {{- $_ := set $.wagon "id" (list $.wagon.file_id.filename) -}}
      {{- else -}}
        {{/* Convert to List */}}
        {{- if not (kindIs "slice" $.wagon.id) -}}
          {{- $_ := set $.wagon "id" (list $.wagon.id) -}}
        {{- end -}}
      {{- end -}}

      {{/* Validate Returned Metadata */}}
      {{- if not (include "lib.utils.errors.unmarshalingError" $identifier_result) -}}

        {{/* Debug */}}
        {{- if and $identifier_result.debug (kindIs "slice" $identifier_result.debug) -}}
          {{- range $deb := $identifier_result.debug -}}
            {{- $_ := set $.wagon "debug" (append $.wagon.errors (dict "identifier-template" $identifier_tpl_name "debug" $deb)) -}}
          {{- end -}}
        {{- end -}}

        {{/* Errors */}}
        {{- if and $identifier_result.errors (kindIs "slice" $identifier_result.errors) -}}
          {{- range $err := $identifier_result.errors -}}
            {{- $_ := set $.wagon "errors" (append $.wagon.errors (dict "identifier-template" $identifier_tpl_name "error" $err)) -}}
          {{- end -}}
        {{- end -}}
      {{- else -}}
        {{- include "lib.utils.errors.fail" (printf "Template %s returned invalid YAML (%s):\n%s" $identifier_tpl_name $identifier_result.Error ($identifier_result_raw | nindent 2)) -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
    {{- include "lib.utils.errors.params" (dict "tpl" "helmize.render.func.identifier" "params" (list "content " "ctx")) -}}
  {{- end -}}
{{- end -}}
