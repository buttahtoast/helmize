# example-yaml

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

Advanced YAML file examples

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../../charts/helmize | helmize | >=0.0.0-0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| public_repos | object | `{"external_dns":"https://kubernetes-sigs.github.io/external-dns/","jetstack":"https://charts.jetstack.io","metallb":"https://metallb.github.io/metallb"}` | Public Helm Repositories |
| repo.interval | string | `"1m"` | Global Repository Interval |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)