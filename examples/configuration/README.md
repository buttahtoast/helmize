# Example file-cfg

This example showcases the usage of the [file_config_key](https://helmize.dev/documentation/configuration/general/#file_config_key) configuration option.

Within the [helmize.yaml](./helmize.yaml) the `file_config_key` is set to `metadata.helmize`. Therefor all the manifests below `structure/` define [file configuration](https://helmize.dev/documentation/structure/files/) below the key `metadata.helmize`. When rendered, the key `metadata.helmize` is no longer present, but the configuration was applied.

## Playground

To execute the example run the following commands (assuming the current working directory is this directory):

```
helm depdendency update
helm template .
```

Extended output via [debug options](https://helmize.dev/documentation/debug/):

```
helm template . --set summary=true --set debug=true
```

## Unit Tests

This Chart serves as Unit-Test to ensure changes don't remove functionalities or have other unwanted side-effects. Unit-Tests are part of the CI workflow. We use this fork of the helm plugin:

  * [https://github.com/quintush/helm-unittest](https://github.com/quintush/helm-unittest)

### Update

If there's new changes to the snapshot compare, you can update the snapshots with:

```
helm unittest --color -f unit_tests/*_test.yaml -3 -u .
```