+++
title = "Dropins"
description = "Dropins"
weight = 3
+++

Dropins are Values and templates which can be sustituted based on given path patterns. They allow greater customization through the use of sprig templates.

# Configuration

Each dropin can have the followin configurations.


## patterns

_Required_

**Type** `string`/`slice`

Define regex patterns which match file paths you want to supply this dropin to.


## data

_Optional_

**Type** `map`

Define data that will be available for the files that matched the pattern. You can not use sprig template here, the type must be map.

## tpls

_Optional_

**Type** `string`/`slice`

Template locations to execute with thise dropin. Templates should be in dedicated files, otherwise  they are very difficult to parse and hard to write for you as well. Therefor each value points to a template which is in a file. Each element can by a file or a path with template files in it. 

**NOTE**: The result of each template must be a valid dict, otherwise it's considered an error.

The path is complementary to the [templates_directory](../general/#templates_directory) path, if set.