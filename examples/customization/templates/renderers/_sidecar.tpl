{{- define "customization.renderers.sidecar" -}}
  {{- $return := dict "errors" list "debug" list -}}
  {{- $kind := (lower (default "" $.content.kind) | toString) -}}

  {{/* Verify if Kind persent */}}
  {{- if $kind -}}

    {{/* Same Spec Path */}}
    {{- if (has $kind (list "deployment" "statefulset" "daemonset")) -}}
      {{- $_ := set $.content.spec.template.spec "containers" (append $.content.spec.template.spec.containers (fromYaml (include "customization.renderers.sidecar.template" $))) -}}
  
    {{/* Different Path for Pods */}}
    {{- else if (eq $kind "pod") -}}
      {{- $_ := set $.content.spec "containers" (append $.content.spec.containers (fromYaml (include "customization.renderers.sidecar.template" $))) -}}
  
    {{- end -}}

  {{/* Set Error on empty Kind */}}
  {{- else -}}
    {{- $_ := set $return "errors" (append $return.errors "No Kind Defined") -}}

  {{- end -}}

  {{/* Return Metadata (Errors/Debug) */}}
  {{- printf "%s" (toYaml $return) -}}
  
{{- end -}}


{{/* JMX Sidecar Container Template */}}
{{- define "customization.renderers.sidecar.template" -}}
name: "jmx"
command:
  - java
  - -XX:+UnlockExperimentalVMOptions
  - -XX:+UseCGroupMemoryLimitForHeap
  - -XX:MaxRAMFraction=1
  - -XshowSettings:vm
  - -jar
  - jmx_prometheus_httpserver.jar
  - "90001"
  - /opt/jmx-config/jmx-prometheus.yml
ports:
  - name: "jmx"
    containerPort: 9001
{{- end -}}