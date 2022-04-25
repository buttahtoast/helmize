+++
title = "Config"
description = "Configuration"
weight = 1
+++

Each file can be configured with different values to influence to behavior of helmize

# Configuration

Each File can have the following properties.

---
## no_match

_Optional_

**Type** `string` **Default** `"append"` **Valid Options** `append`, `skip`

Define what happens if a file does not match any existing file with it's identifiers:

  * `append` - Append to file as new entry
  * `skip` - Skip the file

This option is interesting for patches.  

---
## expand

_Optional_

**Type** `boolean` **Default** `false`

If a file matches any existing file and this option is set to `true`, the identifiers are merged (expanded).

---
## subpath

_Optional_

**Type** `boolean` **Default** `true`

Match this file based on it's subpath. 

{{< expand "Example" "..." >}}
```
---
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
---
data:
  game.properties: |
    enemy:
      types:
      - imps
      - warriors
    player:
      maximumLives:10
```
{{< /expand >}}

---
## pattern

{{< hint "info" >}}When pattern is active, the file can oly be merged. If there's no match, the file will be skipped, no matter which configuration is set for property `no_match`{{< /hint >}}

_Optional_

**Type** `boolean` **Default** `false`

The identifiers are used as pattern (regex) to match against other ids.

{{< expand "Example" "..." >}}

Matches anything and adds a label to it 

**structure/patches/labels.yaml**

```
id:
  - ".*"
cfg:
  subpath: false
  pattern: true
metadata:
  labels:
    shared: "labels"
```

To catch all files it should be in the last condition directory:

**helmize.yaml**

```
conditions:
  ...
  - name: "patches"
    allow_root: true
```
{{< /expand >}}