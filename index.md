## Introduction

Helmize is a simple deployment library wrapped in a library helm chart. It's purpose is to simplify complex infrastructure deployments where you change deployed manifests based on given conditions. This project is thought for people that bootstrap complex infrastructure setup on kubernetes and want to simplify their file structure. 

## How it works





# Getting Started 






## Requirements 

This documentation won't explain the core concepts of [Helm](https://helm.sh/) and [Sprig templating](http://masterminds.github.io/sprig/), it is expected that you know these technologies.

The only requirement for helmize is [helm](https://helm.sh/docs/intro/install/). The library was tested with the following helm version:

  * v3.7.2

## Initialize

First we create a new helm chart which is going to contain the entire deployment structure for helmize. We can simply do that with the following comment (In this case I will call the new chart `infrastructure`, chose the name you would like):

```
helm create infrastructure
```






First you include the chart 





