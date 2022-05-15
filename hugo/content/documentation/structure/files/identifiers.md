+++
title = "Identifiers"
description = "Identifiers"
weight = 1
+++

{{< hint "warning" >}}
Regardless if you are using the default identifier template or your own. If the template returns an empty ID the file name where the resource originate from is used. Should two resources from the same file use the file's id it's considered an error.
{{< /hint >}}

Identifiers are used to identify a file or a partial file. Based on identifiers files are merged together. [File Configurations](../config) may influence the behavior. The subpath is not relevant in the identifier evaluation.

# Template

Currently if a element has the field `kind` and `metadata.name` it's combined to `{kind}-{metadata.name}.yaml`. If those two data fields are not set, the filename is used. You can define your identifiers per file via the `id` field. See **custom ID**. The current template can be found here:

  * [https://github.com/buttahtoast/helm-charts/blob/master/charts/helmize/templates/render/templates/_identifier.tpl](https://github.com/buttahtoast/helm-charts/blob/master/charts/helmize/templates/render/templates/_identifier.tpl)

[You can change the identifier template](../../customization/identifiers/)

<h1>Outcomes</h1>

Here are different outcomes for identifiers.

---

<h2>Kind and Name</h2>

In this example the `kind` and `metadata.name` are set.

{{< expand "structure/resources/configmap.yaml" "..." >}}
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
```
{{< /expand >}}

Results in the following IDs:

  * `configmap-my-configmap.yaml`

{{< expand "Multi YAML" "..." >}}

Outcome with multiple YAMLs in one file

{{< expand "structure/resources/configmap.yaml" "..." >}}
```
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap2
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

Results in two dedicated elements. First one has ID:

  * `configmap-my-configmap.yaml`

Second one has ID:

  * `configmap-my-configmap2.yaml`
{{< /expand >}}

---

<h2>Without Kind and Name</h2>

In this example the `kind` and `metadata.name` are not set. In this case the filename is used as id.

{{< expand "structure/resources/configmap.yaml" "..." >}}
```yaml
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
```
{{< /expand >}}

Results in the following IDs:

  * `configmap.yaml`

{{< expand "Multi YAML" "..." >}}

{{< hint "info" >}}Make sure to use same kinds when you don't explicit define ids or if they don't resolve via filename. If you have eg. a kind `service` and `deployment` in the same file they will be merged, which is not valid in kubernetes terms{{< /hint >}}

Outcome with multiple YAMLs in one file

{{< expand "structure/resources/configmap.yaml" "..." >}}
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

Both elements have the same ID and merged:

  * `configmap.yaml`

{{< /expand >}}

---

<h2>Custom ID</h2>

In this example we define custom identifiers via the `id` field.

{{< expand "structure/resources/configmap.yaml" "..." >}}
```yaml
helmize:
  id:
    - custom-id-1
    - custom-id-2
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
```
{{< /expand >}}

Results in the following IDs:

  * `custom-id-1`
  * `custom-id-2`

{{< expand "Multi YAML" "..." >}}

Outcome with multiple YAMLs in one file

{{< expand "structure/resources/configmap.yaml" "..." >}}
```
---
helmize:
  id:
  - custom-id-1
  - custom-id-2
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
---
helmize:
  id:
    - custom-id-3
    - custom-id-4
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

Results in two dedicated elements. First one has ID:

  * `custom-id-1`
  * `custom-id-2`

Second one has ID:

  * `custom-id-3`
  * `custom-id-4`
{{< /expand >}}

---

<h2>Custom ID + Kind and Name</h2>

In this example we define custom identifiers via the `id` field. In addition the `kind` and `metadata.name` are set.

{{< expand "structure/resources/configmap.yaml" "..." >}}
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
id:
  - custom-id-1
  - custom-id-2
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
```
{{< /expand >}}

Results in the following IDs:

  * `configmap-my-configmap.yaml`
  * `custom-id-1`
  * `custom-id-2`

{{< expand "Multi YAML" "..." >}}

Outcome with multiple YAMLs in one file

{{< expand "structure/resources/configmap.yaml" "..." >}}
```
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
id:
  - custom-id-1
  - custom-id-2
data:
  game.properties: |
    enemy:
      types:
      - alien
      - monsters
    player:
      maximumLives:5
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
id:
  - custom-id-3
  - custom-id-4
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

Results in two dedicated elements. First one has ID:

  * `configmap-my-configmap.yaml`
  * `custom-id-1`
  * `custom-id-2`

Second one has ID:

  * `configmap-my-configmap.yaml`
  * `custom-id-3`
  * `custom-id-4`
{{< /expand >}}