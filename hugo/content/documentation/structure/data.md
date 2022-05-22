+++
title = "Data"
description = "Data Handling"
weight = 3
+++






# Manipulate Data

{{< hint "warning" >}}With Data manipulation you can potentialy break the entire functionality. Make sure to only manipulate values under $.Data and be aware of what you are doing.{{< /hint >}}

You can manipulate data from files into the shared file store, since the `set` and `unset` execute on the interface and do not return a result. Such operations can be done in files with don't have any content at all and no matching id, since the given context which templates the file is target by those operations.

## Inject

This way you add data, which will be available for all the following files:

{{< expand "structure/layer_2/_inject.yaml" "..." >}}
```
{{- $_ := set $.Data "inject" (dict "msg" "inject data into shared data store") -}}
```
{{< /expand >}}

## Overwrite

## Unset

Unsets entire data key `layer1`. 

{{< expand "structure/layer_2/_unset.yaml" "..." >}}
```
{{- $_ := unset $.Data "layer1" -}}
```
{{< /expand >}}
