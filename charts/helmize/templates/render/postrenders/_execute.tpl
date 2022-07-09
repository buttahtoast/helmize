{{/* Render <Template> 

  Allows to run postrenderes for each file on a component. The components which are executed are 
  used from the "inventory.postrenders.includes" template.

  params <dict>: 
    file: <dict> Train File declaration
    extra_ctx: Optional <dict> Extra variables that are available during templating
    extra_ctx_key: Optional <string> Under which top key the given extra variables are publishes. Defaults to 'inv'
    ctx: <dict> Global Context

  returns  <dict>: Modified component


  PostRenderers:

    Each PostRenderer gets the following two arguments:
    
      File <dict>: File parameters
      content <dict>: Content of the current iterated file
      context <dict>: Global Context
  
    The post Renderer must supply a valid dictionary which can be formatted from yaml. It's your responsability to test
    self added postrenderers. The postrenderer can overwrite the entire content.
    Each postrenderer must return the following:
  
      content <dict>
      errors <slice>
  
    If any errors are returned the content is not considered and the errors will be returned. 
    Is the content empty, it won't be considered as well.

*/}}
{{- define "helmize.render.func.postrenders.execute" -}}
  {{- if and $.file $.ctx -}}

    {{/* Extra Context */}}
    {{- $context := $.ctx -}}

    {{/* File has Content */}}
    {{- if $.file.content -}}

      {{/* Load Renderers */}}
      {{- $renders := default list (fromYaml (include "helmize.render.func.postrenders.get" (dict "ctx" $.ctx))).renders -}}

      {{/* Prepend File Post-Renderers */}}
      {{- with $.file.post_renderers -}}
        {{- $renders = concat . $renders -}}
      {{- end -}}

      {{/* Redirect All Post Renderers to File */}}
      {{- $_ := set $.file "post_renderers" $renders -}}

      {{/* Execute Renderers */}}
      {{- $content_buff := $.file.content -}}
      {{- range $ren := $renders -}}

        {{/* Execute Renderer */}}
        {{- $postrender_result_raw := include $ren (dict "content" $content_buff "File" (omit $.file "content") (default "inv" $.extra_ctx_key) (default dict $.extra_ctx) "ctx" $context) -}}
        {{- $postrender_result := fromYaml ($postrender_result_raw) -}}

        {{/* Validate Content */}}
        {{- if $.file.content -}}
          {{- if (not (kindIs "map" $.file.content)) -}}
            {{- $_ := set $.file "errors" (append $.file.errors (dict "error" (printf "Content is kind '%s' but should be 'map'" (kindOf $.file.content)) "post-renderer" $ren "trace" $.file.content)) -}}
          {{- end -}}
        {{- else -}}
          {{- if (include "helmize.entrypoint.func.debug" $.ctx) -}}
            {{- $_ := set $.file "debug" (append $.file.debug (dict "post-renderer" $ren "debug" "Empty Content")) -}}
          {{- end -}}
        {{- end -}}

        {{/* Validate Returned Metadata */}}
        {{- if not (include "lib.utils.errors.unmarshalingError" $postrender_result) -}}

          {{/* Debug Output */}}
          {{- if and $postrender_result.debug (kindIs "slice" $postrender_result.debug) -}}
            {{- range $deb := $postrender_result.debug -}}
              {{- $_ := set $.file "debug" (append $.file.debug (dict "post-renderer" $ren "debug" $deb)) -}}
            {{- end -}}
          {{- end -}}

          {{/* Returns Post Renderer Errors */}}
          {{- if and $postrender_result.errors (kindIs "slice" $postrender_result.errors) -}}
            {{- range $err := $postrender_result.errors -}}
              {{- $_ := set $.file "errors" (append $.file.errors (dict "post-renderer" $ren "error" $err)) -}}
            {{- end -}}
          {{- end -}}

        {{- else -}}
          {{- include "lib.utils.errors.fail" (printf "Template %s returned invalid YAML (%s):\n%s" $ren $postrender_result.Error ($postrender_result_raw | nindent 2)) -}}
        {{- end -}}
      {{- end -}}
      {{- $_ := set $.file "content" $content_buff -}}
    {{- end -}}

  {{- end -}}
{{- end -}}