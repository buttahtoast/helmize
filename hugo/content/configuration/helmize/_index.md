+++
title = "Helmize"
description = "Helmize Configuration"
weight = 1
geekdocCollapseSection = "true"
+++
# Options

The following options are available in the `helmize.yaml`. [Read More](../)

---

## conditions

_Required_

**Type** `slice`

[Read more about conditions](../conditions/)

---

## inventory_directory

_Optional_

**Type** `string` **Default** `structure/`

Define a directory where the entire structure for helmize is located below. This path will be prepended for all the [condition](/documentation/configuration/conditions/)'s paths. The directory must be within the chart directry but **not within the templates/ folder**.

---

## file_extensions

_Optional_

**Type** `string`/`slice` **Default** `[ "yaml", "yml", "tpl" ]`

Define which file extensions should be considered while looking through the directories. Just declare the extension without wildcard, this configuration does not accept regex pattern.

---

## file_excludes

_Optional_

**Type** `string`/`slice`

Define which file names should be considered while looking through the directories. You can use regex patterns.

---

## file_config_key

[Example]()

_Optional_

**Type** `string` **Default** `helmize` 

Key within each's file content which holds the [file configuration](../../files/). This value also allows nested paths (eg. `metadata.config`). After the config is source the entire key is removed from the content.

---

## identifier_template

_Optional_

**Type** `string` **Default** `helmize.core.templates.identifier` 

Define a custom identifier template

[Read more about identifiers](../../customization/identifiers/)

---

## render_template

_Optional_

**Type** `string` **Default** `helmize.render.templates.render` 

Define a custom render template

[Read more about rendering](../../customization/render/)

---
## renderers

_Optional_

**Type** `slice` 

Renderers are helm templates which are executed after all the files are merged. The Renderers are executed in given order.

[Read more about Renderers](../../usage/renderers/)

---
## force

_Optional_

**Type** `string` **Default** `false`

If any file contains an error the template will fail. With force the template won't fail even if there are errors. Files with errors will be skipped.
