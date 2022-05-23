+++
title = "Data"
description = "Data Handling"
weight = 3
+++

{{< hint "info" >}}[https://github.com/buttahtoast/helmize/tree/main/examples/data](https://github.com/buttahtoast/helmize/tree/main/examples/data){{< /hint >}}

Data is shared over a specific field across all files. Data can originate from [Conditions]() or you can manipulate the data to a certain extend.


# Manipulate

{{< hint "warning" >}}With Data manipulation you can potentialy break the entire functionality. Make sure to only manipulate values under $.Data and be aware of what you are doing.{{< /hint >}}

You can manipulate data from files into the shared file store, since the `set` and `unset` execute on the interface and do not return a result. Such operations can be done in files with don't have any content at all and no matching id, since the given context which templates the file is target by those operations.

## Inject

This way you add data, which will be available for all the following files:

{{< expand "structure/layer_2/_inject.yaml" "..." >}}
```
{{- $_ := set $.Data "inject" (dict "msg" "inject data into shared data store") -}}
```
{{< /expand >}}

### Overwrite

{{< hint "info" >}}Seting data which originates from [condition data](../../configuration/conditions/#condition-data) will only overwrite it for the current file (All YAMLs within that file). For the next file the condition data is newly merged and therefor present again.{{< /hint >}}

Overwrite the key `layer1.overwrite`

{{< expand "structure/layer_2/_overwrite.yaml" "..." >}}
```
{{- $_ := set $.Data.layer_1 "overwrite" "Not Overwritten by Layer2" -}}
```
{{< /expand >}}

The `layer1.overwrite` will not be overwritten in the result.

## Unset

{{< hint "info" >}}Unseting data which originates from [condition data](../../configuration/conditions/#condition-data) will only unset it for the current file (All YAMLs within that file). For the next file the condition data is newly merged and therefor present again.{{< /hint >}}

Unsets the data key `unwated` and `layer1`. 

{{< expand "structure/layer_2/_unset.yaml" "..." >}}
```
{{- $_ := unset $.Data "unwanted" -}}
{{- $_ := unset $.Data "layer1" -}}
```
{{< /expand >}}

The `unwanted` key will no longer be present, the `layer1` will be present, since it's from the layer1 condition.
