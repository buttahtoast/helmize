{{/* Default Variables */}}
{{- $env := "" -}}
{{- $location := "" -}}

{{/* Iterate over previous Conditions */}}
{{- range $c := $.conditions -}}

  {{/* Evaluate Environment */}}
  {{- if (eq $c.name "environment") -}}
    {{- $env = default "" $c.value -}}

  {{/* Evaluate Location */}}
  {{- else if (eq $c.name "location") -}}
    {{- $location = default "" $c.value -}}
  {{- end -}}

{{- end -}}

{{/* Return Data */}}
ingress_name: frontend.{{ $env }}.{{ $location }}.company.com