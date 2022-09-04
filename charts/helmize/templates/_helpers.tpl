{{- define "helmize.helpers.ts" -}}
   {{- $_ := set $.ctx "timestamps" (append $.ctx.timestamps (dict "point" $.msg "time" now)) -}}
{{- end -}}

{{- define "helmize.helpers.trailingPath" -}}
  {{- printf "%s" ($ | trimPrefix "/" | trimPrefix "./" | trimSuffix "/") -}}
{{- end -}}