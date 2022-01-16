+++
title = "Conditions"
description = "Conditions"
weight = 2
+++

Conditions translate into paths where files are looked up based on given values which are relevant for deployment. Conditions are declared as list, based on the order the files are looked up and merged.

# Configuration

Each condition can have the followin configurations.

## name

_Required_

**Type** `string`

Used across helmize to reference to condition.


## key

_Optional_

**Type** `string`

Path to the value in the user delivered values which is used as key to lookup.


## required

_Optional_

**Type** `boolean`

The declared key must have a value. If no value is given the templating fails.


## default

_Optional_

**Type** `string`

If the declared key does not contain a value, this default value will be used.


## path

_Optional_

**Type** `string`

The path defines under which directory path the given values for the condition are looked up. If no path is given, the  condition's [name](#name) is used as path. Note that the path is complementary to the [inventory_directory](../general/#inventory_directory)


## filter

_Optional_

**Type** `string`/`slice`

Filter keylist for values that are not allowed and exclude them as valid path. The filter is executed against all inputs for this condition. If a filter matches a value, the value is removed. You can use regex patterns. The [allow_root](#allow_root) is not affected by any filter and will always be added.


## reverseFilter

_Optional_

**Type** `boolean`

Reverses the [filter](#filter) configuration so that only values given with the filter are accepted.


## allow_root

_Optional_

**Type** `boolean`

In addition to checking all keys, it becomes also valid to have files directly in the root of the condition's path.