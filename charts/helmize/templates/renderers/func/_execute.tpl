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
{{- define "helmize.renderers.func.execute" -}}
  {{- if and $.wagon $.ctx -}}

    {{/* Extra Context */}}
    {{- $context := $.ctx -}}

    {{/* File has Content */}}
    {{- if $.wagon.content -}}

      {{/* Load Renderers */}}
      {{- $renders := default list (fromYaml (include "helmize.renderers.func.get" (dict "ctx" $.ctx))).renders -}}

      {{/* Prepend File Renderers */}}
      {{- with $.wagon.renderers -}}
        {{- $renders = concat . $renders -}}
      {{- end -}}

      {{/* Redirect All Renderers to File */}}
      {{- $_ := set $.wagon "renderers" $renders -}}

      {{/* Execute Renderers */}}
      {{- $content_buff := $.wagon.content -}}
      {{- range $ren := $renders -}}

        {{/* Execute Renderer */}}
        {{- $render_result_raw := include $ren (dict "content" $content_buff "Wagon" (omit $.wagon "content") "ctx" $context) -}}
        {{- $render_result := fromYaml ($render_result_raw) -}}

        {{/* Validate Content */}}
        {{- if $.wagon.content -}}
          {{- if (not (kindIs "map" $.wagon.content)) -}}
            {{- $_ := set $.wagon "errors" (append $.wagon.errors (dict "error" (printf "Content is kind '%s' but should be 'map'" (kindOf $.wagon.content)) "post-renderer" $ren "trace" $.wagon.content)) -}}
          {{- end -}}
        {{- else -}}
          {{- if (include "helmize.entrypoint.func.debug" $.ctx) -}}
            {{- $_ := set $.wagon "debug" (append $.wagon.debug (dict "renderer" $ren "debug" "Empty Content")) -}}
          {{- end -}}
        {{- end -}}

        {{/* Validate Returned Metadata */}}
        {{- if not (include "lib.utils.errors.unmarshalingError" $render_result) -}}

          {{/* Debug Output */}}
          {{- if and $render_result.debug (kindIs "slice" $render_result.debug) -}}
            {{- range $deb := $render_result.debug -}}
              {{- $_ := set $.wagon "debug" (append $.wagon.debug (dict "renderer" $ren "debug" $deb)) -}}
            {{- end -}}
          {{- end -}}

          {{/* Returns Renderer Errors */}}
          {{- if and $render_result.errors (kindIs "slice" $render_result.errors) -}}
            {{- range $err := $render_result.errors -}}
              {{- $_ := set $.wagon "errors" (append $.wagon.errors (dict "renderer" $ren "error" $err)) -}}
            {{- end -}}
          {{- end -}}

        {{- else -}}
          {{- include "lib.utils.errors.fail" (printf "Template %s returned invalid YAML (%s):\n%s" $ren $render_result.Error ($render_result_raw | nindent 2)) -}}
        {{- end -}}
      {{- end -}}
      {{- $_ := set $.wagon "content" $content_buff -}}
    {{- end -}}

  {{- end -}}
{{- end -}}