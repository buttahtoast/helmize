+++
title = "Files"
description = "File Configuration"
weight = 2
+++

Each file can be configured with different values to influence to behavior of helmize

## Declaration

By default the configuration for each file can be made under a `helmize` key at the root of the yaml manifest. This would look like this:

```yaml
helmize: 
  id:
    - deploy
    - nginx
  subpath: false
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
...
```

You can change the configuration key via [file_config_key](../../configuration/general#file_config_key)

# Per File Configuration

Each File can have the following properties.

---
## id

_Optional_

**Type** `string`/`slice`

Define custom id(s) for this file. [Read more about identifiers](identifiers/)  

---

# Shared Configuration

The following properites can be set within each file but may also be configured conditions. Configurations on file basis are merged over condition file configurations.

---
## no_match

_Optional_

**Type** `string` **Default** `"append"` **Valid Options** `append`, `skip`

Define what happens if a file does not match any existing file with it's identifiers:

  * `append` - Append to file as new entry
  * `skip` - Skip the file

This option is interesting for patches.  

---
## max_match

_Optional_

**Type** `float64` **Default** `0`

Limit the amount of matches this file can have. `0` are unlimited matches.


---
## render

_Optional_

**Type** `boolean` **Default** `true`

Define if a file should be rendered. The file will still show up in the summary but no be rendered when templating normally. When files are merged this option is overwritten as well. Eg. when the base file has `render` set to `false` and a file merges with it, with `render`set to `true`, the result will be `true`

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

---

## fork 

_Optional_

**Type** `boolean` **Default** `false`

Forks are new files based on their matches. If a files matches any file's id it will create a new file. Only one fork can be created, so the first match creates the new file.

### Example 

[See the example chart]


