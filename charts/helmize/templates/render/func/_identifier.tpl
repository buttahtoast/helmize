{{/* Identifier <Template>
  
  Calls Identifier Template
*/}}
{{- define "helmize.render.func.identifier" -}}
  {{- if and $.wagon $.ctx -}}

    {{/* Run Identifiert Template */}}
    {{- $identifier_tpl_name := (fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.identifier_template" $.ctx) "ctx" $.ctx))).res -}}
    {{- if $identifier_tpl_name -}}

      {{/* included evaluated Template with current Root context */}}
      {{- include $identifier_tpl_name $ -}}

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

    {{- end -}}
  {{- else -}}
    {{- include "lib.utils.errors.params" (dict "tpl" "helmize.render.func.identifier" "params" (list "content " "ctx")) -}}
  {{- end -}}
{{- end -}}
