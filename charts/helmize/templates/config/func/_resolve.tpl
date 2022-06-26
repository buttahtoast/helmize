{{/* Resolve <Template> 

  Get a specific key path from the config

  params <dict>: 
    path: <dict> Role to resolve
    req: <bool> If required and the value does not exist, the template will fail
    ctx: <dict> Global Context

  returns <string>: Value from given path

*/}}
{{- define "helmize.config.func.resolve" -}}
  {{- if and $.path $.ctx }}
    {{- $cfg := dict -}}

    {{/* Resolve from Context */}}
    {{- if (get $.ctx "Config") -}}
      {{- $cfg = (get $.ctx "Config") -}}

    {{/* Resolve from File */}}
    {{- else -}}
      {{- $cfg = fromYaml (include "helmize.config.func.get" $.ctx) -}}
    {{- end -}}

    {{/* Execute Lookup */}}
    {{- $result := include "lib.utils.dicts.lookup" (dict "data" $cfg "path" $.path "required" (default false $.req)) -}}
    {{- printf "%s" ($result) -}}

  {{- else -}}
    {{- include "lib.utils.errors.params" (dict "tpl" "helmize.render.files.parse" "params" (list "path" "ctx")) -}}
  {{- end -}}
{{- end -}}