{{- $_ := set $.ctx.Values.kube_prometheus_stack "enabled" true -}}
ctx: {{- toYaml $ | nindent 2 }}