+++
title = "Renderers"
description = "Renderers"
weight = 5
geekdocCollapseSection = "false"
+++

Renderers are executed after all the files are merged within the train. They allow to make changes on the resulting manifests or even validate the integrity of the content. Renderers are executed once all the the files are merged into wagons. In contrast to the [Render](../render/) template, renderers can be defined via conditions and globally. This allows to apply Renderers on files based on folder origin.

## Predefined

Helmize comes with simple Renderers, which can be referenced in the configuration. All the available Renderers can be found here:

  * [https://github.com/buttahtoast/helmize/blob/master/charts/helmize/templates/renderers/templates/](https://github.com/buttahtoast/helmize/blob/master/charts/helmize/templates/renderers/templates/)

We are happy to accept any useful Renderers as contribution.

## Reference

Renderers are referenced via configuration. You can either enable post renderers for all files via [the helmize configuration]() or [based on condition](../../configuration/conditions/#renderers).