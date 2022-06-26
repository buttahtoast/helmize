{{- define "helmize.helpers.trailingPath" -}}
  {{- printf "%s" ($ | trimPrefix "/" | trimPrefix "./" | trimSuffix "/") -}}
{{- end -}}