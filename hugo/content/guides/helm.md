+++
title = "Helm"
description = "Helm"
weight = 1
+++
 
The ecosystem of helm already provides different plugins and solutions which can be used to implement more advanced concepts.

## Post-Rendering

Helm offers the option to embed your own post renderers. They allow to usage of other executables. In contrast, our post renderers are a bit simpler, but just scoped to the possibilities Srig itself has to offer. Read more:

  * [https://helm.sh/docs/topics/advanced/#post-rendering](https://helm.sh/docs/topics/advanced/#post-rendering)

## Secrets

[Helm-Secrets](https://github.com/jkroepke/helm-secrets) is a great plugin which allows to encrypt helm secrets via sops.

### Other Solutions

There are different Solutions which help you to organize your secrets in a safe way:

  * [External Secrets](https://github.com/external-secrets/kubernetes-external-secrets)
  * [SOPS](https://github.com/mozilla/sops)
  * [Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets.git)

