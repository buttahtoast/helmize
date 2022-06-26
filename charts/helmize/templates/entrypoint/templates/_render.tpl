

{{- define "helmize.entrypoint.templates.render" -}}
  {{- if $.deploy.files -}}
    {{- range $file, $prop := $.deploy.files -}}
      {{- if $prop.render -}}
        {{- if $prop.content -}}
          {{- printf "---\n# Identifers: %s\n# Subpath: %s\n# Checksum %s\n%s\n" .id .subpath $prop.checksum (toYaml $prop.content) -}}
          {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}} 
{{- end -}}