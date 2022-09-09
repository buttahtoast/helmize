
+++
title = "Getting Started"
description = "Getting Started"
weight = 1
geekdocCollapseSection = false
+++

{{< toc-tree >}}

# Helm

This documentation won't explain the core concepts of [Helm](https://helm.sh/) and [Sprig templating](http://masterminds.github.io/sprig/), it is expected that you know these technologies.The only requirement for helmize is [helm](https://helm.sh/docs/intro/install/). 

# Requirements

It's required to use a Helm Version `>= 3.5.0` (above or equal). Versions below are missing the `addf` function, which is used within helmize.

# Testing

Helmize is unit-tested with the following helm versions:

  * `v3.5.4`
  * `v3.6.3`
  * `v3.7.1`
  * `v3.8.2`
  * `latest`

This way we can detect breaking changes and avoid them.