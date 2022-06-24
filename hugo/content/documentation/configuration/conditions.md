+++
title = "Conditions"
description = "Conditions"
weight = 2
+++

Conditions translate into paths where files are looked up based on given values which are relevant for deployment. Conditions are declared as list, based on the order the files are looked up and merged.

# Options

Each condition can have the followin configurations.

---
## name

_Required_

**Type** `string`

Used across helmize to reference to condition.

---
## key

_Optional_

**Type** `string`

Path to the value in the user delivered values which is used as key to lookup. The key is relative the Values (`$.Values`) and therefor must be within the Values. 

---
## key_types

_Optional_

**Type** `slice` **Default** `[ "string", "slice" ]`

Define the types the key must have. For example if you only want to allow a single value, the type should be `string`. Types you can use are documented here:

* [http://masterminds.github.io/sprig/reflection.html](http://masterminds.github.io/sprig/reflection.html)

---
## required

_Optional_

**Type** `boolean`

The declared key must have a value. If no value is given the templating fails.

---
## default

_Optional_

**Type** `string`

If the declared key does not contain a value, this default value will be used. The default value will be set the key if not set, so it's available via the Values.

---
## path

_Optional_

**Type** `string`

The path defines under which directory path the given values for the condition are looked up. If no path is given, the  condition's [name](#name) is used as path. Note that the path is complementary to the [inventory_directory](../general/#inventory_directory)

---
## filter

_Optional_

**Type** `string`/`slice`

Filter keylist for values that are allowed values. The filter is executed against all inputs for this condition. If a value does not match the filter, an error is created for this condition. You can use regex patterns. The [allow_root](#allow_root) is not affected by any filter and will always be added. The [default](#default) value will also be added to the filter, if set. 

---
## reverse_filter

_Optional_

**Type** `boolean`

Reverses the [filter](#filter) configuration so that only values given with the filter are not accepted.

---

## allow_root

_Optional_

**Type** `boolean` **Default** `false`

In addition to checking all keys, it becomes also valid to have files directly in the root of the condition's path. You may disable this option if you only want resources in subfolders of the condition's folder.


---

## file_cfg

_Optional_

**Type** `<SharedFileConfiguration>`

You can define file configurations for the entire condition. The file configurations are applied for all files in the directory of this condition. If 

---
# Condition Data 

It's possible to give specific data with a condition. The data for the condition is then available for all files matching this condition and will be preserved for files which are rendered after this condition applied. 

**Conditions are validated before the file lookup happens. Therefor all resulting data from conditions is available for each file, no matter the order of the files or conditions.**

---

## data

_Optional_

**Type** `map`

Define static data which will be availble for templating.

---
## tpls

{{< hint "info" >}}Using templates might have a decrease in performance as consequence. Calling the sprig `tpl` functions tends to be a bit slow. However it might be a worthy trade-off for certain scenarios{{< /hint >}}


_Optional_

**Type** `list`

With this parameter it's possible to reference template files which are executed. Their output is treated as data and merged with the existing [data key](#data). Note that this is treated as regex, not absolut path. If a template does not result in valid YAML an error will be thrown and the condition is not applied. The templates are executed in order of definition. Data from previous templates as available the following templates, see the templating context ()