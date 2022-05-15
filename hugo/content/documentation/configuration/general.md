+++
title = "Config"
description = "General Configuration"
weight = 1
+++

The following general configuration options are available in the `helmize.yaml`


# conditions

_Required_

**Type** `slice`

[Read more about conditions](../conditions/)


# inventory_directory

_Optional_

**Type** `string` 

Define a directory where the entire structure for helmize is located below. This path will be appended for all the [condition](/documentation/configuration/conditions/)'s paths.


# templates_directory

_Optional_

**Type** `string` 

Define a directory where all templates for the dropins templates are located below. This path will be appended for all the templates in all [dropins](#/configuration/dropins/)

# force

_Optional_

**Type** `string` **Default** `false`

If any file contains an error the template will fail. With force the template won't fail even if there are errors. Files with errors will be skipped.

# file_extensions

_Optional_

**Type** `string`/`slice` **Default** `[ "yaml", "yml", "tpl" ]`

Define which file extensions should be considered while looking through the directories. Just declare the extension without wildcard, this configuration does not accept regex pattern.

# file_excludes

_Optional_

**Type** `string`/`slice`

Define which file names should be considered while looking through the directories. You can use regex patterns.


# merge_strategy

_Optional_

**Type** `string`/`slice` **Default** `path` **Valid Options** `file`, `path`

Define how files are merged together.

{{< expand "Explanation" "..." >}}
## file 

Merge file content based on file name. If you have multiple files with the exact same name in one condition folder or over multiple folders, they are considered to be one final file and merged together.

Let's assume you have the following folder structure:

```
structure
|
+---stage/
|   +---dev/
|          release.yaml
|          subdir/release.yaml
|   ...
|
+---location/
|   +---east/
|          release.yaml
|          subdir/release.yaml
|   ...
+
```

All the files named `release.yaml` will be merged together and as output you will get a single `release.yaml` file.


## path

Merge file content based on file subpath. If you have multiple files with teh exact same name but different subpaths they will not be merged together.

Let's assume you have the following folder structure:

```
structure
|
+---stage/
|   +---dev/
|          release.yaml
|          subdir/release.yaml
|   ...
|
+---location/
|   +---east/
|          release.yaml
|          subdir/release.yaml
|   ...
+
```

The `release.yaml` files are merged together and the `subdir/release.yaml` are merged together. 
{{< /expand >}}

<<<<<<< HEAD
# file_config_key

[Example]()

_Optional_

**Type** `string` **Default** `helmize` 

Key within each's file content which holds the [file configuration](../../structure/files/). This value also allows nested paths (eg. `metadata.config`). After the config is source the entire key is removed from the content.

=======
>>>>>>> 95a66ca193ac23090f93e082b8685f8171fc476f
# identifier_template

_Optional_

<<<<<<< HEAD
**Type** `string` **Default** `inventory.render.templates.identifier` 
=======
**Type** `string` **Default** `"inventory.render.templates.identifier"` 
>>>>>>> 95a66ca193ac23090f93e082b8685f8171fc476f

Define a custom identifier template

[Read more about identifiers](../../customization/identifiers/)


# render_template

_Optional_

<<<<<<< HEAD
**Type** `string` **Default** `inventory.entrypoint.templates.render` 
=======
**Type** `string` **Default** `"inventory.entrypoint.templates.render"` 
>>>>>>> 95a66ca193ac23090f93e082b8685f8171fc476f

Define a custom render template

[Read more about identifiers](../../customization/render/)

