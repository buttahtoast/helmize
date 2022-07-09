{{- define "customization.identifier.template" -}}
  {{- $return := dict "errors" list "debug" list -}}

  {{/* Execute the default identifier Template (Redirect it's output into nowhere) */}}
  {{- $_ := include (include "helmize.config.defaults.identifier_template.value" $) $ -}}

  {{/* Lookup field super identifier, an Overwrite existing ids, if present */}}
  {{- $content_path := "super_identifier" -}}
  {{- $super_identifier := (default "" (fromYaml (include "lib.utils.dicts.get" (dict "path" $content_path "data" $.wagon.content))).res) -}}
       
  {{/* Super Identifier */}}
  {{- if $super_identifier -}}

    {{/* DNS1123 Regex (Simplified) */}}
    {{- $regex := "^[A-Za-z0-9_.]{1,63}$" -}}

    {{/* Verify if name matches DNS1123 Regex */}}
    {{- if (regexMatch $regex $super_identifier) -}}
      
       {{/* Assign Identifier */}}
       {{- $_ := set $.wagon "id" $super_identifier -}}

       {{/* Debug */}}
       {{- $_ := set $return "debug" (append $return.debug (printf "%s is a super identifier" $super_identifier)) -}}
    
       {{/* Remove Field from Content */}}
       {{- include "lib.utils.dicts.unset" (dict "path" $content_path "data" $.wagon.content) -}}

    {{/* Throw Error */}}
    {{- else -}}
      {{- $_ := set $return "errors" (append $return.errors (printf "%s did not match regex %s" $super_identifier $regex)) -}}
    {{- end -}}
  {{- end -}}

  {{- printf "%s" (toYaml $return) -}}
{{- end -}}