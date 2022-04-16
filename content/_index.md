---
---

 
{{< hint "info" >}}This project is in the early stages of development and still actively maintained. You may encounter behavior that's not intended when using the project. If you find any bugs or have any questions, feel free to open an issue (Click the Github logo in the header){{< /hint >}}

# Why

We have created this solution since nothing would let us deploy complex structures based on values that changes. We started using [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/) but as soon as you have factors like `environment`, `location`, `customer` etc. you end up with huge large folder structures. These structures make it hard to integrate with any other system you may have in your CI/CD cycle and is hard to keep control of. [Das Schiff](https://github.com/telekom/das-schiff) did a great job with an example bootstrap structure in combination with [Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/). But Kustomize does not deliver enough flexibility for such complex deployments. Another approach would be using [kraan](https://github.com/fidelity/kraan), allowing such control over layers.

The easiest solution to this problem would be to create a new helm chart and render its files based on the values input. That's where helmize comes into play.

# How

Helmize is just a simple chart library that simplifies creating complex infrastructure deployments within helm charts. Through the use of Helm you don't need any additional operator or anything. It greatly integrates into any toolchain since you can customize it to your needs. It is complementary since it's just advanced rendering in a helm chart, which means you can deploy any other crds or whatever you need (e.g. kraan layers). 


[Read More](getting-started/concept/)

# Who

This project is thought for people who bootstrap complex infrastructure setup on kubernetes and want the entire setup to be value driven. If you are looking for a simple solution for, eg. a deployment for a single application, this project might be too much overhead. If you have already experience with Helm it might be worth taking a look.