{{/* Deploy <Template> 

  Returns deployable kubernetes manifests. If any errors are found the template errrors

  params <dict>: Global Context

*/}}
{{- define "helmize.entrypoint.func.deploy" -}}

  {{/* Print Helmize Configuration */}}
  {{- if ((fromYaml (include "lib.utils.dicts.lookup" (dict "data" $.Values "path" (include "helmize.entrypoint.defaults.show_config" $)))).res) -}}
  
     {{- toYaml (dict "config" (fromYaml (include "helmize.config.func.get" $))) | nindent 0  }}

  {{/* Print Summary Output */}}
  {{- else if ((fromYaml (include "lib.utils.dicts.lookup" (dict "data" $.Values "path" (include "helmize.entrypoint.defaults.summary_value" $)))).res) -}}
    
    {{- include "helmize.entrypoint.func.summary" $ -}}

  {{/* Print Manifests */}}
  {{- else -}}
    {{/* Resolve Files */}}
    {{- $deploy_raw := include "helmize.entrypoint.func.resolve" $ -}}
    {{- $deploy := fromYaml ($deploy_raw) -}}
    {{- if (not (include "lib.utils.errors.unmarshalingError" $deploy)) -}}
      {{/* Validate Force Function */}}
      {{- $force := ((fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.force" $) "ctx" $))).res) -}}
     
      {{/* Check if Errors were found */}}
      {{- if or (not $deploy.errors) (and ($deploy.errors) ($force)) -}}
  
        {{/* Call Render Template */}}
        {{- include ((fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.render_template" $) "ctx" $))).res) (dict "ctx" $ "deploy" $deploy) -}} 
  
      {{- else -}}
        {{- include "lib.utils.errors.fail" (printf "Found errors, please resolve those errors or use the force option:\n%s%s" (toYaml $deploy.errors | nindent 2) $force) -}}
      {{- end -}}
    {{- else -}}
      {{- include "lib.utils.errors.fail" (printf "Render did not return valid YAML:\n%s" ($deploy_raw | nindent 2)) -}}
    {{- end -}}
  {{- end -}}  
{{- end -}}  