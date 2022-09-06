# Example Identifiers

This example showcases all the different identifier outcomes.

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

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| custom | bool | `true` | Show custom Identifiers |
| file_name | bool | `true` | Show File Name Identifiers |
| kind | bool | `true` | Show Kind Identifiers |
| multi | bool | `true` | Enable Multi YAMl Identifers |

## Unit Tests

This Chart serves as Unit-Test to ensure changes don't remove functionalities or have other unwanted side-effects. Unit-Tests are part of the CI workflow. We use this fork of the helm plugin:

  * [https://github.com/quintush/helm-unittest](https://github.com/quintush/helm-unittest)

### Update

If there's new changes to the snapshot compare, you can update the snapshots with:

```
helm unittest --color -f unit_tests/*_test.yaml -3 -u .
```