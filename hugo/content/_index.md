---
---

 
{{< hint "info" >}}This project is in the early stages of development and still activiely maintained. You may encounter behavior that's not intended when making use of the project. If you find any bugs or have any questions feel free to open an issue.

Currently I dedicate my free time to it. I welcome any contributions and any feedback.{{< /hint >}}

# Why

We have created this solution since there was nothing that would let us deploy complex structures based on values that change. We started of using [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/) but as soon as you have factors like `environment`, `location`, `customer` etc. you end up with huge large folder structures. These structures make hard to integrate with any other system you may have in your CI/CD cycle and is hard to keep control of. [Das Schiff](https://github.com/telekom/das-schiff) did a great job with an example bootstrap structure in combination with [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/). But Kustomize does not deliver enough flexibility for such complex deployments. Another approach would be using [kraan](https://github.com/fidelity/kraan) which allows such control over layers.

But the easiest solution to this is creating a helm chart yourself and place some yaml files in it and then based on values given to the chart render the yaml or not. That's where helmize comes into play.

# How

Helmize is just a simple chart library which simplifies creating complex infrastructure deployments within helm charts. Through the use of Helm you don't need any additional operator or anything. It greatly integrates in any tool chain since you can customize it to your needs. It is complementary since it's just advanced rendering in a helm chart, that means you can deploy any other crds or whatever you need (eg. kraan layers). 

[Read More](getting-started/concept/)

# Who

This project is thought for people that bootstrap complex infrastructure setup on kubernetes and want the entire setup to be value driven. If you are looking for a simple solution for eg. a deployment for a single application this project might be too much overhead. If you have already experience with Helm it might be worth taking a look.