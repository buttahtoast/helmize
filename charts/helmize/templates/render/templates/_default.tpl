

{{- define "helmize.render.templates.default" -}}
  {{- if $.train -}}
    {{- if $.train.wagons -}}
      {{- range $wagon := $.train.wagons -}}
        {{ include "helmize.render.templates.default.wagon" (dict "wagon" $wagon "ctx" $.ctx) }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}


{{- define "helmize.render.templates.default.wagon" -}}
  {{- if $.wagon -}}
    {{/* Render if Attribute True */}}
    {{- if $.wagon.render -}}
      {{/* Verify File has content */}}
      {{- if $.wagon.content -}}

        {{/* Manifest Delimiter */}}
        {{- printf "---" -}}

        {{/* Add Debug Information */}}
        {{- if (include "helmize.render.func.debug" $.ctx) -}}
          {{- if $.wagon.debug -}}
            {{- with $debug := (toYaml (dict "Debug Output" $.wagon.debug)) -}}
              {{- range $s := (splitList "\n" $debug) -}}
                {{- printf "# %s" $s | nindent 0  -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}

        {{/* Print File */}}
        {{- printf "\n# Identifers: %s\n# Subpath: %s\n# Checksum %s\n%s\n" $.wagon.id $.wagon.subpath $.wagon.checksum (toYaml $.wagon.content) -}}
  
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}  