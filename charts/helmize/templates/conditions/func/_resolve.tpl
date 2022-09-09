{{/* Resolve <Template> 

  Returns all possible paths considered all the given conditions

  params <dict>:
    ctx <dict> Required: Global Context
  returns <dict>:
    conditions <slice>: All Conditions with their valid paths
    errors <slice>: Errors during condition validation

*/}}
{{- define "helmize.conditions.func.resolve" -}}
  {{- $return :=  dict "conditions" list "errors" list -}}
  {{- if $.ctx -}}
 
    {{/* Get All Conditions */}}
    {{- $conditions := fromYaml (include "helmize.conditions.func.get" $.ctx) -}}

    {{/* Shared Data Buffer */}}
    {{- $shared_data := dict -}}

    {{/* Evaluate each condition */}}
    {{- if $conditions -}}

      {{/* Error Redirect */}}
      {{- with $conditions.errors -}}
        {{- $_ := set $return "errors" (concat $return.errors .) -}}
      {{- end -}}

      {{/* Iterate over Conditions */}}
      {{- range $condition := $conditions.conditions -}}
  
        {{/* Condition Variables */}}
        {{- $condition_keys := list -}}
        {{- $condition_struct := dict "name" (get $condition (include "helmize.conditions.defaults.conditions.name" $)) "errors" list "paths" list "keys" list "config" $condition "errors" list "data" dict -}}
        
        {{/* Assign Root Path */}}
        {{- $_ := set $condition_struct "root_path" (default $condition_struct.name (get $condition (include "helmize.conditions.defaults.conditions.path" $))) -}}

        {{/* Value Key */}}
        {{- $value_key := "" -}}
        {{- if (get $condition (include "helmize.conditions.defaults.conditions.key" $)) -}}
          {{- $v := (get $condition (include "helmize.conditions.defaults.conditions.key" $)) -}}
          {{- $value_key = (trimAll "." $v) -}}
        {{- end -}}

        {{/* Add Condition Keys */}}
        {{- $key := "" -}}
        {{- if $value_key -}}
          {{- $key = (fromYaml (include "lib.utils.dicts.get" (dict "data" $.ctx.Values "path" $value_key "required" (default false (get $condition (include "helmize.conditions.defaults.conditions.required" $)))))).res -}}
        {{- end -}}
        
        {{/* Assign Default if available */}}
        {{- if and (not $key) (get $condition (include "helmize.conditions.defaults.conditions.default" $)) -}}
          {{- $key = (get $condition (include "helmize.conditions.defaults.conditions.default" $)) -}}

          {{/* Set Default in Values */}}
          {{- if $value_key -}}
            {{- include "lib.utils.dicts.set" (dict "path" $value_key "data" $.ctx.Values "value" $key) -}}
          {{- end -}}

        {{- end -}}

        {{/* If Key has Value */}}
        {{- if $key -}}

          {{/* Redirect to Slice */}}
          {{- if (kindIs "slice" $key) -}}
            {{- $condition_keys = concat $condition_keys $key -}}
          {{- else -}}
            {{- $condition_keys = append $condition_keys $key -}}
          {{- end -}}

          {{/* Validate Key Type */}}
          {{- $type_error := 1 -}}
          {{- $key_types := (get $condition (include "helmize.conditions.defaults.conditions.key_types" $)) -}}
          {{- if $key_types -}}
            {{- range $key_types -}}
              {{- if (kindIs . $key) -}}
                {{- $type_error = 0 -}}
              {{- end -}}
            {{- end -}}
          {{- else -}}
            {{- $type_error = 0 -}}
          {{- end -}}
          {{- if $type_error -}}
              {{- $_ := set $condition_struct "errors" (append $condition_struct.errors (dict "condition" $condition_struct.name "error" (printf "Value for condition must be %s but is %s" ($key_types| join ", ") (kindOf $key)))) -}}
          {{- end -}}
        {{- end -}}  

        {{/* Apply a filter to all results */}}
        {{- $filter := (get $condition (include "helmize.conditions.defaults.conditions.filter" $)) -}}
        {{- if $filter -}}
          {{/* Append Default Value to filter */}}
          {{- if (get $condition (include "helmize.conditions.defaults.conditions.default" $)) -}}
            {{- $filter = (append $filter (get $condition (include "helmize.conditions.defaults.conditions.default" $)) | uniq) -}}
          {{- end -}}
          {{/* Run Filter for each Condition Value */}}
          {{- range $con := $condition_keys -}}
            {{- $err := 1 -}}
            {{- range $filter -}}
              {{- if (regexMatch . $con) -}}
                {{- $err = 0 -}}
              {{- end -}}
            {{- end -}}
            {{- if $err -}}
              {{- $_ := set $condition_struct "errors" (append $condition_struct.errors (dict "condition" $condition_struct.name "error" (printf "Value %s is not allowed (Allowed values: %s)" $con ($filter| join ", ")))) -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}

        {{/* Add Base */}}
        {{- if (get $condition (include "helmize.conditions.defaults.conditions.any" $)) -}}
          {{- $condition_keys = prepend  $condition_keys "/" -}}
        {{- end -}}

        {{/* Set Key Value */}}
        {{- $_ := set $condition_struct "value" (default dict $key) -}}

        {{/* Combine Data */}}
        {{- $shared_data = (mergeOverwrite $shared_data (default dict (get $condition (include "helmize.conditions.defaults.conditions.data" $)))) -}}
        {{- $_ := set $condition_struct "data" $shared_data -}}      

        {{/* Create Path for each Condition Key */}}
        {{- $condition_keys = $condition_keys | uniq -}}
        {{- if $condition_keys -}}
          {{- $_ := set $condition_struct "keys" $condition_keys -}}
          {{- range $condition_keys -}}
            {{- $path := include "helmize.conditions.func.path" (dict "path" $condition_struct.root_path "cond" . "cpt" $.cpt "ctx" $.ctx) -}}
            {{- $_ := set $condition_struct "paths" (append $condition_struct.paths $path) -}}
          {{- end -}}
        {{- end -}}

        {{/* Run Templates */}}
        {{- if (get $condition (include "helmize.conditions.defaults.conditions.tpls" $)) -}}
          {{- include "helmize.conditions.func.resolve.templates" (dict "tpls" (get $condition (include "helmize.conditions.defaults.conditions.tpls" $)) "condition" $condition_struct "conditions" $return.conditions "ctx" $.ctx) -}}
        {{- end -}}
        {{- $shared_data = (mergeOverwrite $shared_data (default dict (get $condition (include "helmize.conditions.defaults.conditions.data" $)))) -}}
          
        {{/* Append as Return */}}
        {{- $_ := set $return "conditions" (append $return.conditions $condition_struct) -}}

      {{- end -}}
    {{- end -}}  
  
    {{/* Return */}}
    {{- printf "%s" (toYaml $return) -}}

  {{- else -}}
    {{- include "lib.utils.errors.params" (dict "tpl" "helmize.conditions.func.resolve" "params" (list "ctx")) -}}
  {{- end -}}
{{- end -}}

{{- define "helmize.conditions.func.resolve.templates" -}}
  {{- range $t := $.tpls -}}
    {{- range $path, $_ :=  $.ctx.Files -}}
      {{- if (regexMatch (lower $t) (lower $path)) -}}
          
        {{/* Get File */}}
        {{- $tpl_content := ($.ctx.Files.Get $path) -}}

        {{/* Prepare Context */}}
        {{- $context := (set (set (set $.ctx "data" $.condition.data) "value" $.condition.value) "conditions" $.conditions) -}}

        {{/* Template File */}}
        {{- $template_content_raw := tpl $tpl_content $context -}}

        {{/* Parse Content as YAML */}}
        {{- $parsed_content := (fromYaml ($template_content_raw)) -}}

        {{- $_ := (unset (unset (unset $context "data") "value") "conditions") -}}

        {{/* Validate if parse was successful, otherwise return with error */}}
        {{- if not (include "lib.utils.errors.unmarshalingError" $parsed_content) -}}

          {{/* Set Condition Data */}}
          {{- $_ := set $.condition "data" (mergeOverwrite (default dict $.condition.data) $parsed_content) -}}

        {{- else -}}

          {{/* Redirect Error on Condition */}}
           {{- $_ := set $.condition "errors" (append $.condition.errors (dict "error" (printf "Template %s (matched %s) did not return valid YAML" $path $t) "msg" $parsed_content.Error "trace" ($template_content_raw))) -}}
          
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}