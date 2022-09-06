+++
title = "Usage"
description = "Usage Documentation"
weight = 2
+++

Here's a simplified overview of the workflow that helmize goes through in order to render files. Understanding the workflow might help with the different usage topics, since they are referenced below in which step they become relevant.

<img src="/usage.png" alt="Usage" style="width:100%;"/>

To give a bit more context:

  * **1/2**: To initialize Helmize tries to resolve to [configuration](../../configuration) that is used. If the configuration is valid Helmize will fail with an indicating error.
  * **3**: Based on the resulting