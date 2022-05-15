{{/* Identifier Template <Template>

  This is the default Template used 

  params <dict>: 
    content: <dict> File Content
    id: <dict> File identifier
    ctx: Required <dict> Global Context

  returns <dict>:
    id: <slice> Evaluated identifier(s)
    allowEmptyIds: <bool> Tells the evaluating template if empty id values are allowed
    errors: <slice> Errors encoutered during parsing

*/}}
{{- define "inventory.render.templates.identifier" -}}

  {{/* File has content */}}
  {{- if $.wagon.content -}}

    {{/* Concat Identifier Path */}}
    {{- $identifier_path := printf "%s.%s" (fromYaml (include "inventory.config.func.resolve" (dict "path" (include "inventory.render.defaults.file_cfg.key" $) "ctx" $.ctx))).res (include "inventory.render.defaults.file_cfg.identifier" $) -}}

    {{/* Check if dedicated id field is set */}}
    {{- $config_id := (fromYaml (include "lib.utils.dicts.lookup" (dict "data" $.wagon.content "path" $identifier_path))).res -}}
    {{- if $config_id -}}
      {{- if (kindIs "slice" $config_id) -}}
        {{- $_ := set $.wagon "id" (concat $.wagon.id $config_id) -}}
      {{- else -}}
        {{- $_ := set $.wagon "id" (append $.wagon.id $config_id) -}}
      {{- end -}}
    {{- end -}}

    {{/* kind-name identifier */}}
    {{- if $.wagon.content.kind -}}
      {{- with $.wagon.content.metadata -}}
        {{- if .name -}}
          {{- $_ := set $.wagon "id" (append $.wagon.id (printf "%s-%s.yaml" ($.wagon.content.kind | lower) ($.wagon.content.metadata.name | lower))) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}