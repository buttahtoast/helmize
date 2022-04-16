
+++
title = "Getting Started"
description = "Getting Started"
weight = 1
geekdocCollapseSection = false
+++

{{< toc-tree >}}

# Requirements

This documentation won't explain the core concepts of [Helm](https://helm.sh/) and [Sprig templating](http://masterminds.github.io/sprig/), it is expected that you know these technologies.The only requirement for helmize is [helm](https://helm.sh/docs/intro/install/). The library was tested with the following helm version:

  * v3.7.2

# Limitations

Merge of files is done with the [mergeOverwrite](http://masterminds.github.io/sprig/dicts.html) function that comes with Sprig. You can't combine any type of slice (lists). If you have two files with lists in a map, the prededing one will always overwrite the list contents. Therefor you must work around this with value templating when you want to combine values of lists.
