

{{- define "helmize.entrypoint.templates.render" -}}
  {{- if $.deploy.files -}}
    {{- range $file, $prop := $.deploy.files -}}
      {{- if $prop.render -}}
        {{- if $prop.content -}}

          {{/* Manifest Delimiter */}}
          {{- printf "---" -}}

          {{/* Add Debug Information */}}
          {{- if (include "helmize.entrypoint.func.debug" $.ctx) -}}
            {{ if $prop.debug -}}
              {{- with $debug := (toYaml (dict "Debug Output" $prop.debug)) -}}
                {{- range $s := (splitList "\n" $debug) -}}
                  {{- printf "# %s" $s | nindent 0  -}}
                {{- end -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}

          {{/* Information */}}
          {{- printf "\n# Identifers: %s\n# Subpath: %s\n# Checksum %s\n%s\n" .id .subpath $prop.checksum (toYaml $prop.content) -}}

        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}} 
{{- end -}}