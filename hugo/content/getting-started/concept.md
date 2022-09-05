+++ 
title = "Concept" 
description = "Concept" 
weight = 1
+++

Helmize is included as library chart. It just has all the function it needs to render the structure you give it and then returns the resulting contents. So it's basically just a render engine. 

In the below image we have the Releases (which are effecitively values which install your helm chart). In your helm chart you see different yamls organized in a structure which depends on input conditions eg. `locations`. Your chart includes a [configuration file](../../configuration/) which defines these conditions and allows you to map it two values. Helmize will read the configuration and render inputs according to it. 

<img src="/concept.png" alt="concept" style="width:100%;"/>


For the `Release Vanilla` we see, that we have a configuration for the `location` which is `east` and a configuration for the `env` which is `dev`. On Install all files in the `base/` folder are used, since these apply for all releases. For the location only the files in the `location/east` folder are considered. Same for the environment, only files in the `environments/dev`folder are considered. The release does not have a value for a customer but in the configuration we specified that the default value for customer is `default`. Therefor all files under `customer/default` are considered as well. 


For the `Release Customer A` we see, that we have a value for the `location` which is `west`, a value for the `env` which is `dev` and `prod` and a value for `customer` which is `A`. On Install all files in the `base/` folder are used, since these apply for all releases. For the `location` only the files in the `location/west` folder are considered. Same for the environment, only files in the `environments/dev` and `environments/prod` folder are considered. The `customer` is set to `A` therefor all files under `customer/A` are considered as well.

For both examples you might notice, that files with the same name are only present once in the resulting files. That's because their content was merged. This way can just change eg. the version in the `release.yaml` without having to replicate the entire content and can adjust values on stage basis.

**That's it**, See [Quickstart](../quickstart) for an easy example how to setup helmize up.