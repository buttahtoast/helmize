# Example file-cfg

This example showcases the usage of the [file_config_key](https://helmize.dev/documentation/configuration/general/#file_config_key) configuration option.

Within the [helmize.yaml](./helmize.yaml) the `file_config_key` is set to `metadata.helmize`. Therefor all the manifests below `structure/` define [file configuration](https://helmize.dev/documentation/structure/files/) below the key `metadata.helmize`. When rendered, the key `metadata.helmize` is no longer present, but the configuration was applied.