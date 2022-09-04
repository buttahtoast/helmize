{{/* Deploy <Template> 

  Returns deployable kubernetes manifests. If any errors are found the template errrors

*/}}
{{- define "helmize.deploy" -}}

  {{/* Print Helmize Configuration */}}
  {{- if ((fromYaml (include "lib.utils.dicts.get" (dict "data" $.Values "path" (include "helmize.render.defaults.show_config" $)))).res) -}}
  
     {{- toYaml (dict "config" (fromYaml (include "helmize.config.func.get" $))) | nindent 0  }}

  {{/* Print Summary Output */}}
  {{- else if ((fromYaml (include "lib.utils.dicts.get" (dict "data" $.Values "path" (include "helmize.render.defaults.summary_value" $)))).res) -}}
    
    {{- include "helmize.render.func.summary" $ -}}

  {{/* Print Manifests */}}
  {{- else -}}
    {{/* Resolve Files */}}
    {{- $train_raw := include "helmize.render.func.resolve" $ -}}
    {{- $train := fromYaml ($train_raw) -}}
    {{- if (not (include "lib.utils.errors.unmarshalingError" $train)) -}}
      {{/* Validate Force Function */}}
      {{- $force := ((fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.force" $) "ctx" $))).res) -}}
     
      {{/* Check if Errors were found */}}
      {{- if or (not $train.errors) (and ($train.errors) ($force)) -}}
  
        {{/* Call Render Template */}}
        {{- include ((fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.render_template" $) "ctx" $))).res) (dict "ctx" $ "train" $train) -}} 
  
      {{- else -}}
        {{- include "lib.utils.errors.fail" (printf "Found errors, please resolve those errors or use the force option:\n%s" (toYaml $train.errors | nindent 2)) -}}
      {{- end -}}
    {{- else -}}
      {{- include "lib.utils.errors.fail" (printf "Render did not return valid YAML:\n%s" ($train_raw | nindent 2)) -}}
    {{- end -}}
  {{- end -}}  
{{- end -}}  