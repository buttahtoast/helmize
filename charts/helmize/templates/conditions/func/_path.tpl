{{/* Path <Template> 

  Returns the Path in a normalized format

  params <dict>:
    cond <string> Required: Condition Name
    path <string> Required: Condition Path
    ctx <dict> Required: Global Context

  returns <string>: Formatted Condition Path

*/}}
{{- define "helmize.conditions.func.path" -}}
  {{- if and $.path $.ctx -}}
    {{- $base_directory := (fromYaml (include "helmize.config.func.resolve" (dict "path" (include "helmize.config.defaults.inv_dir" $.ctx) "ctx" $.ctx))).res -}}
    {{- $base_path := (include "helmize.helpers.trailingPath" $.path) -}}
    {{- if $base_directory -}}
      {{- $base_path = (printf "%s/%s" (include "helmize.helpers.trailingPath" $base_directory | trimSuffix "/") $base_path) -}}
    {{- end -}}
    {{/* Full Path (Caputre if cond is only / -> allow root */}}
    {{- $path := "" -}}
    {{- $cond := ($.cond | trimAll "/") -}}
    {{- if $cond -}}
      {{- $path = (printf "%s/%s" ($base_path | trimSuffix "/") $cond) -}}
    {{- else -}}
      {{- $path = (printf "%s" ($base_path | trimSuffix "/")) -}}
    {{- end -}}
    {{/* Append Suffix if given */}}
    {{- if $.suffix -}}
      {{- $path = (printf "%s/%s" $path ($.suffix | trimAll "/")) -}}
    {{- end -}}
    {{- printf "%s/" $path -}}
  {{- else -}}
    {{- include "lib.utils.errors.params" (dict "tpl" "helmize.conditions.func.path" "params" (list "cond" "path" "ctx")) -}}
  {{- end -}}
{{- end -}}