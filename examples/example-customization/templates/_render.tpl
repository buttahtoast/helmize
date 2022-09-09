{{- define "customization.render.template" -}}
  {{- range $wagon := $.train.wagons -}}

   {{/* Validate Annotations */}}
   {{- if (get (default dict $wagon.content.metadata.labels) "render")  -}}
     {{- $_ := set $wagon "render" false -}}
   {{- end -}}

   {{/* Include Default Wagon Render Template */}}
   {{- include "helmize.render.templates.default.wagon" (dict "wagon" $wagon "ctx" $.ctx) -}}

  {{- end -}}
{{- end -}}