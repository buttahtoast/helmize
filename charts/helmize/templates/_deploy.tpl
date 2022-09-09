{{/* Deploy <Template> 

  Returns deployable kubernetes manifests. If any errors are found the template errrors

*/}}
{{- define "helmize.deploy" -}}

  {{/* Print Helmize Configuration */}}
  {{- if ((fromYaml (include "lib.utils.dicts.get" (dict "data" $.Values "path" (include "helmize.render.defaults.show_config" $)))).res) -}}
     {{- toYaml (dict "config" (fromYaml (include "helmize.config.func.get" $))) | nindent 0  }}

  {{/* Resolve Train */}}
  {{- else -}}

    {{/* Summary Output (Dedicated Call, Since SUmmary also resolves and serves as standalone template) */}}
    {{-  if ((fromYaml (include "lib.utils.dicts.get" (dict "data" $.Values "path" (include "helmize.render.defaults.summary_value" $)))).res) -}}
      {{- include "helmize.render.func.summary" $ -}}

    {{- else -}}
      {{/* Resolve */}}
      {{- $train_raw := include "helmize.render.func.resolve" $ -}}
      {{- $train := fromYaml ($train_raw) -}}

      {{/* Check for YAML errors */}}
      {{- if (not (include "lib.utils.errors.unmarshalingError" $train)) -}}

        {{/* Get Force Option */}}
        {{- $force := ((fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.force" $) "ctx" $))).res) -}}
       
        {{/* Check if Errors were found (Or Force enabled) */}}
        {{- if or (not $train.errors) (and ($train.errors) ($force)) -}}
    
          {{/* Benchmark Output */}}
          {{- if ((fromYaml (include "lib.utils.dicts.get" (dict "data" $.Values "path" (include "helmize.render.defaults.benchmark_value" $)))).res ) -}}
            {{- include "lib.utils.errors.fail" (printf "Exectuion Benchmarks:\n%s" (toYaml $train.timestamps | nindent 2)) -}}
    
          {{/* Render */}}
          {{- else -}}
            {{- include ((fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.render_template" $) "ctx" $))).res) (dict "ctx" $ "train" $train) -}} 
          {{- end -}}
  
        {{- else -}}
          {{- include "lib.utils.errors.fail" (printf "Found errors, please resolve those errors or use the force option (--set helmize.force=true):\n%s" (toYaml $train.errors | nindent 2)) -}}
        {{- end -}}
      {{- else -}}
        {{- include "lib.utils.errors.fail" (printf "Render did not return valid YAML:\n%s" ($train_raw | nindent 2)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}  
{{- end -}}