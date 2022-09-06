{{/* Resolve <Template> 

  Resolve the entire render structure

  params <dict>: Global Context

  returns <dict>:
    conditions <slice>: All applied conditions
    files <slice>: contains all files
    errors <int>: amount of errors during file collection
    
*/}}
{{- define "helmize.core.func.resolve" -}}

  {{/* Variables */}}
  {{- $ctx := $ -}}
  {{- $return := dict "wagons" list "errors" list "paths" list "timestamps" list "conditions" -}}

  {{/* Fetch Conditions */}}
  {{- $conds := fromYaml (include "helmize.conditions.func.resolve" (dict "ctx" $ctx)) -}}
  {{- if (not (include "lib.utils.errors.unmarshalingError" $conds)) -}}

    {{/* Error Redirect */}}
    {{- if $conds.errors -}}
      {{- $_ := set $return "errors" (concat $return.errors $conds.errors) -}}
    {{- end -}}

    {{/* Debug */}}
    {{- if (include "helmize.render.func.debug" $.ctx) -}}
      {{- $_ := set $return "conditions" $conds.conditions -}}
    {{- end -}}
      
    {{/* Iterate over each condition to get paths for file lookups */}}
    {{- $paths := list -}}
    {{- $_ := set $return "conditions" $conds.conditions -}}
    {{- range $conds.conditions -}}
      {{- if .errors -}}
        {{- $_ := set $return "errors" (concat $return.errors .errors) -}}
      {{- else -}}
        {{- if .paths -}}
          {{- $paths = append $paths (dict "paths" .paths "config" .config.file_cfg "renderers" .config.renderers "data" .data "value" .value)  -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

    {{/* Benchmark */}}
    {{- include "helmize.helpers.ts" (dict "msg" "Conditions initialized" "ctx" $return) -}}
    {{- $_ := set $return "paths" $paths  -}}

    {{/* Only Lookup files if any path is present */}}
    {{- if $paths -}}

      {{/* Lookup actual files in the given paths */}}
      {{- $func_files := (dict "tpl" "helmize.core.func.finder" "ctx" (dict "paths" $paths "ctx" $ctx)) -}}
      {{- $files := (fromYaml (include $func_files.tpl $func_files.ctx)) -}}
      {{- if (not (include "lib.utils.errors.unmarshalingError" $files)) -}}

        {{/* Error Redirect */}}
        {{- with $files.errors -}}
          {{- $_ := set $return "errors" (concat $return.errors .) -}}
        {{- end -}}

        {{/* If any files were found */}}
        {{- if $files.files -}}

          {{/* Debug */}}
          {{- if (include "helmize.render.func.debug" $ctx) -}}
            {{- $_ := set $return "paths" $files.files -}}
          {{- end -}} 

          {{/* Benchmark */}}
          {{- include "helmize.helpers.ts" (dict "msg" "Files initialized" "ctx" $return) -}}

          {{/* Execute File Train */}}
          {{- $train := fromYaml (include "helmize.core.func.train" (dict "files" $files.files "groups" $.groups "ctx" $ctx "ts" $return)) -}}

          {{/* Benchmark */}}
          {{- include "helmize.helpers.ts" (dict "msg" "Train initialized" "ctx" $return) -}}
          {{- if (not (include "lib.utils.errors.unmarshalingError" $train)) -}}
            
            {{/* Error Redirect */}}
            {{- with $train.errors -}}
              {{- $_ := set $return "errors" (concat $return.errors $train.errors) -}}
            {{- end -}}
           {{/* Files Redirect */}}
            {{- with $train.wagons -}}
              {{- $_ := set $return "wagons" . -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}  
      {{- else -}}
        {{- include "lib.utils.errors.fail" (printf "Template helmize.core.func.finder Returned invalid YAML:\n%s" (toYaml $func_files | nindent 2)) -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
    {{- include "lib.utils.errors.fail" (printf "Template helmize.conditions.func.resolve returned invalid YAML:\n%s" $conds) -}}
  {{- end -}}

  {{/* Return */}}
  {{- printf "%s" (toYaml $return) -}}

{{- end -}}