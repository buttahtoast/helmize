# Example Data

This example showcases the effects of the [Data Handling](https://helmize.dev/documentation/structure/data/) configuration option.

With all the different layers data is manipulated across them. For each layer the results are printed to visualize how certain operations behaive.

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

### Show Context

Outputs the context per layer availble for each file/condition:

```
helm template . --set showContext=true
```

### Faulty Template

See what happens when a condition template returns wrong YAML:

```
helm template . --set faulty=true
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| faulty | bool | `false` | Enable Faulty Layer |
| showContext | bool | `false` | Show Context per Layer |
| showData | bool | `true` | Show Data per Layer |
| showValue | bool | `true` | Show Condition Value per Layer |

## Unit Tests

This Chart serves as Unit-Test to ensure changes don't remove functionalities or have other unwanted side-effects. Unit-Tests are part of the CI workflow. We use this fork of the helm plugin:

  * [https://github.com/quintush/helm-unittest](https://github.com/quintush/helm-unittest)

### Update

If there's new changes to the snapshot compare, you can update the snapshots with:

```
helm unittest --color -f unit_tests/*_test.yaml -3 -u .
```