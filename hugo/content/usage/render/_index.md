+++
title = "Render"
description = "Render Configuration"
weight = 6
geekdocCollapseSection = "false"
+++

The Render Template is executed at the end. When all the files are merged and the final output is generated. This template must output valid YAML so that Helm can use it for further operations.

## Predefined

The default Render template can be found here:

  * [https://github.com/buttahtoast/helmize/blob/master/charts/helmize/templates/render/templates/_default.tpl](https://github.com/buttahtoast/helmize/blob/master/charts/helmize/templates/render/templates/_default.tpl)

[You can change the Render Template](custom/)

## Reference

The render template which should be used is defined in the [helmize configuration](../../configuration/helmize/#render_template)



