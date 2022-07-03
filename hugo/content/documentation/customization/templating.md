+++
title = "Templating"
description = "Templating"
weight = 1
+++


# Library

Helmize comes with our helm library as dependency. The library provides a lot of functions which simplify the maniplution of dicts, slices, etc. You should definitly make use of it's functionalities. See the full documentation of the library chart here:

  * [https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates](https://github.com/buttahtoast/helm-charts/tree/master/charts/library#templates)


# Templates


## Library


## Access Configuration




# Contexts


  * **$.Value**: The Value of the condition which is running (selected the file)
  * **$.Data**: The Shared Data Structure. [Read More](../data).


Here as visualization: 

```
## Content Of the Resources
content:
  apiVersion: v1
  kind: Service
  metadata:
    name: frontend
  spec:
    ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: http
    selector:
      app: frontend
    type: ClusterIP

## Value 
Value: ...

## Data
Data:
  ...

## Global Helm Context
ctx:
  ...
```

## Global Context

The Global Context is the default helm context for a chart enriched with some extra fields for helmize.


```

#
        Config:
          benchmark: false
          conditions:
          - allow_root: true
            name: resources
          debug: false
          file_config_key: metadata.helmize
          file_extensions:
          - .yaml
          - .yml
          - .tpl
          force: true
          global: {}
          helmize: {}
          helmize_file: ""
          identifier_template: helmize.render.templates.identifier
          inventory_directory: structure/
          library:
            global: {}
          post_renderers:
          - customization.postrenderers.sidecar
          - customization.postrenderers.env
          - customization.postrenderers.context
          render_template: helmize.entrypoint.templates.render
          show_config: false
          summary: false
        Data: {}

        Capabilities:
          APIVersions:
          - v1
          - admissionregistration.k8s.io/v1
          - admissionregistration.k8s.io/v1beta1
          - internal.apiserver.k8s.io/v1alpha1
          - apps/v1
          - apps/v1beta1
          - apps/v1beta2
          - authentication.k8s.io/v1
          - authentication.k8s.io/v1beta1
          - authorization.k8s.io/v1
          - authorization.k8s.io/v1beta1
          - autoscaling/v1
          - autoscaling/v2
          - autoscaling/v2beta1
          - autoscaling/v2beta2
          - batch/v1
          - batch/v1beta1
          - certificates.k8s.io/v1
          - certificates.k8s.io/v1beta1
          - coordination.k8s.io/v1beta1
          - coordination.k8s.io/v1
          - discovery.k8s.io/v1
          - discovery.k8s.io/v1beta1
          - events.k8s.io/v1
          - events.k8s.io/v1beta1
          - extensions/v1beta1
          - flowcontrol.apiserver.k8s.io/v1alpha1
          - flowcontrol.apiserver.k8s.io/v1beta1
          - flowcontrol.apiserver.k8s.io/v1beta2
          - networking.k8s.io/v1
          - networking.k8s.io/v1beta1
          - node.k8s.io/v1
          - node.k8s.io/v1alpha1
          - node.k8s.io/v1beta1
          - policy/v1
          - policy/v1beta1
          - rbac.authorization.k8s.io/v1
          - rbac.authorization.k8s.io/v1beta1
          - rbac.authorization.k8s.io/v1alpha1
          - scheduling.k8s.io/v1alpha1
          - scheduling.k8s.io/v1beta1
          - scheduling.k8s.io/v1
          - storage.k8s.io/v1beta1
          - storage.k8s.io/v1
          - storage.k8s.io/v1alpha1
          - apiextensions.k8s.io/v1beta1
          - apiextensions.k8s.io/v1
          HelmVersion:
            git_commit: d14138609b01886f544b2025f5000351c9eb092e
            git_tree_state: clean
            go_version: go1.17.5
            version: v3.8.0
          KubeVersion:
            Major: "1"
            Minor: "23"
            Version: v1.23.0
        Chart:
          IsRoot: true
          apiVersion: v2
          appVersion: 0.1.0
          dependencies:
          - enabled: true
            name: helmize
            repository: file://../../charts/helmize
            version: '>=0.0.0-0'
          description: Helmize Customization Example
          name: example-customization
          type: application
          version: 0.1.0
        Files:
          helmize.yaml: aW52ZW50b3J5X2RpcmVjdG9yeTogInN0cnVjdHVyZS8iCmZpbGVfY29uZmlnX2tleTogIm1ldGFkYXRhLmhlbG1pemUiCmZvcmNlOiBmYWxzZQpjb25kaXRpb25zOgogIC0gbmFtZTogInJlc291cmNlcyIKICAgIGFsbG93X3Jvb3Q6IHRydWUKcG9zdF9yZW5kZXJlcnM6CiAgLSAiY3VzdG9taXphdGlvbi5wb3N0cmVuZGVyZXJzLnNpZGVjYXIiCiAgLSAiY3VzdG9taXphdGlvbi5wb3N0cmVuZGVyZXJzLmVudiIKe3stIGlmICQuVmFsdWVzLmNvbnRleHRSZW5kZXJlciB9fQogIC0gImN1c3RvbWl6YXRpb24ucG9zdHJlbmRlcmVycy5jb250ZXh0Igp7ey0gZW5kIH19
          structure/resources/daemonset.yaml: YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEYWVtb25TZXQKbWV0YWRhdGE6CiAgbmFtZTogb2N0b3B1cy1kZXBsb3ltZW50CiAgbGFiZWxzOgogICAgYXBwOiB3ZWIKc3BlYzoKICBzZWxlY3RvcjoKICAgIG1hdGNoTGFiZWxzOgogICAgICBvY3RvcHVzZXhwb3J0OiBPY3RvcHVzRXhwb3J0CiAgdXBkYXRlU3RyYXRlZ3k6CiAgICB0eXBlOiBSb2xsaW5nVXBkYXRlCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogd2ViCiAgICAgICAgb2N0b3B1c2V4cG9ydDogT2N0b3B1c0V4cG9ydAogICAgc3BlYzoKICAgICAgY29udGFpbmVyczoKICAgICAgICAtIG5hbWU6IG5naW54CiAgICAgICAgICBpbWFnZTogbmdpbngKICAgICAgICAgIHBvcnRzOgogICAgICAgICAgICAtIGNvbnRhaW5lclBvcnQ6IDgwCiAgICAgICAgICBlbnY6CiAgICAgICAgICAgIC0gbmFtZTogREVNT19HUkVFVElORwogICAgICAgICAgICAgIHZhbHVlOiAiSGVsbG8gZnJvbSB0aGUgZW52aXJvbm1lbnQiCiAgICAgICAgICAgIC0gbmFtZTogREVNT19GQVJFV0VMTAogICAgICAgICAgICAgIHZhbHVlOiAiU3VjaCBhIHN3ZWV0IHNvcnJvdyIKICAgICAgICAgICAgLSBuYW1lOiBFWElTVElOR19WQVIKICAgICAgICAgICAgICB2YWx1ZTogIlNvbWUgZXhpc3RpbmcgdmFsdWUiCiAgICAgIGFmZmluaXR5OgogICAgICAgIHBvZEFudGlBZmZpbml0eToKICAgICAgICAgIHByZWZlcnJlZER1cmluZ1NjaGVkdWxpbmdJZ25vcmVkRHVyaW5nRXhlY3V0aW9uOgogICAgICAgICAgICAtIHdlaWdodDogMTAwCiAgICAgICAgICAgICAgcG9kQWZmaW5pdHlUZXJtOgogICAgICAgICAgICAgICAgbGFiZWxTZWxlY3RvcjoKICAgICAgICAgICAgICAgICAgbWF0Y2hFeHByZXNzaW9uczoKICAgICAgICAgICAgICAgICAgICAtIGtleTogYXBwCiAgICAgICAgICAgICAgICAgICAgICBvcGVyYXRvcjogSW4KICAgICAgICAgICAgICAgICAgICAgIHZhbHVlczoKICAgICAgICAgICAgICAgICAgICAgICAgLSB3ZWIKICAgICAgICAgICAgICAgIHRvcG9sb2d5S2V5OiBrdWJlcm5ldGVzLmlvL2hvc3RuYW1l
          structure/resources/deploy.yaml: YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBEZXBsb3ltZW50Cm1ldGFkYXRhOgogIG5hbWU6IG9jdG9wdXMtZGVwbG95bWVudAogIGxhYmVsczoKICAgIGFwcDogd2ViCnNwZWM6CiAgc2VsZWN0b3I6CiAgICBtYXRjaExhYmVsczoKICAgICAgb2N0b3B1c2V4cG9ydDogT2N0b3B1c0V4cG9ydAogIHJlcGxpY2FzOiAxCiAgc3RyYXRlZ3k6CiAgICB0eXBlOiBSb2xsaW5nVXBkYXRlCiAgdGVtcGxhdGU6CiAgICBtZXRhZGF0YToKICAgICAgbGFiZWxzOgogICAgICAgIGFwcDogd2ViCiAgICAgICAgb2N0b3B1c2V4cG9ydDogT2N0b3B1c0V4cG9ydAogICAgc3BlYzoKICAgICAgY29udGFpbmVyczoKICAgICAgICAtIG5hbWU6IG5naW54CiAgICAgICAgICBpbWFnZTogbmdpbngKICAgICAgICAgIHBvcnRzOgogICAgICAgICAgICAtIGNvbnRhaW5lclBvcnQ6IDgwCiAgICAgICAgICBlbnY6CiAgICAgICAgICAgIC0gbmFtZTogREVNT19HUkVFVElORwogICAgICAgICAgICAgIHZhbHVlOiAiSGVsbG8gZnJvbSB0aGUgZW52aXJvbm1lbnQiCiAgICAgICAgICAgIC0gbmFtZTogREVNT19GQVJFV0VMTAogICAgICAgICAgICAgIHZhbHVlOiAiU3VjaCBhIHN3ZWV0IHNvcnJvdyIKICAgICAgICAgICAgLSBuYW1lOiBFWElTVElOR19WQVIKICAgICAgICAgICAgICB2YWx1ZTogIlNvbWUgZXhpc3RpbmcgdmFsdWUiCiAgICAgIGFmZmluaXR5OgogICAgICAgIHBvZEFudGlBZmZpbml0eToKICAgICAgICAgIHByZWZlcnJlZER1cmluZ1NjaGVkdWxpbmdJZ25vcmVkRHVyaW5nRXhlY3V0aW9uOgogICAgICAgICAgICAtIHdlaWdodDogMTAwCiAgICAgICAgICAgICAgcG9kQWZmaW5pdHlUZXJtOgogICAgICAgICAgICAgICAgbGFiZWxTZWxlY3RvcjoKICAgICAgICAgICAgICAgICAgbWF0Y2hFeHByZXNzaW9uczoKICAgICAgICAgICAgICAgICAgICAtIGtleTogYXBwCiAgICAgICAgICAgICAgICAgICAgICBvcGVyYXRvcjogSW4KICAgICAgICAgICAgICAgICAgICAgIHZhbHVlczoKICAgICAgICAgICAgICAgICAgICAgICAgLSB3ZWIKICAgICAgICAgICAgICAgIHRvcG9sb2d5S2V5OiBrdWJlcm5ldGVzLmlvL2hvc3RuYW1l
          structure/resources/no-kind.yaml: YXBpVmVyc2lvbjogdjEKbWV0YWRhdGE6CiAgbmFtZTogb2N0b3B1cy1kZXBsb3ltZW50CiAgbGFiZWxzOgogICAgYXBwOiB3ZWIKc3BlYzoKICBjb250YWluZXJzOgogICAgLSBuYW1lOiBuZ2lueAogICAgICBpbWFnZTogbmdpbngKICAgICAgcG9ydHM6CiAgICAgICAgLSBjb250YWluZXJQb3J0OiA4MAogICAgICBlbnY6CiAgICAgICAgLSBuYW1lOiBERU1PX0dSRUVUSU5HCiAgICAgICAgICB2YWx1ZTogIkhlbGxvIGZyb20gdGhlIGVudmlyb25tZW50IgogICAgICAgIC0gbmFtZTogREVNT19GQVJFV0VMTAogICAgICAgICAgdmFsdWU6ICJTdWNoIGEgc3dlZXQgc29ycm93IgogICAgICAgIC0gbmFtZTogRVhJU1RJTkdfVkFSCiAgICAgICAgICB2YWx1ZTogIlNvbWUgZXhpc3RpbmcgdmFsdWUiCiAgYWZmaW5pdHk6CiAgICBwb2RBbnRpQWZmaW5pdHk6CiAgICAgIHByZWZlcnJlZER1cmluZ1NjaGVkdWxpbmdJZ25vcmVkRHVyaW5nRXhlY3V0aW9uOgogICAgICAgIC0gd2VpZ2h0OiAxMDAKICAgICAgICAgIHBvZEFmZmluaXR5VGVybToKICAgICAgICAgICAgbGFiZWxTZWxlY3RvcjoKICAgICAgICAgICAgICBtYXRjaEV4cHJlc3Npb25zOgogICAgICAgICAgICAgICAgLSBrZXk6IGFwcAogICAgICAgICAgICAgICAgICBvcGVyYXRvcjogSW4KICAgICAgICAgICAgICAgICAgdmFsdWVzOgogICAgICAgICAgICAgICAgICAgIC0gd2ViCiAgICAgICAgICAgIHRvcG9sb2d5S2V5OiBrdWJlcm5ldGVzLmlvL2hvc3RuYW1l
          structure/resources/pod.yaml: YXBpVmVyc2lvbjogdjEKa2luZDogUG9kCm1ldGFkYXRhOgogIG5hbWU6IG9jdG9wdXMtZGVwbG95bWVudAogIGxhYmVsczoKICAgIGFwcDogd2ViCnNwZWM6CiAgY29udGFpbmVyczoKICAgIC0gbmFtZTogbmdpbngKICAgICAgaW1hZ2U6IG5naW54CiAgICAgIHBvcnRzOgogICAgICAgIC0gY29udGFpbmVyUG9ydDogODAKICAgICAgZW52OgogICAgICAgIC0gbmFtZTogREVNT19HUkVFVElORwogICAgICAgICAgdmFsdWU6ICJIZWxsbyBmcm9tIHRoZSBlbnZpcm9ubWVudCIKICAgICAgICAtIG5hbWU6IERFTU9fRkFSRVdFTEwKICAgICAgICAgIHZhbHVlOiAiU3VjaCBhIHN3ZWV0IHNvcnJvdyIKICAgICAgICAtIG5hbWU6IEVYSVNUSU5HX1ZBUgogICAgICAgICAgdmFsdWU6ICJTb21lIGV4aXN0aW5nIHZhbHVlIgogIGFmZmluaXR5OgogICAgcG9kQW50aUFmZmluaXR5OgogICAgICBwcmVmZXJyZWREdXJpbmdTY2hlZHVsaW5nSWdub3JlZER1cmluZ0V4ZWN1dGlvbjoKICAgICAgICAtIHdlaWdodDogMTAwCiAgICAgICAgICBwb2RBZmZpbml0eVRlcm06CiAgICAgICAgICAgIGxhYmVsU2VsZWN0b3I6CiAgICAgICAgICAgICAgbWF0Y2hFeHByZXNzaW9uczoKICAgICAgICAgICAgICAgIC0ga2V5OiBhcHAKICAgICAgICAgICAgICAgICAgb3BlcmF0b3I6IEluCiAgICAgICAgICAgICAgICAgIHZhbHVlczoKICAgICAgICAgICAgICAgICAgICAtIHdlYgogICAgICAgICAgICB0b3BvbG9neUtleToga3ViZXJuZXRlcy5pby9ob3N0bmFtZQ==
          structure/resources/statefulset.yaml: YXBpVmVyc2lvbjogYXBwcy92MQpraW5kOiBTdGF0ZWZ1bFNldAptZXRhZGF0YToKICBuYW1lOiBvY3RvcHVzLWRlcGxveW1lbnQKICBsYWJlbHM6CiAgICBhcHA6IHdlYgogICAgaW5qZWN0X3BvcnQ6ICJ0cnVlIgpzcGVjOgogIHNlbGVjdG9yOgogICAgbWF0Y2hMYWJlbHM6CiAgICAgIG9jdG9wdXNleHBvcnQ6IE9jdG9wdXNFeHBvcnQKICByZXBsaWNhczogMQogIHVwZGF0ZVN0cmF0ZWd5OgogICAgdHlwZTogUm9sbGluZ1VwZGF0ZQogIHBvZE1hbmFnZW1lbnRQb2xpY3k6IE9yZGVyZWRSZWFkeQogIHRlbXBsYXRlOgogICAgbWV0YWRhdGE6CiAgICAgIGxhYmVsczoKICAgICAgICBhcHA6IHdlYgogICAgICAgIG9jdG9wdXNleHBvcnQ6IE9jdG9wdXNFeHBvcnQKICAgIHNwZWM6CiAgICAgIGNvbnRhaW5lcnM6CiAgICAgICAgLSBuYW1lOiBuZ2lueAogICAgICAgICAgaW1hZ2U6IG5naW54CiAgICAgICAgICBwb3J0czoKICAgICAgICAgICAgLSBjb250YWluZXJQb3J0OiA4MAogICAgICAgICAgZW52OgogICAgICAgICAgICAtIG5hbWU6IERFTU9fR1JFRVRJTkcKICAgICAgICAgICAgICB2YWx1ZTogIkhlbGxvIGZyb20gdGhlIGVudmlyb25tZW50IgogICAgICAgICAgICAtIG5hbWU6IERFTU9fRkFSRVdFTEwKICAgICAgICAgICAgICB2YWx1ZTogIlN1Y2ggYSBzd2VldCBzb3Jyb3ciCiAgICAgICAgICAgIC0gbmFtZTogRVhJU1RJTkdfVkFSCiAgICAgICAgICAgICAgdmFsdWU6ICJTb21lIGV4aXN0aW5nIHZhbHVlIgogICAgICBhZmZpbml0eToKICAgICAgICBwb2RBbnRpQWZmaW5pdHk6CiAgICAgICAgICBwcmVmZXJyZWREdXJpbmdTY2hlZHVsaW5nSWdub3JlZER1cmluZ0V4ZWN1dGlvbjoKICAgICAgICAgICAgLSB3ZWlnaHQ6IDEwMAogICAgICAgICAgICAgIHBvZEFmZmluaXR5VGVybToKICAgICAgICAgICAgICAgIGxhYmVsU2VsZWN0b3I6CiAgICAgICAgICAgICAgICAgIG1hdGNoRXhwcmVzc2lvbnM6CiAgICAgICAgICAgICAgICAgICAgLSBrZXk6IGFwcAogICAgICAgICAgICAgICAgICAgICAgb3BlcmF0b3I6IEluCiAgICAgICAgICAgICAgICAgICAgICB2YWx1ZXM6CiAgICAgICAgICAgICAgICAgICAgICAgIC0gd2ViCiAgICAgICAgICAgICAgICB0b3BvbG9neUtleToga3ViZXJuZXRlcy5pby9ob3N0bmFtZQ==
        Release:
          IsInstall: true
          IsUpgrade: false
          Name: release-name
          Namespace: default
          Revision: 1
          Service: Helm
        Subcharts:
          helmize:
            Capabilities:
              APIVersions:
              - v1
              - admissionregistration.k8s.io/v1
              - admissionregistration.k8s.io/v1beta1
              - internal.apiserver.k8s.io/v1alpha1
              - apps/v1
              - apps/v1beta1
              - apps/v1beta2
              - authentication.k8s.io/v1
              - authentication.k8s.io/v1beta1
              - authorization.k8s.io/v1
              - authorization.k8s.io/v1beta1
              - autoscaling/v1
              - autoscaling/v2
              - autoscaling/v2beta1
              - autoscaling/v2beta2
              - batch/v1
              - batch/v1beta1
              - certificates.k8s.io/v1
              - certificates.k8s.io/v1beta1
              - coordination.k8s.io/v1beta1
              - coordination.k8s.io/v1
              - discovery.k8s.io/v1
              - discovery.k8s.io/v1beta1
              - events.k8s.io/v1
              - events.k8s.io/v1beta1
              - extensions/v1beta1
              - flowcontrol.apiserver.k8s.io/v1alpha1
              - flowcontrol.apiserver.k8s.io/v1beta1
              - flowcontrol.apiserver.k8s.io/v1beta2
              - networking.k8s.io/v1
              - networking.k8s.io/v1beta1
              - node.k8s.io/v1
              - node.k8s.io/v1alpha1
              - node.k8s.io/v1beta1
              - policy/v1
              - policy/v1beta1
              - rbac.authorization.k8s.io/v1
              - rbac.authorization.k8s.io/v1beta1
              - rbac.authorization.k8s.io/v1alpha1
              - scheduling.k8s.io/v1alpha1
              - scheduling.k8s.io/v1beta1
              - scheduling.k8s.io/v1
              - storage.k8s.io/v1beta1
              - storage.k8s.io/v1
              - storage.k8s.io/v1alpha1
              - apiextensions.k8s.io/v1beta1
              - apiextensions.k8s.io/v1
              HelmVersion:
                git_commit: d14138609b01886f544b2025f5000351c9eb092e
                git_tree_state: clean
                go_version: go1.17.5
                version: v3.8.0
              KubeVersion:
                Major: "1"
                Minor: "23"
                Version: v1.23.0
            Chart:
              IsRoot: false
              annotations:
                artifacthub.io/prerelease: "true"
              apiVersion: v2
              appVersion: 0.1.0
              dependencies:
              - enabled: true
                name: library
                repository: file://../../../helm-charts-1/charts/library
                version: 2.6.1
              description: Go Sprig based deployment engine (GitOps Tool)
              home: https://helmize.dev
              icon: https://raw.githubusercontent.com/buttahtoast/helmize/main/hugo/icon/icon.png
              keywords:
              - library
              - sprig
              - deploy
              maintainers:
              - email: oliverbaehler@hotmail.com
                name: oliverbaehler
              name: helmize
              type: library
              version: 0.1.0-rc.6
            Files:
              .helmignore: IyBQYXR0ZXJucyB0byBpZ25vcmUgd2hlbiBidWlsZGluZyBwYWNrYWdlcy4KIyBUaGlzIHN1cHBvcnRzIHNoZWxsIGdsb2IgbWF0Y2hpbmcsIHJlbGF0aXZlIHBhdGggbWF0Y2hpbmcsIGFuZAojIG5lZ2F0aW9uIChwcmVmaXhlZCB3aXRoICEpLiBPbmx5IG9uZSBwYXR0ZXJuIHBlciBsaW5lLgouRFNfU3RvcmUKIyBDb21tb24gVkNTIGRpcnMKLmdpdC8KLmdpdGlnbm9yZQouYnpyLwouYnpyaWdub3JlCi5oZy8KLmhnaWdub3JlCi5zdm4vCiMgQ29tbW9uIGJhY2t1cCBmaWxlcwoqLnN3cAoqLmJhawoqLnRtcAoqLm9yaWcKKn4KIyBWYXJpb3VzIElERXMKLnByb2plY3QKLmlkZWEvCioudG1wcm9qCi52c2NvZGUvCgojIERlZmF1bHQgQ2hhcnQgUmVwb3NpdG9yeSBFeGVjbHVkZXMKLmNoYXJ0LWNvbmZpZwoua3ViZS1saW50ZXIueWFtbApSRUFETUUubWQuZ290bXBsCgojIEN1c3RvbQpiaW4v
              README.md: IyBIZWxtaXplCgohW1ZlcnNpb246IDAuMS4wLXJjLjVdKGh0dHBzOi8vaW1nLnNoaWVsZHMuaW8vYmFkZ2UvVmVyc2lvbi0wLjEuMC0tcmMuNS1pbmZvcm1hdGlvbmFsP3N0eWxlPWZsYXQtc3F1YXJlKSAhW1R5cGU6IGxpYnJhcnldKGh0dHBzOi8vaW1nLnNoaWVsZHMuaW8vYmFkZ2UvVHlwZS1saWJyYXJ5LWluZm9ybWF0aW9uYWw/c3R5bGU9ZmxhdC1zcXVhcmUpICFbQXBwVmVyc2lvbjogMC4xLjBdKGh0dHBzOi8vaW1nLnNoaWVsZHMuaW8vYmFkZ2UvQXBwVmVyc2lvbi0wLjEuMC1pbmZvcm1hdGlvbmFsP3N0eWxlPWZsYXQtc3F1YXJlKQoKSGVsbWl6ZSBpcyBhIHNpbXBsZSBkZXBsb3ltZW50IGxpYnJhcnkgd3JhcHBlZCBpbiBhIGxpYnJhcnkgaGVsbSBjaGFydC4gSXQncyBwdXJwb3NlIGlzIHRvIHNpbXBsaWZ5IGNvbXBsZXggaW5mcmFzdHJ1Y3R1cmUgZGVwbG95bWVudHMgd2hlcmUgeW91IGNoYW5nZSBkZXBsb3llZCBtYW5pZmVzdHMgYmFzZWQgb24gZ2l2ZW4gY29uZGl0aW9ucy4gVGhpcyBwcm9qZWN0IGlzIHRob3VnaHQgZm9yIHBlb3BsZSB0aGF0IGJvb3RzdHJhcCBjb21wbGV4IGluZnJhc3RydWN0dXJlIHNldHVwIG9uIGt1YmVybmV0ZXMgYW5kIHdhbnQgdG8gc2ltcGxpZnkgdGhlaXIgZmlsZSBzdHJ1Y3R1cmUuCgoqKk5PVEUqKjogVGhpcyBwcm9qZWN0IGlzIGluIGl0J3MgZWFybHkgc3RhZ2VzIG9mIGRldmVsb3BtZW50LiBUaGUgY29kZSBtaWdodCBiZSBzdWJqZWN0IHRvIGNoYW5nZS4gSG93ZXZlciB3ZSBhcmUgdHJ5aW5nIG5vdCB0byBjaGFuZ2UgdGhlIGVudGlyZSBzdHJ1Y3R1cmUgb3IgY29uZmlnLiBGZWVsIGZyZWUgdG8gdGVzdCBpdCBvdXQsIHdlIG5lZWQgdXNlciBmZWVkYmFjay4gOikgVXNpbmcgaXQgaW4gcHJvZHVjdGlvbiBpcyB5b3VyIGNob2ljZSBhbmQgeW91ciByZXNwb25zYWJpbGl0eS4KClJlYWQgdGhlIGVudGlyZSBkb2N1bWVudGF0aW9uIG9uIHRoZSBob21lcGFnZS4KCioqSG9tZXBhZ2U6KiogPGh0dHBzOi8vaGVsbWl6ZS5kZXY+CgojIyBNYWludGFpbmVycwoKfCBOYW1lIHwgRW1haWwgfCBVcmwgfAp8IC0tLS0gfCAtLS0tLS0gfCAtLS0gfAp8IG9saXZlcmJhZWhsZXIgfCA8b2xpdmVyYmFlaGxlckBob3RtYWlsLmNvbT4gfCAgfA==
            Release:
              IsInstall: true
              IsUpgrade: false
              Name: release-name
              Namespace: default
              Revision: 1
              Service: Helm

            # Dependency Chart Contexts
            Subcharts:
              library:
                ...   
              
                Capabilities:
                  APIVersions:
                  - v1
                  - admissionregistration.k8s.io/v1
                  - admissionregistration.k8s.io/v1beta1
                  - internal.apiserver.k8s.io/v1alpha1
                  - apps/v1
                  - apps/v1beta1
                  - apps/v1beta2
                  - authentication.k8s.io/v1
                  - authentication.k8s.io/v1beta1
                  - authorization.k8s.io/v1
                  - authorization.k8s.io/v1beta1
                  - autoscaling/v1
                  - autoscaling/v2
                  - autoscaling/v2beta1
                  - autoscaling/v2beta2
                  - batch/v1
                  - batch/v1beta1
                  - certificates.k8s.io/v1
                  - certificates.k8s.io/v1beta1
                  - coordination.k8s.io/v1beta1
                  - coordination.k8s.io/v1
                  - discovery.k8s.io/v1
                  - discovery.k8s.io/v1beta1
                  - events.k8s.io/v1
                  - events.k8s.io/v1beta1
                  - extensions/v1beta1
                  - flowcontrol.apiserver.k8s.io/v1alpha1
                  - flowcontrol.apiserver.k8s.io/v1beta1
                  - flowcontrol.apiserver.k8s.io/v1beta2
                  - networking.k8s.io/v1
                  - networking.k8s.io/v1beta1
                  - node.k8s.io/v1
                  - node.k8s.io/v1alpha1
                  - node.k8s.io/v1beta1
                  - policy/v1
                  - policy/v1beta1
                  - rbac.authorization.k8s.io/v1
                  - rbac.authorization.k8s.io/v1beta1
                  - rbac.authorization.k8s.io/v1alpha1
                  - scheduling.k8s.io/v1alpha1
                  - scheduling.k8s.io/v1beta1
                  - scheduling.k8s.io/v1
                  - storage.k8s.io/v1beta1
                  - storage.k8s.io/v1
                  - storage.k8s.io/v1alpha1
                  - apiextensions.k8s.io/v1beta1
                  - apiextensions.k8s.io/v1
                  HelmVersion:
                    git_commit: d14138609b01886f544b2025f5000351c9eb092e
                    git_tree_state: clean
                    go_version: go1.17.5
                    version: v3.8.0
                  KubeVersion:
                    Major: "1"
                    Minor: "23"
                    Version: v1.23.0
                Chart:
                  IsRoot: false
                  annotations:
                    artifacthub.io/changes: |
                      - "[Added]: Unit Tests"
                      - "[Added]: Merge function"
                    artifacthub.io/containsSecurityUpdates: "false"
                    artifacthub.io/prerelease: "false"
                  apiVersion: v2
                  appVersion: 0.1.0
                  description: Buttahtoast Helm Library
                  home: https://github.com/buttahtoast/helm-charts/tree/master/charts/library
                  icon: https://avatars0.githubusercontent.com/u/67652090?s=400&u=874d1c989b0afc2789865be01051f0bbfc84ae32&v=4
                  keywords:
                  - library
                  - sprig
                  maintainers:
                  - email: oliverbaehler@hotmail.com
                    name: oliverbaehler
                  - email: kk@sudo-i.net
                    name: chifu1234
                  name: library
                  sources:
                  - https://github.com/buttahtoast/helm-charts/tree/master/charts/library
                  type: library
                  version: 2.6.1
                Files:
                  .helmignore: IyBQYXR0ZXJucyB0byBpZ25vcmUgd2hlbiBidWlsZGluZyBwYWNrYWdlcy4KIyBUaGlzIHN1cHBvcnRzIHNoZWxsIGdsb2IgbWF0Y2hpbmcsIHJlbGF0aXZlIHBhdGggbWF0Y2hpbmcsIGFuZAojIG5lZ2F0aW9uIChwcmVmaXhlZCB3aXRoICEpLiBPbmx5IG9uZSBwYXR0ZXJuIHBlciBsaW5lLgouRFNfU3RvcmUKIyBDb21tb24gVkNTIGRpcnMKLmdpdC8KLmdpdGlnbm9yZQouYnpyLwouYnpyaWdub3JlCi5oZy8KLmhnaWdub3JlCi5zdm4vCiMgQ29tbW9uIGJhY2t1cCBmaWxlcwoqLnN3cAoqLmJhawoqLnRtcAoqLm9yaWcKKn4KIyBWYXJpb3VzIElERXMKLnByb2plY3QKLmlkZWEvCioudG1wcm9qCi52c2NvZGUvCgojIERlZmF1bHQgQ2hhcnQgUmVwb3NpdG9yeSBFeGVjbHVkZXMKLmNoYXJ0LWNvbmZpZwoua3ViZS1saW50ZXIueWFtbApSRUFETUUubWQuZ290bXBsCg==
                  README.md: IyBCdXR0YWh0b2FzdCBMaWJyYXJ5CgohW1ZlcnNpb246IDIuNC4xXShodHRwczovL2ltZy5zaGllbGRzLmlvL2JhZGdlL1ZlcnNpb24tMi40LjEtaW5mb3JtYXRpb25hbD9zdHlsZT1mbGF0LXNxdWFyZSkgIVtUeXBlOiBsaWJyYXJ5XShodHRwczovL2ltZy5zaGllbGRzLmlvL2JhZGdlL1R5cGUtbGlicmFyeS1pbmZvcm1hdGlvbmFsP3N0eWxlPWZsYXQtc3F1YXJlKSAhW0FwcFZlcnNpb246IDAuMS4wXShodHRwczovL2ltZy5zaGllbGRzLmlvL2JhZGdlL0FwcFZlcnNpb24tMC4xLjAtaW5mb3JtYXRpb25hbD9zdHlsZT1mbGF0LXNxdWFyZSkKClRoaXMgaXMgb3VyIHRha2Ugb24gYSBsaWJyYXJ5IENoYXJ0LiBJdCBjb250YWlucyBzaW1wbGUgZnVuY3Rpb25zIHdoaWNoIGFyZSAod2lsbCBiZSkgdXNlZCBhY3Jvc3MgYWxsIG9mIG91ciBjaGFydHMuIEZlZWwgZnJlZSB0aGUgYWRkIG9yIGltcHJvdmUgdGhlIGV4aXN0aW5nIHRlbXBsYXRlcy4gVGhpcyBDaGFydCBpcyBzdGlsbCB1bmRlciBkZXZlbG9wbWVudC90ZXN0aW5nLiBGZWVsIGZyZWUgdG8gdXNlIGl0LCBpZiB5b3UgZmluZCBhbnkgaXNzdWVzIHdpdGggaXQsIHBsZWFzZSBjcmVhdGUgYW4gaXNzdWUvUFIuIFdlIHdpbGwgdHJ5IHRvIGdldCBidWdzIGZpeGVkIGFzIHNvb24gYXMgcG9zc2libGUhCgoqKkhvbWVwYWdlOioqIDxodHRwczovL2dpdGh1Yi5jb20vYnV0dGFodG9hc3QvaGVsbS1jaGFydHMvdHJlZS9tYXN0ZXIvY2hhcnRzL2xpYnJhcnk+CgojIyBNYWludGFpbmVycwoKfCBOYW1lIHwgRW1haWwgfCBVcmwgfAp8IC0tLS0gfCAtLS0tLS0gfCAtLS0gfAp8IG9saXZlcmJhZWhsZXIgfCA8b2xpdmVyYmFlaGxlckBob3RtYWlsLmNvbT4gfCAgfAp8IGNoaWZ1MTIzNCB8IDxra0BzdWRvLWkubmV0PiB8ICB8CgojIEluc3RhbGwgQ2hhcnQKClNpbmNlIHRoaXMgY2hhcnQgaXMgb2YgdHlwZSBbbGlicmFyeV0oaHR0cHM6Ly9oZWxtLnNoL2RvY3MvdG9waWNzL2xpYnJhcnlfY2hhcnRzLykgaXQgY2FuIG9ubHkgYmUgdXNlZCBhcyBkZXBlbmRlbmN5IGZvciBvdGhlciBjaGFydHMuIEp1c3QgYWRkIGl0IGluIHlvdXIgY2hhcnQgZGVwZW5kZW5jaWVzIHNlY3Rpb246CgpgYGAKZGVwZW5kZW5jaWVzOgogIC0gbmFtZTogbGlicmFyeQogICAgdmVyc2lvbjogMS4wLjAKICAgIHJlcG9zaXRvcnk6IGh0dHBzOi8vYnV0dGFodG9hc3QuZ2l0aHViLmlvL2hlbG0tY2hhcnRzLwpgYGAKCklmIHRoZSBjaGFydCBpcyB3aXRoaW4gdGhpcyBHaXRodWIgaGVsbSByZXBvc2l0b3J5LCB5b3UgY2FuIHJlZmVyZW5jZSBpdCBhcyBsb2NhbCBkZXBlbmRlbmN5CgpgYGAKZGVwZW5kZW5jaWVzOgotIG5hbWU6IGxpYnJhcnkKICB2ZXJzaW9uOiAiPj0xLjAuMCIKICByZXBvc2l0b3J5OiAiZmlsZTovLy4uL2xpYnJhcnkiCmBgYAoKIyBNYWpvciBDaGFuZ2VzCgpNYWpvciBDaGFuZ2VzIHRvIGZ1bmN0aW9ucyBhcmUgZG9jdW1lbnRlZCB3aXRoIHRoZSB2ZXJzaW9uIGFmZmVjdGVkLiAqKkJlZm9yZSB1cGdyYWRpbmcgdGhlIGRlcGVuZGVuY3kgdmVyc2lvbiwgY2hlY2sgdGhpcyBzZWN0aW9uIG91dCEqKgoKfCAqKlRlbXBsYXRlKiogfCAqKkNoYXJ0IFZlcnNpb24qKiB8ICoqQ2hhbmdlL0Rlc2NyaXB0aW9uKiogfCAqKkNvbW1pdHMvUFJzKiogfAp8IDotLS0tLS0tLS0tLSB8IDotLS0tLS0tLS0tLS0tLS0tIHwgOi0tLS0tLS0tLS0tLS0tLS0tLS0tLSB8IDotLS0tLS0tLS0tLS0tLSB8CnwgYCQuVmFsdWVzLmt1YmVjYXBhYmlsaXRpZXNgIHwgYDEuMC4wYCB8IGAkLlZhbHVlcy5rdWJlY2FwYWJpbGl0aWVzYCBtb3ZlZCB0byBgJC5WYWx1ZXMuZ2xvYmFsLmt1YmVjYXBhYmlsaXRpZXNgLiBXaXRob3V0IG1hcHBpbmcgdGhlc2UgdmFsdWVzIHRoZSBrdWJlQ2FwYWJpbGl0aWVzIG5vIGxvbmdlciB3b3Jrcy4gfCBbUHVsbCBSZXF1ZXN0XShodHRwczovL2dpdGh1Yi5jb20vYnV0dGFodG9hc3QvaGVsbS1jaGFydHMvcHVsbC8yMikgfAp8IEFsbCAqKnN0cmluZyoqLCAqKmxpc3QqKiwgKipnbG9iYWxzKiogYW5kICoqZGljdCoqIHRlbXBsYXRlcyB8IGAwLjMuMGAgfCBBZGRlZCBmb3IgZWFjaCB0ZW1wbGF0ZSBjYXRlZ29yeSB0aGUgY2F0ZWdvcnkgYXMgdGVtcGxhdGUgbmFtZSBwYXRoLiAoZWcuIGFsbCBzdHJpbmcgdGVtcGxhdGVzID0gYGxpYi51dGlscy5zdHJpbmdzLipgKS58IFtQdWxsIFJlcXVlc3RdKGh0dHBzOi8vZ2l0aHViLmNvbS9idXR0YWh0b2FzdC9oZWxtLWNoYXJ0cy9wdWxsLzE1KSB8CgojIFRlbXBsYXRlcwoKVGhlIGF2YWlsYWJsZSB0ZW1wbGF0ZSBmdW5jdGlvbnMgYXJlIGdyb3VwZWQgYnkgRGF0YSBUeXBlIG9yIFVzYWdlLiBFYWNoIGRlc2NyaWJpbmcgaG93IHRoZSB0ZW1wbGF0ZSBpcyBjYWxsZWQsIHdoYXQKaXQgc2hvdWxkIGRvIGFuZCB3aGF0IGl0IHNob3VsZCByZXR1cm4uICoqTk9USUNFKiogV2UgaGFkIHRvIHVzZSBzaW5nbGUgYHtgIGluIHRoZSBleGFtcGxlcywgYmVjYXVzZSBoZWxtLWRvY3MgdHJpZXMgdG8KcGFyc2UgdGhlIGZpbGUgYW5kIHRoYXQgY2F1c2VzIHNvbWUgaXNzdWVzLiBTbyBkb24ndCBmb3JnZXQgdG8gYWRkIGEgcGFpciBvZiBge31gLgoKKipUZW1wbGF0ZSBJbmRleCoqCgoqICoqW0NvbW1vbl0oI2NvbW1vbikqKgogICogW0Z1bGxuYW1lXSgjZnVsbG5hbWUpCiAgKiBbQ2hhcnRdKCNjaGFydCkKICAqIFtTZWxlY3RvckxhYmVsc10oI3NlbGVjdG9ybGFiZWxzKQogICogW0RlZmF1bHRMYWJlbHNdKCNkZWZhdWx0bGFiZWxzKQogICogW0NvbW1vbkxhYmVsc10oI2NvbW1vbmxhYmVscykKICAqIFtMYWJlbHNdKCNsYWJlbHMpCiAgKiBbS3ViZUNhcGFiaWxpdGllc10oI2t1YmVjYXBhYmlsaXRpZXMpCiogKipbR2xvYmFsc10oI2dsb2JhbHMpKioKICAqIFtEb2NrZXJJbWFnZV0oI2RvY2tlcmltYWdlKQogICogW0ltYWdlUHVsbFBvbGljeV0oI2ltYWdlcHVsbHBvbGljeSkKICAqIFtJbWFnZVB1bGxzZWNyZXRzXSgjaW1hZ2VwdWxsc2VjcmV0cykKICAqIFtTdG9yYWdlQ2xhc3NdKCNzdG9yYWdlY2xhc3MpCiogKipbU3RyaW5nc10oI3N0cmluZ3MpKioKICAqIFtUZW1wbGF0ZV0oI3RlbXBsYXRlKQogICogW1N0cmluZ2lmeV0oI3N0cmluZ2lmeSkKICAqIFtUb0RuczExMjNdKCN0b2RuczExMjMpCiogKipbTGlzdHNdKCNsaXN0cykqKgogICogW0hhc1ZhbHVlQnlLZXldKCNoYXN2YWx1ZWJ5a2V5KQogICogW0dldFZhbHVlQnlLZXldKCNnZXR2YWx1ZWJ5a2V5KQogICogW01lcmdlTGlzdF0oI21lcmdlbGlzdCkKICAqIFtNZXJnZUxpc3RPbktleV0oI21lcmdlbGlzdG9ua2V5KQogICogW0V4Y2VwdGlvbkxpc3RdKCNleGNlcHRpb25saXN0KQoqICoqW0RpY3Rpb25hcmllc10oI2RpY3Rpb25hcmllcykqKgogICogW1BhcmVudEFwcGVuZF0oI3BhcmVudEFwcGVuZCkKICAqIFtQcmludFlhbWxTdHJ1Y3R1cmVdKCNwcmludHlhbWxzdHJ1Y3R1cmUpCiAgKiBbTG9va3VwXSgjbG9va3VwKQogICogW1Vuc2V0XSgjdW5zZXQpCiAgKiBbU2V0XSgjc2V0KQoqICoqW0V4dHJhc10oI2V4dHJhcykqKgogICogW0Vudmlyb25tZW50XSgjZW52aXJvbm1lbnQpCiAgKiBbRXh0cmFSZXNvdXJjZXNdKCNleHRyYXJlc291cmNlcykKKiAqKltFcnJvcnNdKCNlcnJvcnMpKioKICAqIFtmYWlsXSgjZmFpbCkKICAqIFt1bm1hcnNoYWxpbmdFcnJvcl0oI3VubWFyc2hhbGluZ2Vycm9yKQogICogW3BhcmFtc10oI3BhcmFtcykKKiAqKltUeXBlc10oI3R5cGVzKSoqCiAgKiBbdmFsaWRhdGVdKCN2YWxpZGF0ZSkKCiMjIFtDb21tb25dKC4vdGVtcGxhdGVzL3V0aWxzL19jb21tb24udHBsKQoKTWFraW5nIHVzZSBvZiBhbGwgdGhlIGNvbW1vbiB0ZW1wbGF0ZXMgZW5hYmxlIHRoZSBmb2xsb3dpbmcga2V5czoKCiAgKiBbQWxsIENvbW1vbiBWYWx1ZXMgY2FuIGJlIGZvdW5kIGhlcmVdKC4vdGVtcGxhdGVzL3ZhbHVlcy9fY29tbW9uLnlhbWwpCgotLS0KCiMjIyBGdWxsbmFtZQoKRXh0ZW5kZWQgRnVuY3Rpb24gdG8gcmV0dXJuIGEgZnVsbG5hbWUuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5gL2AuY29udGV4dGAgLSBJbmhlcml0ZWQgUm9vdCBDb250ZXh0IChSZXF1aXJlZCkuIE1ha2Ugc3VyZSBnbG9iYWwgdmFyaWFibGVzIGFyZSBhY2Nlc3NpYmxlIHRocm91Z2ggdGhlIGNvbnRleHQuCiAgKiBgLm5hbWVgIC0gRGVmaW5lIGEgY3VzdG9tIG5hbWUsIHdpdGhvdXQgcHJlZml4LiBUaGUgZ2l2ZW4gdmFsdWUgd2lsbCBhcHBlbmRlZCB0byBhbiBldmFsdWF0ZWQgcHJlZml4LiBCZWNvbWVzIHN1ZmZpeCBvZiB0aGUgYCQuVmFsdWVzLmZ1bGxuYW1lT3ZlcnJpZGVgIHByb3BlcnR5LCBpZiBzZXQuIENhbiBhbHNvIGJlIHNldCB0aHJvdWdoIGAuY29udGV4dC5uYW1lYC4KICAqIGAuZnVsbG5hbWVgIC0gRGVmaW5lIGEgY3VzdG9tIGZ1bGxuYW1lLiBUaGUgZ2l2ZW4gdmFsdWUgd2lsbCBiZSByZXR1cm5lZCBhcyBuYW1lLiBJcyBvdmVyd3JpdHRlbiBieSB0aGUgYCQuVmFsdWVzLmZ1bGxuYW1lT3ZlcnJpZGVgIHByb3BlcnR5LCBpZiBzZXQuIENhbiBhbHNvIGJlIHNldCB0aHJvdWdoIGAuY29udGV4dC5mdWxsbmFtZWAuCiAgKiBgLnByZWZpeGAgLSBEZWZpbmUgYSBjdXN0b20gUHJlZml4IGZvciB0aGUgZnVsbG5hbWUuIChEZWZhdWx0cyB0byBgJC5SZWxlYXNlLk5hbWVgKQoKIyMjIyBLZXlzCgpUaGlzIGZ1bmN0aW9uIGVuYWJsZXMgdGhlIGZvbGxvd2luZyBrZXlzIG9uIHRoZSB2YWx1ZXMgc2NvcGU6CgpgYGAKIyMgT3ZlcndyaXRlIE5hbWUgVGVtcGxhdGUKIyBuYW1lT3ZlcnJpZGUgLS0gT3ZlcndyaXRlICJsaWIuaW50ZXJuYWwuY29tbW9uLm5hbWUiIG91dHB1dApuYW1lT3ZlcnJpZGU6ICIiCgojIyBPdmVyd3JpdGUgRnVsbG5hbWUgVGVtcGxhdGUKIyBmdWxsbmFtZU92ZXJyaWRlIC0tIE92ZXJ3cml0ZSBgbGliLnV0aWxzLmNvbW1vbi5mdWxsbmFtZWAgb3V0cHV0CmZ1bGxuYW1lT3ZlcnJpZGU6ICIiCgpgYGAKCiMjIyMgUmV0dXJucwoKU3RyaW5nCgojIyMjIFVzYWdlCgpgYGAKey0gaW5jbHVkZSAibGliLnV0aWxzLmNvbW1vbi5mdWxsbmFtZSIgJCkgfQpgYGAKCi0tLQoKIyMjIENoYXJ0CgpDaGFydCBOYW1lCgojIyMjIFJldHVybnMKClN0cmluZwoKIyMjIyBVc2FnZQoKYGBgCnstIGluY2x1ZGUgImxpYi5pbnRlcm5hbC5jb21tb24uY2hhcnQiICQpIH0KYGBgCgotLS0KCiMjIyBTZWxlY3RvckxhYmVscwoKVGhpcyB0ZW1wbGF0ZSB3aWxsIHJldHVybiB0aGUgZGVmYXVsdCBzZWxlY3RvckxhYmVscyAoVXNlYWJsZSBmb3IgTWF0Y2gvU2VsZWN0b3IgTGFiZWxzKS4gSW4gYWRkaXRpb24gdGhlcmUgaXMgdGhlCm9wdGlvbiB0byBvdmVyd3JpdGUgdGhlc2UgbGFiZWxzLiBJZiBubyBzZWxlY3RvckxhYmVscyBhcmUgZGVmaW5lZCwgdGhlIGZvbGxvd2luZyBsYWJlbHMgYXJlIHNldDoKCmBgYAphcHAua3ViZXJuZXRlcy5pby9uYW1lOiB7IGluY2x1ZGUgImxpYi51dGlscy5jb21tb24ubmFtZSIgLiB9CmFwcC5rdWJlcm5ldGVzLmlvL2luc3RhbmNlOiB7IC5SZWxlYXNlLk5hbWUgfQpgYGAKCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4KCiAgKiBgLmAgLSBJbmhlcml0ZWQgUm9vdCBDb250ZXh0IChSZXF1aXJlZCkuIE1ha2Ugc3VyZSBnbG9iYWwgdmFyaWFibGVzIGFyZSBhY2Nlc3NpYmxlIHRocm91Z2ggdGhlIGNvbnRleHQuCgojIyMjIEtleXMKClRoaXMgZnVuY3Rpb24gZW5hYmxlcyB0aGUgZm9sbG93aW5nIGtleXMgb24gdGhlIHZhbHVlcyBzY29wZToKCmBgYAojIyBTZWxlY3RvciBMYWJlbHMKIyBzZWxlY3RvckxhYmVscyAtLSBEZWZpbmUgZGVmYXVsdCBbc2VsZWN0b3JMYWJlbHNdKGh0dHBzOi8va3ViZXJuZXRlcy5pby9kb2NzL2NvbmNlcHRzL292ZXJ2aWV3L3dvcmtpbmctd2l0aC1vYmplY3RzL2xhYmVscy8pCnNlbGVjdG9yTGFiZWxzOiB7fQpgYGAKCiMjIyMgUmV0dXJucwoKWUFNTCBTdHJ1Y3R1cmUsIFN0cmluZwoKIyMjIyBVc2FnZQoKYGBgCnstIGluY2x1ZGUgImxpYi51dGlscy5jb21tb24uc2VsZWN0b3JMYWJlbHMiICQpIH0KYGBgCgotLS0KCiMjIyBEZWZhdWx0TGFiZWxzCgpUaGlzIHRlbXBsYXRlIHJlcHJlc2VudHMgdGhlIGRlZmF1bHQgdGVtcGxhdGVzLiBJdCBpbmNsdWRlcyB0aGUgYFNlbGVjdG9yTGFiZWxgIHRlbXBsYXRlIGFuZCBzZXRzIHRoZSBBcHBsaWNhdGlvbiBWZXJzaW9uLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuYCAtIEluaGVyaXRlZCBSb290IENvbnRleHQgKFJlcXVpcmVkKS4gTWFrZSBzdXJlIGdsb2JhbCB2YXJpYWJsZXMgYXJlIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgY29udGV4dC4KCiMjIyMgUmV0dXJucwoKWUFNTCBTdHJ1Y3R1cmUsIFN0cmluZwoKIyMjIyBVc2FnZQoKYGBgCnstIGluY2x1ZGUgImxpYi51dGlscy5jb21tb24uZGVmYXVsdExhYmVscyIgJCkgfQpgYGAKCi0tLQoKIyMjIE92ZXJ3cml0ZUxhYmVscwoKVGhpcyB0ZW1wbGF0ZSBhbGxvd3MgdG8gZGVmaW5lIG92ZXJ3cml0dGluZyBsYWJlbHMuIE92ZXJ3cml0ZSBsYWJlbHMgb3ZlcndyaXRlIHRoZSBkZWZhdWx0IGxhYmVscyAoRGVmYXVsdExhYmVscyBUZW1wbGF0ZSkuIEJ5IFVzaW5nIHRoaXMgdGVtcGxhdGUKdGhlIGtleSBgLlZhbHVlcy5vdmVyd3JpdGVMYWJlbHNgIGlzIGNvbnNpZGVyZWQgaW4geW91ciB2YWx1ZSBzdHJ1Y3R1cmUuIElmIHRoZSBrZXkgaGFzIHZhbHVlcyBhbmQgaXMgdHlwZSBgbWFwYCB0aGUgdmFsdWVzIGFyZSB1c2VkCmFzIGNvbW1vbiBsYWJlbHMuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5gIC0gSW5oZXJpdGVkIFJvb3QgQ29udGV4dCAoUmVxdWlyZWQpLiBNYWtlIHN1cmUgZ2xvYmFsIHZhcmlhYmxlcyBhcmUgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZSBjb250ZXh0LgoKIyMjIyBLZXlzCgpUaGlzIGZ1bmN0aW9uIGVuYWJsZXMgdGhlIGZvbGxvd2luZyBrZXlzIG9uIHRoZSB2YWx1ZXMgc2NvcGU6CgpgYGAKIyMgT3ZlcndyaXRlIExhYmVscwojIG92ZXJ3cml0ZUxhYmVscyAtLSBPdmVyd3JpdGVzIGRlZmF1bHQgbGFiZWxzLCBidXQgbm90IHJlc291cmNlIHNwZWNpZmljIGxhYmVscyBhbmQgY29tbW9uIGxhYmVscwpvdmVyd3JpdGVMYWJlbHM6IHt9CmBgYAoKIyMjIyBSZXR1cm5zCgpZQU1MIFN0cnVjdHVyZSwgU3RyaW5nCgojIyMjIFVzYWdlCgpgYGAKey0gaW5jbHVkZSAibGliLnV0aWxzLmNvbW1vbi5vdmVyd3JpdGVMYWJlbHMiICQpIH0KYGBgCgotLS0KCiMjIyBDb21tb25MYWJlbHMKClRoaXMgdGVtcGxhdGUgYWxsb3dzIHRvIGRlZmluZSBjb21tb24gbGFiZWxzLiBDb21tb24gbGFiZWxzIGFyZSBhcHBlbmRlZCB0byB0aGUgYmFzZSBsYWJlbHMgKG5vIG1lcmdlKS4gQnkgVXNpbmcgdGhpcyB0ZW1wbGF0ZQp0aGUga2V5IGAuVmFsdWVzLmNvbW1vbkxhYmVsc2AgaXMgY29uc2lkZXJlZCBpbiB5b3VyIHZhbHVlIHN0cnVjdHVyZS4gSWYgdGhlIGtleSBoYXMgdmFsdWVzIGFuZCBpcyB0eXBlIGBtYXBgIHRoZSB2YWx1ZXMgYXJlIHVzZWQKYXMgY29tbW9uIGxhYmVscy4KCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4KCiAgKiBgLmAgLSBJbmhlcml0ZWQgUm9vdCBDb250ZXh0IChSZXF1aXJlZCkuIE1ha2Ugc3VyZSBnbG9iYWwgdmFyaWFibGVzIGFyZSBhY2Nlc3NpYmxlIHRocm91Z2ggdGhlIGNvbnRleHQuCgojIyMjIEtleXMKClRoaXMgZnVuY3Rpb24gZW5hYmxlcyB0aGUgZm9sbG93aW5nIGtleXMgb24gdGhlIHZhbHVlcyBzY29wZToKCmBgYAojIyBDb21tb24gTGFiZWxzCiMgY29tbW9uTGFiZWxzIC0tIENvbW1vbiBMYWJlbHMgYXJlIGFkZGVkIHRvIGVhY2gga3ViZXJuZXRlcyByZXNvdXJjZSBtYW5pZmVzdC4gQnV0IHdpbGwgbm90IGJlIGFkZGVkIHRvIHJlc291cmNlcyByZW5kZXJlZCBieSB0aGUgY29tbW9uIGNoYXJ0IChlZy4gSk1YIEV4cG9ydGVyKQpjb21tb25MYWJlbHM6IHt9CgojIyBPdmVyd3JpdGUgTGFiZWxzCiMgb3ZlcndyaXRlTGFiZWxzIC0tIE92ZXJ3cml0ZXMgZGVmYXVsdCBsYWJlbHMsIGJ1dCBub3QgcmVzb3VyY2Ugc3BlY2lmaWMgbGFiZWxzIGFuZCBjb21tb24gbGFiZWxzCm92ZXJ3cml0ZUxhYmVsczoge30KYGBgCgojIyMjIFJldHVybnMKCllBTUwgU3RydWN0dXJlLCBTdHJpbmcKCiMjIyMgVXNhZ2UKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuY29tbW9uLmNvbW1vbkxhYmVscyIgJCkgfQpgYGAKCi0tLQoKIyMjIExhYmVscwoKVGhpcyB0ZW1wbGF0ZSB3cmFwcyBhcm91bmQgYWxsIHRoZSBvdGhlciBsYWJlbCB0ZW1wbGF0ZXMuIFRoZXJlZm9yIGFsbCB0aGVpciBmdW5jdGlvbmFsaXRpZXMgYXJlIGF2YWlsYWJsZSB3aXRoIHRoaXMgdGVtcGxhdGUuIEluIGFkZGl0aW9uIGl0J3MgcG9zc2libGUgdG8gcGFzcyBsYWJlbHMsIHdoaWNoIG92ZXJ3cml0ZSB0aGUgcmVzdWx0IG9mIGFsbCB0aGUgbGFiZWwgdGVtcGxhdGVzLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuLy5jb250ZXh0YCAtIEluaGVyaXRlZCBSb290IENvbnRleHQgKFJlcXVpcmVkKS4KICAqIGAubGFiZWxzYCAtIExhYmVscyB3aGljaCBvdmVyd3JpdGUgdGhlIHJlc3VsdGluZyBsYWJlbHMgb2YgYWxsIHRoZSBvdGhlciBsYWJlbCB0ZW1wbGF0ZXMuCiAgKiBgLnZlcnNpb25VbnNwZWNpZmljYCAtIFJlbW92ZXMgdGhlIHZlcnNpb24gbGFiZWwuIFVzZWZ1bCB3aGVuIHlvdSBkb24ndCB3YW50IHlvdXIgcmVzb3VyY2UgdG8gYmUgY2hhbmdlZCBvbiB2ZXJzaW9uIHVwZGF0ZSAoU3BlYyBDaGFuZ2UpLgoKIyMjIyBLZXlzCgpUaGlzIGZ1bmN0aW9uIGVuYWJsZXMgdGhlIGZvbGxvd2luZyBrZXlzIG9uIHRoZSB2YWx1ZXMgc2NvcGU6CgpgYGAKIyMgQ29tbW9uIExhYmVscwojIGNvbW1vbkxhYmVscyAtLSBDb21tb24gTGFiZWxzIGFyZSBhZGRlZCB0byBlYWNoIGt1YmVybmV0ZXMgcmVzb3VyY2UgbWFuaWZlc3QuIEJ1dCB3aWxsIG5vdCBiZSBhZGRlZCB0byByZXNvdXJjZXMgcmVuZGVyZWQgYnkgdGhlIGNvbW1vbiBjaGFydCAoZWcuIEpNWCBFeHBvcnRlcikKY29tbW9uTGFiZWxzOiB7fQoKIyMgT3ZlcndyaXRlIExhYmVscwojIG92ZXJ3cml0ZUxhYmVscyAtLSBPdmVyd3JpdGVzIGRlZmF1bHQgbGFiZWxzLCBidXQgbm90IHJlc291cmNlIHNwZWNpZmljIGxhYmVscyBhbmQgY29tbW9uIGxhYmVscwpvdmVyd3JpdGVMYWJlbHM6IHt9CgpgYGAKCiMjIyMgUmV0dXJucwoKWUFNTCBTdHJ1Y3R1cmUsIFN0cmluZwoKIyMjIyBVc2FnZQoKYGBgCnstIGluY2x1ZGUgImxpYi51dGlscy5jb21tb24ubGFiZWxzIiAoZGljdCAibGFiZWxzIiAoZGljdCAiY3VzdG9tLmxhYmVsIiAidmFsdWUiICJjdXN0b20ubGFiZWwvMiIgInZhbHVlIikgImNvbnRleHQiICQpIH0KYGBgCgotLS0KCiMjIyBLdWJlQ2FwYWJpbGl0aWVzCgpUaGlzIHRlbXBsYXRlIGFsbG93cyB0byBkZWZpbmUgYSBjdXN0b20gS3ViZUNhcGFiaWxpdGllcyBWZXJzaW9uIChyZXBsYWNlcyBgJC5DYXBhYmlsaXRpZXMuS3ViZVZlcnNpb24uR2l0VmVyc2lvbmApLiBUaGlzIG1pZ2h0IGJlIHVzZWZ1bCB3aGVuCnRyeWluZyB0byB0ZXN0IHRoZSBjaGFydCBvciBoYXZpbmcgY2xpZW50IHZlcnNpb25zIHRoYXQgZGlmZmVyIGZyb20gdGhlIHNlcnZlciB2ZXJzaW9uLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuYCAtIEluaGVyaXRlZCBSb290IENvbnRleHQgKFJlcXVpcmVkKS4gTWFrZSBzdXJlIGdsb2JhbCB2YXJpYWJsZXMgYXJlIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgY29udGV4dC4KCiMjIyMgS2V5cwoKVGhpcyBmdW5jdGlvbiBlbmFibGVzIHRoZSBmb2xsb3dpbmcga2V5cyBvbiB0aGUgdmFsdWVzIHNjb3BlOgoKYGBgCiMjIFZlcnNpb24gQ2FwYWJpbGl0aWVzCiMga3ViZUNhcGFiaWxpdGllcyAtLSBPdmVyd3JpdGUgdGhlIEt1YmUgR2l0VmVyc2lvbgojIEBkZWZhdWx0IC0tIGAkLkNhcGFiaWxpdGllcy5LdWJlVmVyc2lvbi5HaXRWZXJzaW9uYAprdWJlQ2FwYWJpbGl0aWVzOiAiMS4xOS4wIgpgYGAKCiMjIyMgUmV0dXJucwoKU3RyaW5nCgojIyMjIFVzYWdlCgpgYGAKey0gaWYgc2VtdmVyQ29tcGFyZSAiPj0xLjE5LTAiIChpbmNsdWRlICJsaWIudXRpbHMuY29tbW9uLmNhcGFiaWxpdGllcyIgJCkgfQphcGlWZXJzaW9uOiBuZXR3b3JraW5nLms4cy5pby92MQp7LSBlbHNlIGlmIHNlbXZlckNvbXBhcmUgIj49MS4xNC0wIiAoaW5jbHVkZSAibGliLnV0aWxzLmNvbW1vbi5jYXBhYmlsaXRpZXMiICRjb250ZXh0KSAtfQphcGlWZXJzaW9uOiBuZXR3b3JraW5nLms4cy5pby92MWJldGExCnstIGVsc2UgLX0KYGBgCgojIyBbR2xvYmFsc10oLi90ZW1wbGF0ZXMvdXRpbHMvX2dsb2JhbHMudHBsKQoKTWFraW5nIHVzZSBvZiBhbGwgdGhlIGdsb2JhbCBmdW5jdGlvbnMgZW5hYmxlIHRoZSBmb2xsb3dpbmcgW2dsb2JhbCBrZXlzXShodHRwczovL2hlbG0uc2gvZG9jcy9jaGFydF90ZW1wbGF0ZV9ndWlkZS9zdWJjaGFydHNfYW5kX2dsb2JhbHMvKS4KCiAgKiBbQWxsIEdsb2JhbCBWYWx1ZXMgY2FuIGJlIGZvdW5kIGhlcmVdKC4vdGVtcGxhdGVzL3ZhbHVlcy9fZ2xvYmFscy55YW1sKQoKLS0tCgojIyMgRG9ja2VySW1hZ2UKClRoaXMgZnVuY3Rpb24gb3ZlcndyaXRlcyBsb2NhbCBkb2NrZXIgcmVnaXN0cmllcyB3aXRoIGdsb2JhbCBkZWZpbmVkIHJlZ2lzdHJpZXMsIGlmIGF2YWlsYWJsZS4gUmV0dXJucyB0aGUgYXNzZW1ibGVkIG91dHB1dApiYXNlZCBvbiByZWdpc3RyeSwgcmVwb3NpdG9yeSBhbmQgdGFnLiBUaGUgYCQuZ2xvYmFsLmRlZmF1bHRUYWdgIHZhbHVlIGhhcyBwcmVjZWRlbmNlIG92ZXIgdGhlIGAuZGVmYXVsdGAgdmFsdWUuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5pbWFnZWAgLSBMb2NhbCBSZWdpc3RyeSBkZWZpbml0aW9uLCBzZWUgdGhlIHN0cnVjdHVyZSBiZWxvdyAoUmVxdWlyZWQpLgogICogYC5jb250ZXh0YCAtIEluaGVyaXRlZCBSb290IENvbnRleHQgKFJlcXVpcmVkKS4gTWFrZSBzdXJlIGdsb2JhbCB2YXJpYWJsZXMgYXJlIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgY29udGV4dC4KICAqIGAuZGVmYXVsdGAgLSBBZGQgYSBkZWZhdWx0IHZhbHVlIGZvciB0aGUgdGFnLCBpZiBub3Qgc2V0IGV4cGxpY2l0IChPcHRpb25hbCwgRGVmYXVsdHMgdG8gImxhdGVzdCIpCgojIyMjIFN0cnVjdHVyZQoKVGhlIGZvbGxvd2luZyBzdHJ1Y3R1cmUgaXMgZXhwZWN0ZWQgZm9yIHRoZSBrZXkgJy5yZWdpc3RyeScuIEtleXMgd2l0aCBhICcqJyBhcmUgb3B0aW9uYWwuIElmIG9uIGEgcGFyZW50IGtleSwgdGhpcyBtZWFucyB5b3UgY2FuCmFkZCB0aGUgc3RydWN0dXJlIHdpdGggdGhlIHBhcmVudCBrZXkgb3IganVzdCB0aGUgc3RydWN0dXJlIHdpdGhpbiB0aGUgcGFyZW50IGtleS4KCmBgYAppbWFnZSo6CiAgcmVnaXN0cnk6IGRvY2tlci5pbwogIHJlcG9zaXRvcnk6IGJpdG5hbWkvYXBhY2hlCiAgZGlnZXN0KjogInNoYTI1Njo5ZGUxZTM0NGEzNDI5MjE1NGNhMDY5M2MxM2FhNjI5YzVhZDFmMTc2NGZhZmQ4OTVhYjUzMDMyZGRlMmFkOGU0IgogIHRhZyo6IGxhdGVzdAoKb3IKCnJlZ2lzdHJ5OiBkb2NrZXIuaW8KcmVwb3NpdG9yeTogYml0bmFtaS9hcGFjaGUKZGlnZXN0KjogInNoYTI1Njo5ZGUxZTM0NGEzNDI5MjE1NGNhMDY5M2MxM2FhNjI5YzVhZDFmMTc2NGZhZmQ4OTVhYjUzMDMyZGRlMmFkOGU0Igp0YWcqOiBsYXRlc3QKYGBgCgojIyMjIEtleXMKClRoaXMgZnVuY3Rpb24gZW5hYmxlcyB0aGUgZm9sbG93aW5nIGtleXMgb24gdGhlIGdsb2JhbCBzY29wZToKCmBgYApnbG9iYWw6CgogICMjIEdsb2JhbCBEb2NrZXIgSW1hZ2UgUmVnaXN0cnkKICAjIGdsb2JhbC5pbWFnZVJlZ2lzdHJ5IC0tIEdsb2JhbCBEb2NrZXIgSW1hZ2UgUmVnaXN0cnkgZGVjbGFyYXRpb24uIFdpbGwgb3ZlcndyaXRlIGFsbCBjaGlsZCAucmVnaXN0cnkgZmllbGRzLgogIGltYWdlUmVnaXN0cnk6ICJjb21wYW55LXJlZ2lzdHJ5LyIKCiAgIyMgR2xvYmFsIERlZmF1bHQgSW1hZ2UgVGFnCiAgIyBnbG9iYWwuZGVmYXVsdFRhZyAtLSBHbG9iYWwgRG9ja2VyIEltYWdlIFRhZyBkZWNsYXJhdGlvbi4gV2lsbCBiZSB1c2VkIGFzIGRlZmF1bHQgdGFnLCBpZiBubyB0YWcgaXMgZ2l2ZW4gYnkgY2hpbGQKICBkZWZhdWx0VGFnOiAiMS4wLjAiCmBgYAoKRWFjaCBpbWFnZSByZWZlcmVuY2VkIGF1dG9tYXRpY2FsbHkgaXMgZXhwZWN0ZWQgdG8gaGF2ZSB0aGUgYWJvdmUgc3RydWN0dXJlIGluIHRoZSB2YWx1ZXMgKEV4YW1wbGUpOgoKYGBgCmFwYWNoZToKICByZWdpc3RyeSo6IGRvY2tlci5pbwogIHJlcG9zaXRvcnk6IGJpdG5hbWkvYXBhY2hlCiAgZGlnZXN0KjogInNoYTI1Njo5ZGUxZTM0NGEzNDI5MjE1NGNhMDY5M2MxM2FhNjI5YzVhZDFmMTc2NGZhZmQ4OTVhYjUzMDMyZGRlMmFkOGU0IgogIHRhZyo6IGxhdGVzdAoKb3IKCmFwYWNoZToKICBpbWFnZToKICAgIHJlcG9zaXRvcnk6IGJpdG5hbWkvYXBhY2hlCmBgYAoKSXMgaW5jbHVkZWQgYXM6CgpgYGAKICAgICAgY29udGFpbmVyczoKICAgICAgICAtIG5hbWU6IGFwYWNoZQogICAgICAgICAgaW1hZ2U6IHstIGluY2x1ZGUgImxpYi51dGlscy5nbG9iYWxzLmltYWdlIiAoZGljdCAiaW1hZ2UiIC5WYWx1ZXMuYXBhY2hlICJjb250ZXh0IiAkICJkZWZhdWx0IiAuQ2hhcnQuQXBwVmVyc2lvbikgfQpgYGAKCiMjIyMgUmV0dXJucwoKU3RyaW5nCgojIyMjIFVzYWdlCgpgYGAKey0gaW5jbHVkZSAibGliLnV0aWxzLmdsb2JhbHMuaW1hZ2UiIChkaWN0ICJyZWdpc3RyeSIgLlZhbHVlcy5pbWFnZSAiY29udGV4dCIgJCAiZGVmYXVsdCIgLkNoYXJ0LkFwcFZlcnNpb24pIH0KYGBgCgotLS0KCiMjIyBJbWFnZVB1bGxQb2xpY3kKClRoaXMgZnVuY3Rpb24gb3ZlcndyaXRlcyBsb2NhbCBkb2NrZXIgaW1hZ2UgcHVsbHBvbGljaWVzIHdpdGggZ2xvYmFsIGRlZmluZWQgcHVsbHBvbGljaWVzLCBpZiBhdmFpbGFibGUuCgojIyMjICBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuaW1hZ2VQdWxsUG9saWN5YCAtIExvY2FsIGRvY2tlciBpbWFnZSBwdWxsUG9saWN5LCB3aGljaCBhcmUgb3ZlcndyaXR0ZW4gaWYgdGhlIGdsb2JhbCB2YXJpYWJsZSBpcyBzZXQuIElmIG5laXRoZXIgaXMgc2V0LCBhbiBlbXB0eSBzdHJpbmcgaXMgcmV0dXJuZWQgKFJlcXVpcmVkKS4KICAqIGAuY29udGV4dGAgLSBJbmhlcml0ZWQgUm9vdCBDb250ZXh0IChSZXF1aXJlZCkuIE1ha2Ugc3VyZSBnbG9iYWwgdmFyaWFibGVzIGFyZSBhY2Nlc3NpYmxlIHRocm91Z2ggdGhlIGNvbnRleHQuCgojIyMjIFN0cnVjdHVyZQoKVGhlIGZvbGxvd2luZyBzdHJ1Y3R1cmUgaXMgZXhwZWN0ZWQgZm9yIHRoZSBrZXkgJy5wZXJzaXN0ZW5jZScuIEtleXMgd2l0aCBhICcqJyBhcmUgb3B0aW9uYWwuIElmIG9uIGEgcGFyZW50IGtleSwgdGhpcyBtZWFucyB5b3UgYW4KYWRkIHRoZSBzdHJ1Y3R1cmUgd2l0aCB0aGUgcGFyZW50IGtleSBvciBqdXN0IHRoZSBzdHJ1Y3R1cmUgd2l0aGluIHRoZSBwYXJlbnQga2V5LgoKYGBgCmltYWdlKjoKICBpbWFnZVB1bGxQb2xpY3k6ICJBbHdheXMiCgpvcgoKaW1hZ2VQdWxsUG9saWN5OiAiQWx3YXlzIgpgYGAKCldvdWxkIGJvdGggd29yayB3aXRoIGV4YW1wbGU6CgpgYGAKey0gaW5jbHVkZSAibGliLnV0aWxzLmdsb2JhbHMucHVsbFBvbGljeSIgKGRpY3QgImltYWdlUHVsbFBvbGljeSIgLlZhbHVlcyAiY29udGV4dCIgJCkgfQpgYGAKIyMjIyBLZXlzCgpUaGlzIGZ1bmN0aW9uIGVuYWJsZXMgdGhlIGZvbGxvd2luZyBrZXlzIG9uIHRoZSBnbG9iYWwgc2NvcGU6CgpgYGAKZ2xvYmFsOgoKICAjIyBHbG9iYWwgRG9ja2VyIEltYWdlIFB1bGxQb2xpY3kKICAjIGdsb2JhbC5pbWFnZVB1bGxQb2xpY3kgLS0gR2xvYmFsIERvY2tlciBJbWFnZSBQdWxsIFBvbGljeSBkZWNsYXJhdGlvbi4gV2lsbCBvdmVyd3JpdGUgYWxsIGNoaWxkIC5wdWxsUG9saWN5IGZpZWxkcy4KICBpbWFnZVB1bGxQb2xpY3k6ICJBbHdheXMiCmBgYAoKIyMjIyBSZXR1cm5zCgpNYXAsIEVtcHR5IGlmIG5vIFB1bGxTZWNyZXRzIERlZmluZWQuCgpgYGAKaW1hZ2VQdWxsU2VjcmV0czoKIC0gc2VjcmV0LTEKIC0gZ2xvYmFsLXNlY3JldC0xCmBgYAoKIyMjIyBVc2FnZQoKYGBgCnstIGluY2x1ZGUgImxpYi51dGlscy5nbG9iYWxzLmltYWdlUHVsbFBvbGljeSIgKGRpY3QgInB1bGxQb2xpY3kiIC5WYWx1ZXMuaW1hZ2UucHVsbHBvbGljeSAiY29udGV4dCIgJCkgfQpgYGAKCi0tLQoKIyMjIEltYWdlUHVsbHNlY3JldHMKClRoaXMgZnVuY3Rpb24gbWVyZ2VzIGxvY2FsIHB1bGxTZWNyZXRzIHdpdGggZ2xvYmFsIGRlZmluZWQgcHVsbFNlY3JldHMsIGlmIGF2YWlsYWJsZS4KCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4KCiAgKiBgLnB1bGxTZWNyZXRzYCAtIExvY2FsIHB1bGxTZWNyZXRzLCB3aGljaCBhcmUgb3ZlcndyaXR0ZW4gaWYgdGhlIGdsb2JhbCB2YXJpYWJsZSBpcyBzZXQuIElmIG5laXRoZXIgaXMgc2V0LCBhbiBlbXB0eSBzdHJpbmcgaXMgcmV0dXJuZWQgKE9wdGlvbmFsLCBEZWZhdWx0cyB0byBlbXB0eSkuCiAgKiBgLmNvbnRleHRgIC0gSW5oZXJpdGVkIFJvb3QgQ29udGV4dCAoUmVxdWlyZWQpLiBNYWtlIHN1cmUgZ2xvYmFsIHZhcmlhYmxlcyBhcmUgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZSBjb250ZXh0LgoKIyMjIyBLZXlzCgpUaGlzIGZ1bmN0aW9uIGVuYWJsZXMgdGhlIGZvbGxvd2luZyBrZXlzOgoKYGBgCmdsb2JhbDoKCiAgIyMgR2xvYmFsIEltYWdlIFB1bGwgU2VjcmV0cwogICMgZ2xvYmFsLmltYWdlUHVsbFNlY3JldHMgLS0gR2xvYmFsIERvY2tlciBJbWFnZSBQdWxsIFNlY3JldHMgZGVjbGFyYXRpb24uIEFkZGVkIHRvIGxvY2FsIERvY2tlciBJbWFnZSBQdWxsIFNlY3JldHMuCiAgaW1hZ2VQdWxsU2VjcmV0czogW10KYGBgCgojIyMjIFJldHVybnMKCllBTUwgU3RydWN0dXJlLCBTdHJpbmcKCiMjIyMgVXNhZ2UKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuZ2xvYmFscy5pbWFnZVB1bGxTZWNyZXRzIiAoZGljdCAicHVsbFNlY3JldHMiIC5WYWx1ZXMuaW1hZ2VQdWxsU2VjcmV0cyAiY29udGV4dCIgJCkgfQpgYGAKCi0tLQoKIyMjIFN0b3JhZ2VDbGFzcwoKVGhpcyBGdW5jdGlvbiBjaGVja3MgZm9yIGEgZ2xvYmFsIHN0b3JhZ2UgY2xhc3MgYW5kIHJldHVybnMgaXQsIGlmIHNldC4KV2l0aCB0aGUgUGFyYW1ldGVyICJwZXJzaXN0ZW5jZSIgeW91IGNhbiBwYXNzIHlvdXIgcGVyc2lzdGVuY2Ugc3RydWN0dXJlLiBUaGUgZnVuY3Rpb24KaXMgbG9va2luZyBmb3IgYSBzdG9yYWdlQ2xhc3MgZGVmaW5pdGlvbi4gSWYgdGhlIEtpbmQgb2YgdGhlICJwZXJzaXN0ZW5jZSIgaXMgc3RyaW5nLAppdCdzIGFzc3VtZWQgdGhlIHN0b3JhZ2VDbGFzcyB3YXMgZGlyZWN0bHkgZ2l2ZW4uIElmIG5vdCwgdGhlIGZ1bmN0aW9uIHdpbGwgbG9vayBmb3IgYSAuc3RvcmFnZUNsYXNzCmluIHRoZSBnaXZlbiBzdHJ1Y3R1cmUuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5wZXJzaXN0ZW5jZWAgLSBMb2NhbCBTdG9yYWdlQ2xhc3MvUGVyc2lzdGVuY2UgY29uZmlndXJhdGlvbiwgc2VlIHRoZSBzdHJ1Y3R1cmUgYmVsb3cuCiAgKiBgLmNvbnRleHRgIC0gSW5oZXJpdGVkIFJvb3QgQ29udGV4dCAoUmVxdWlyZWQpLiBNYWtlIHN1cmUgZ2xvYmFsIHZhcmlhYmxlcyBhcmUgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZSBjb250ZXh0LgoKIyMjIyBTdHJ1Y3R1cmUKClRoZSBmb2xsb3dpbmcgc3RydWN0dXJlIGlzIGV4cGVjdGVkIGZvciB0aGUga2V5ICcucGVyc2lzdGVuY2UnLiBLZXlzIHdpdGggYSAnKicgYXJlIG9wdGlvbmFsLiBJZiBvbiBhIHBhcmVudCBrZXksIHRoaXMgbWVhbnMgeW91IGNhbgphZGQgdGhlIHN0cnVjdHVyZSB3aXRoIHRoZSBwYXJlbnQga2V5IG9yIGp1c3QgdGhlIHN0cnVjdHVyZSB3aXRoaW4gdGhlIHBhcmVudCBrZXkuCgpgYGAKcGVyc2lzdGVuY2UqOgogIHN0b3JhZ2VDbGFzczogImxvY2FsLXN0b3JhZ2UiCgpvcgoKcGVyc2lzdGVuY2U6ICJsb2NhbC1zdG9yYWdlIgpgYGAKCiMjIyMgS2V5cwoKVGhpcyBmdW5jdGlvbiBlbmFibGVzIHRoZSBmb2xsb3dpbmcga2V5czoKCmBgYApnbG9iYWw6CgogICMjIEdsb2JhbCBTdG9yYWdlQ2xhc3MKICAjIGdsb2JhbC5zdG9yYWdlQ2xhc3MgLS0gR2xvYmFsIFN0b3JhZ2VDbGFzcyBkZWNsYXJhdGlvbi4gQ2FuIGJlIHVzZWQgdG8gb3ZlcndyaXRlIFN0b3JhZ2VDbGFzcyBmaWVsZHMuCiAgc3RvcmFnZUNsYXNzOiAiIgpgYGAKCiMjIyMgUmV0dXJucwoKU3RyaW5nCgojIyMjIFVzYWdlCgpgYGAKeyBpbmNsdWRlICJsaWIudXRpbHMuZ2xvYmFscy5zdG9yYWdlQ2xhc3MiIChkaWN0ICJwZXJzaXN0ZW5jZSIgLlZhbHVlcy5wZXJzaXN0ZW5jZSAiY29udGV4dCIgJCkgfQpgYGAKCiMjIFtTdHJpbmdzXSguL3RlbXBsYXRlcy91dGlscy9fc3RyaW5ncy50cGwpCgotLS0KCiMjIyBUZW1wbGF0ZQoKVGhpcyBmdW5jdGlvbiBhbGxvd3MgdG8gcmVuZGVyIFN0cmluZy9NYXAgaW5wdXQgd2l0aCB0aGUgZ28gdGVtcGxhdGUgZW5naW5lLiBTaW5jZSB0aGUKZ28gdGVtcGxhdGUgZW5naW5lIGRvZXNuJ3QgZGlyZWN0bHkgYWNjZXB0IG1hcHMsIG1hcHMgYXJlIGR1bXBlZCBpbiBZQU1MIGZvcm1hdC4gSWYgeW91IHdhbnQgdG8KcmV1c2UgdGhlIHJldHVybmVkIHZhbHVlLCB5b3UgbmVlZCB0byB1c2UgdGhlIGZyb21ZYW1sIGZ1bmN0aW9uLiBJZiB5b3UgaGF2ZSBhIG11bHRpbGluZSBZQU1MLCBidXQgeW91IHdhbnQKdG8gcmVuZGVyIGl0IGFzIHBhcnQgb2YgdGhlIFlBTUwgU3RydWN0dXJlLCB1c2UgK3wuIFRoaXMgWUFNTCBtdWx0aWxpbmUgaW5kaWNhdG9yIHdpbGwgYmUgcmVwbGFjZWQgYnkgXG4uCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC52YWx1ZWAgLSBDb250ZW50IHlvdSB3YW50IHRvIHRlbXBsYXRlLiBJZiBhIEdvIFN0cnVjdCwgaXQgd2lsbCBiZSBkdW1wZWQgdG8gWUFNTCwgc2luY2UgdGhlIHRwbCBmdW5jdGlvbiBvbmx5IGFsbG93cyBzdHJpbmdzIChSZXF1aXJlZCkuCiAgKiBgLmV4dHJhVmFsdWVzYCAtIEV4dHJhIHZhbHVlcyB5b3Ugd2FudCB0byBtYWtlIGF2YWlsYWJsZSBmb3IgdGhlIHRlbXBsYXRlIGZ1bmN0aW9uLiBDYW4gYmUgYWNjZXNzZWQgdGhyb3VnaCAkLmV4dHJhVmFycyAoT3B0aW9uYWwpCiAgKiBgLmV4dHJhVmFsdWVzS2V5YCAtIEtleSB3aGljaCBpcyB1c2VkIHRvIHB1Ymxpc2ggYC5leHRyYVZhbHVlc2AuIEV4dHJhIFZhbHVlIGNhbiBiZSBhY2Nlc3NlZCB0aHJvdWdoICBgJC4oLmV4dHJhVmFsdWVzS2V5KWAgaWYgc2V0IChPcHRpb25hbCkKICAqIGAuY29udGV4dGAgLSBJbmhlcml0ZWQgUm9vdCBDb250ZXh0IChSZXF1aXJlZCkuCgojIyMjIFJldHVybnMKCllBTUwgU3RydWN0dXJlLCBTdHJpbmcKCiMjIyMgVXNhZ2UKCmBgYAp7IGluY2x1ZGUgImxpYi51dGlscy5zdHJpbmdzLnRlbXBsYXRlIiAoZGljdCAidmFsdWUiIC5WYWx1ZXMucGF0aC50by50aGUuVmFsdWUgImNvbnRleHQiICQgImV4dHJhVmFsdWVzIiAkZXh0cmFWYWx1ZXMpIH0KCm9yCgp7ICRzdHJ1Y3R1cmUgOj0gZnJvbVlhbWwgKGluY2x1ZGUgImxpYi51dGlscy5zdHJpbmdzLnRlbXBsYXRlIiAoZGljdCAidmFsdWUiIC5WYWx1ZXMucGF0aC50by50aGUuVmFsdWUgImNvbnRleHQiICQpKSB9CmBgYAoKLS0tCgojIyMgU3RyaW5naWZ5CgpUaGlzIGZ1bmN0aW9uIGFsbG93cyB0byBwYXNzIGEgbGlzdCBhbmQgY3JlYXRlIGEgc2luZ2xlIHN0cmluZywgd2l0aCBhIHNwZWNpZmljIGRlbGltaXRlcgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAubGlzdGAgLSBFeHBlY3RzIGlucHV0IG9mIHR5cGUgc2xpY2UuIElmIG5vdCBnaXZlbiBhcyBzbGljZSwgbm90aGluZyB3aWxsIGJlIHJldHVybmVkIChSZXF1aXJlZCkuCiAgKiBgLmNvbnRleHRgIC0gSW5oZXJpdGVkIFJvb3QgQ29udGV4dCAoUmVxdWlyZWQpLgogICogYC5kZWxpbWl0ZXJgIC0gQ2hvc2UgdGhlIGRlbGltaXRlciBiZXR3ZWVuIGVhY2ggbGlzdCBvYmplY3QgKE9wdGlvbmFsLCBEZWZhdWx0cyB0byAiICIpLgoKIyMjIyBSZXR1cm5zCgpTdHJpbmcKCiMjIyMgVXNhZ2UKCmBgYAp7IGluY2x1ZGUgImxpYi51dGlscy5zdHJpbmdzLnN0cmluZ2lmeSIgKCBkaWN0ICJsaXN0IiAoZGVmYXVsdCAobGlzdCAxIDIgMykgLlZhbHVlcy5zb21lTGlzdCkgImRlbGltaXRlciIgIiwgIiAiY29udGV4dCIgJCkgfQpgYGAKCi0tLQoKIyMjIFRvRG5zMTEyMwoKQ29udmVydHMgdGhlIGdpdmVuIHN0cmluZyBpbnRvIEROUzExMjMgYWNjZXB0ZWQgZm9ybWF0LiBUaGUgZm9ybWF0IGhhcyB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CgogIGEgRE5TLTExMjMgc3ViZG9tYWluIG11c3QgY29uc2lzdCBvZiBsb3dlciBjYXNlIGFscGhhbnVtZXJpYyBjaGFyYWN0ZXJzLCAnLScgb3IgJy4nLCBhbmQKICBtdXN0IHN0YXJ0IGFuZCBlbmQgd2l0aCBhbiBhbHBoYW51bWVyaWMgY2hhcmFjdGVyIChlLmcuICdleGFtcGxlLmNvbScsIHJlZ2V4IHVzZWQgZm9yCiAgdmFsaWRhdGlvbiBpcyAnW2EtejAtOV0oWy1hLXowLTldW2EtejAtOV0pPyguW2EtejAtOV0oWy1hLXowLTldW2EtejAtOV0pPykqJykuIEFuZCBzaG91bGQgYmUgbWF4aW11bSA2MyBjaGFyYWN0ZXJzIGxvbmcuCgpJZiB0aGUgaW5wdXQgaXMgbm90IG9mIHR5cGUgc3RyaW5nLCBpdCdzIHJldHVybmVkIGFzIGlzLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuYCAtIFRoZSBpbnB1dCB5b3Ugd2FudCB0byBwcm9jZXNzIGJ5IHRoaXMgZnVuY3Rpb24KCiMjIyMgUmV0dXJucwoKU3RyaW5nICgxOjEgcmV0dXJuIGlmIG5vdCBnaXZlbiBhcyBzdHJpbmcpCgojIyMjIFVzYWdlCgpgYGAKeyBpbmNsdWRlICJsaWIudXRpbHMuc3RyaW5ncy50b0RuczExMjMiICJteS1zdHJpbmciIH0KYGBgCgojIyBbTGlzdHNdKC4vdGVtcGxhdGVzL3V0aWxzL19saXN0cy50cGwpCgotLS0KCiMjIyBIYXNWYWx1ZUJ5S2V5CgpMb29wcyB0aHJvdWdoIHN1YmRpY3RzIGluIGEgZ2l2ZW4gbGlzdHMgY2hlY2tpbmcgdGhlIGdpdmVuIGtleSBmb3IgdGhlIGdpdmVuIHZhbHVlLiBpZiBtYXRjaGVkLCB0cnVlIGlzIHJldHVybmVkLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAubGlzdGAgLSBFeHBlY3RzIGEgbGlzdCB3aXRoIGRpY3Rpb25hcmllcyBhcyBlbGVtZW50cyAoUmVxdWlyZWQpCiAgKiBgLnZhbHVlYCAtIFRoZSB2YWx1ZSB5b3UgYXJlIGxvb2tpbmcgZm9yIGluIHRoZSBkaWN0cyAoUmVxdWlyZWQpCiAgKiBgLmtleWAgLSBEZWZpbmUgd2hpY2gga2V5IHRvIHF1ZXJ5IGZvciB0aGUgZ2l2ZW4gdmFsdWUgKERlZmF1bHRzIHRvICcubmFtZScpCgojIyMjIFJldHVybnMKCkJvb2xlYW4KCiMjIyMgVXNhZ2UKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMubGlzdHMuaGFzVmFsdWVCeUtleSIgKGRpY3QgImxpc3QiIChsaXN0IChkaWN0ICJuYW1lIiAiZmlyc3RJdGVtIiAidmFsdWUiICJzb21lVmFsdWUiKSAoZGljdCAibmFtZSIgInNlY29uZEl0ZW0iICJ2YWx1ZSIgInNvbWVWYWx1ZTIiKSkgInZhbHVlIiAic29tZVZhbHVlMiIgImtleSIgInZhbHVlIikgLX0KYGBgCgotLS0KCiMjIyBHZXRWYWx1ZUJ5S2V5CgpMb29wcyB0aHJvdWdoIHN1YmRpY3RzIGluIGEgZ2l2ZW4gbGlzdHMgY2hlY2tpbmcgdGhlIGdpdmVuIGtleSBmb3IgdGhlIGdpdmVuIHZhbHVlLiBpZiBtYXRjaGVkLCB0aGUgdmFsdWUgb2YgdGhlIGVudGlyZSBkaWN0IGlzIHJldHVybmVkLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAubGlzdGAgLSBFeHBlY3RzIGEgbGlzdCB3aXRoIGRpY3Rpb25hcmllcyBhcyBlbGVtZW50cyAoUmVxdWlyZWQpCiAgKiBgLnZhbHVlYCAtIFRoZSB2YWx1ZSB5b3UgYXJlIGxvb2tpbmcgZm9yIGluIHRoZSBkaWN0cyAoUmVxdWlyZWQpCiAgKiBgLmtleWAgLSBEZWZpbmUgd2hpY2gga2V5IHRvIHF1ZXJ5IGZvciB0aGUgZ2l2ZW4gdmFsdWUgKERlZmF1bHRzIHRvICcubmFtZScpCgojIyMjIFJldHVybnMKCllBTUwgU3RydWN0dXJlLCBTdHJpbmcKCiMjIyMgVXNhZ2UKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMubGlzdHMuZ2V0VmFsdWVCeUtleSIgKGRpY3QgImxpc3QiIChsaXN0IChkaWN0ICJuYW1lIiAiZmlyc3RJdGVtIiAidmFsdWUiICJzb21lVmFsdWUiKSAoZGljdCAibmFtZSIgInNlY29uZEl0ZW0iICJ2YWx1ZSIgInNvbWVWYWx1ZTIiKSkgInZhbHVlIiAic29tZVZhbHVlMiIgImtleSIgInZhbHVlIikgLX0KYGBgCgotLS0KCiMjIyBNZXJnZUxpc3QKCk1lcmdlIHR3byBsaXN0cyBpbnRvIG9uZSBhbmQgcmV0dXJucyB0aGUgbWVyZ2VkIHJlc3VsdC4KCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4KCiAgKiBgIC5gIC0gRXhwZWN0cyBhIGxpc3Qgd2l0aCB0d28gZWxlbWVudHMgKFJlcXVpcmVkKS4KCiMjIyMgUmV0dXJucwoKWUFNTCBTdHJ1Y3R1cmUsIFN0cmluZwoKIyMjIyBVc2FnZQoKYGBgCnstIGluY2x1ZGUgImxpYi51dGlscy5saXN0cy5tZXJnZUxpc3QiIChsaXN0ICRmaXJzdGxpc3QgJHNlY29uZGxpc3QpIC19CmBgYAoKLS0tCgojIyMgTWVyZ2VMaXN0T25LZXkKClRoZSBkZWZhdWx0IGJlaGF2aW9yIGZvciBtZXJnaW5nIGxpc3RzIGluIGFycmF5IGRvbid0IGFsbG93IGEgY29tYmluYXRpb24gb2YgdHdvIGVsZW1lbnRzIG9mIHRoZSBkaWZmZXJlbnQgbGlzdHMuCkVpdGhlciB5b3UgYXBwZW5kIHRoZSBsaXN0cyBvciBjb21wbGV0ZWx5IG92ZXJ3cml0ZSB0aGUgcHJldmlvdXMgbGlzdC4gV2l0aCB0aGlzIGZ1bmN0aW9uIHlvdSBjYW4gbWVyZ2UgbGlzdCBlbGVtZW50cwpiYXNlZCBvbiBhIHNpbmdsZSBrZXkgdmFsdWUgdG9nZXRoZXIuIE1lYW5pbmcgaWYgeW91IGhhdmUgYW4gZWxlbWVudCB3aXRoIHRoZSBzYW1lIG5hbWUgaW4gYm90aCBsaXN0cywgdGhlIGFyZSB0cmVhdGVkCmFzIHRoZSBzYW1lIGVsZW1lbnQgYW5kIG1lcmdlZCBzcGVjaWZpY2FsbHkgdG9nZXRoZXIuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5zb3VyY2VgIC0gQmFzZSBsaXN0IChSZXF1aXJlZCkuIElmIHVuZGVmaW5lZCwgdGVtcGxhdGUgd2lsbCByZXR1cm4gbm8gdmFsdWUuCiAgKiBgLnRhcmdldGAgLSBMaXN0IG1lcmdlZCBvdmVyIHNvdXJjZSBsaXN0IChSZXF1aXJlZCkuIElmIHVuZGVmaW5lZCwgdGVtcGxhdGUgd2lsbCByZXR1cm4gbm8gdmFsdWUuCiAgKiBgLmtleWAgLSBCYXNlZCBvbiB3aGljaCBLZXkgbGlzdCBlbGVtZW50cyBhcmUgbWVyZ2VkLiBJZiBub3Qgc2V0IGBuYW1lYCBpcyB1c2VkIGFzIGtleS4KICAqIGAucGFyZW50S2V5YCAtIFdoZW4gdHJ5aW5nIHRvIGxvYWQgdGhlIG1lcmdlZCBsaXN0IHlvdSBtaWdodCBlbmNvdW50ZXIgdGhpcyBlcnJvciBganNvbjogY2Fubm90IHVubWFyc2hhbCBhcnJheQogICAgaW50byBHbyB2YWx1ZSBvZiB0eXBlIG1hcFtzdHJpbmddaW50ZXJmYWNlIHt9YC4gVG8gYXZvaWQgdGhpcyBzZXQgYSBwYXJlbnQga2V5LCB3aGljaCB3aWxsIGluY2x1ZGUgdGhlIG1lcmdlZCBsaXN0LgoKIyMjIyBSZXR1cm5zCgpZQU1MIFN0cnVjdHVyZSwgU3RyaW5nCgojIyMjIFVzYWdlCgpgYGAKey0gaW5jbHVkZSAibGliLnV0aWxzLmxpc3RzLm1lcmdlTGlzdE9uS2V5IiAoZGljdCAic291cmNlIiAkLlZhbHVlcy5zb3VyY2VMaXN0ICJ0YXJnZXQiICQuVmFsdWVzLnRhcmdldExpc3QgImtleSIgImlkIikgLX0KYGBgCgotLS0KCiMjIyBFeGNlcHRpb25MaXN0CgpUaGlzIGZ1bmN0aW9uIGFsbG93cyBsaXN0IGJsYWNrbGlzdGluZy4gVGhpcyBtZWFucywgdGhhdCB5b3UgY2FuIGdpdmUgYW4gbGlzdCBvZiBleGNlcHRpb25zICgiYmxhY2tsaXN0IikgYXMgYXJndW1lbnQuIFRoZSB0ZW1wbGF0ZQppdGVyYXRlcyBvdmVyIGEgZ2l2ZW4gbGlzdCB3aXRoIGRpY3Rpb25hcnkgZWxlbWVudHMgYW5kIHJlbW92ZXMgZWxlbWVudHMsIHdoaWNoIG1hdGNoIG9uZSBvZiB0aGUgdmFsdWUgaW4gdGhlIGV4Y2VwdGlvbiBsaXN0LgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuZXhjZXB0aW9uc2AgLSBBIGxpc3Qgb3Igc3BhY2UgZGVsaW1pdGVkIHN0cmluZyB2YWx1ZXMsIHdoaWNoIGFyZSBleGNlcHRpb25zIChPcHRpb25hbCwgUmV0dXJucyBpbnB1dCBsaXN0IHdpdGhvdXQgbW9kaWZpY2F0aW9uKQogICogYC5saXN0YCAtIERhdGEgb2YgdHlwZSBzbGljZSAoT3B0aW9uYWwsIFJldHVybnMgRW1wdHkgU3RyaW5nKS4KICAqIGAua2V5YCAtIEtleSBjaGVja2VkIGZvciBleGNlcHRpb24gdmFsdWVzIChPcHRpb25hbCwgRGVmYXVsdHMgdG8gIm5hbWUiKQoKIyMjIyBSZXR1cm5zCgpZQU1MIFN0cnVjdHVyZSwgU3RyaW5nCgojIyMjIFVzYWdlOgoKYGBgCnsgaW5jbHVkZSAibGliLnV0aWxzLmxpc3RzLmV4Y2VwdGlvbkxpc3QiIChkaWN0ICJsaXN0IiAuVmFsdWVzLm15bGlzdCAiZXhjZXB0aW9ucyIgKGxpc3QgIkJMQUNLTElTVEVEX1ZBUiIgIlNIQVJFRF9IT01FIiAiQ0xVU1RFUkVEIiAiREFUQURJUiIpICJrZXkiICJzcGVjaWFsX2tleSIpIH0KCm9yCgp7IGluY2x1ZGUgImxpYi51dGlscy5saXN0cy5leGNlcHRpb25MaXN0IiAoZGljdCAibGlzdCIgLlZhbHVlcy5teWxpc3QgImV4Y2VwdGlvbnMiICJCTEFDS0xJU1RFRF9WQVIgU0hBUkVEX0hPTUUgREFUQURJUiIgImtleSIgInNwZWNpYWxfa2V5IikgfQpgYGAKCiMjIyMgRXhhbXBsZQoKR2l2ZW4gdGhpcyBJbnB1dCAoQ29udGFpbmVyIEVudmlyb25tZW50IFZhcmlhYmxlcyk6CgpgYGAKZW52aXJvbm1lbnQ6CiAgLSBuYW1lOiAiSE9NRSIKICAgIHZhbHVlOiAiL2hvbWUvZGlyZWN0b3J5IgogIC0gbmFtZTogIklNUE9SVEFOVF9DT05GSUdVUkFUSU9OIgogICAgdmFsdWU6ICJpbXBvcnRhbnQgdmFsdWUiCiAgLSBuYW1lOiAiUFJFU0VUX0NPTkZJR1VSQVRJT04iCiAgICB2YWx1ZTogImdlbmVyYXRlZCIKICAtIG5hbWU6ICJQUkVTRVRfSE9TVE5BTUUiCiAgICB2YWx1ZTogImdlbmVyYXRlZCIKYGBgCgpDYWxsaW5nIEV4Y2VwdGlvbiBsaXN0OgoKYGBgCnsgaW5jbHVkZSAibGliLnV0aWxzLmxpc3RzLmV4Y2VwdGlvbkxpc3QiIChkaWN0ICJsaXN0IiAkLlZhbHVlcy5lbnZpcm9ubWVudCAiZXhjZXB0aW9ucyIgIlBSRVNFVF9IT1NUTkFNRSBQUkVTRVRfQ09ORklHVVJBVElPTiIpIH0KCm9yCgp7IGluY2x1ZGUgImxpYi51dGlscy5saXN0cy5leGNlcHRpb25MaXN0IiAoZGljdCAibGlzdCIgJC5WYWx1ZXMuZW52aXJvbm1lbnQgImV4Y2VwdGlvbnMiIChsaXN0ICJQUkVTRVRfSE9TVE5BTUUiICJQUkVTRVRfQ09ORklHVVJBVElPTiIpKSB9CgpgYGAKClJlc3VsdHMgaW46CgpgYGAKLSBuYW1lOiBIT01FCiAgdmFsdWU6IC9ob21lL2RpcmVjdG9yeQotIG5hbWU6IElNUE9SVEFOVF9DT05GSUdVUkFUSU9OCiAgdmFsdWU6IGltcG9ydGFudCB2YWx1ZQpgYGAKCiMjIFtEaWN0aW9uYXJpZXNdKC4vdGVtcGxhdGVzL3V0aWxzL19kaWN0cy50cGwpCgotLS0KCiMjIyBQYXJlbnRBcHBlbmQKClRoaXMgZnVuY3Rpb24gYWxsb3dzIHRvIGFwcGVuZCBhIGdpdmVuIGludGVyZmFjZS1tYXAgdG8gYSBuZXcgcGFyZW50IGtleSBhbmQgcmV0dXJucyB0aGUgcmVzdWx0aW5nIFlBTUwgc3RydWN0dXJlLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAua2V5YCAtIFRoZSBuZXcgcGFyZW50IGtleSBmb3IgdGhlIGdpdmVuIGtleSBzdHJ1Y3R1cmUgKE9wdGlvbmFsLCBEZWZhdWx0cyB0byBgVmFsdWVzYCBrZXkpCiAgKiBgLmFwcGVuZGAgLSBLZXkgc3RydWN0dXJlIHlvdSB3YW50IHRvIGFwcGVuZCAoT3B0aW9uYWwsIERlZmF1bHRzIHRvIGZ1bmN0aW9uIFJvb3QgQ29udGV4dCkKCiMjIyMgUmV0dXJucwoKWUFNTCBTdHJ1Y3R1cmUsIFN0cmluZwoKIyMjIyBVc2FnZToKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuZGljdHMucGFyZW50QXBwZW5kIiAoZGljdCAia2V5IiAicGFyZW50IiAiYXBwZW5kIiAkLlZhbHVlcykgfQoKb3IKCnstIGluY2x1ZGUgImxpYi51dGlscy5kaWN0cy5wYXJlbnRBcHBlbmQiICAkLlZhbHVlcyB9CmBgYAoKLS0tCgojIyMgUHJpbnRZYW1sU3RydWN0dXJlCgpUaGlzIGZ1bmN0aW9uIGFsbG93cyB0byBhcHBlbmQgYSBnaXZlbiBzdHJ1Y3QgdG8gYSBuZXcgcGFyZW50IGtleSBhbmQgcmV0dXJucyB0aGUgcmVzdWx0aW5nIFlBTUwgc3RydWN0dXJlLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuc3RydWN0dXJlYCAtIEVudGVyIHRoZSBzdHJ1Y3R1cmUgc2VwZXJhdGVkIGJ5ICcuJyAoUmVxdWlyZWQpCiAgICAgIEUuZy4gdGhlIGlucHV0IG9mICJWYWx1ZXMuc3ViLmtleSIgd2lsbCByZXN1bHQgaW4gdGhlIG91dHB1dCBvZjoKICAgICAgICBWYWx1ZXM6CiAgICAgICAgICBzdWI6CiAgICAgICAgICAgIGtleToKCiAgKiBgLmRhdGFgIC0gRGF0YSB3aGljaCB3aWxsIGJlIGluc2VydGVkIGJlbG93IHRoZSBzdHJ1Y3R1cmUgKE9wdGlvbmFsKQoKIyMjIyBSZXR1cm5zCgogIFN0cmluZwoKIyMjIyBVc2FnZToKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuZGljdHMucHJpbnRZQU1MU3RydWN0dXJlIiAoZGljdCAic3RydWN0dXJlIiAkcGF0aCAiZGF0YSIgIm15LnN0cnVjdHVyZS5oZXJlIikgfQpgYGAKCldpbGwgcmVzdWx0IGluCgpgYGAKbXk6CiAgc3RydWN0dXJlOgogICAgaGVyZToKICAgICAgey5kYXRhfQpgYGAKCi0tLQoKIyMjIExvb2t1cAoKR2V0IGEgc3BlY2lmaWMga2V5IGJ5IGRlbGl2ZXJpbmcgdGhlIGtleSBwYXRoIGZyb20gYSBnaXZlbiBkaWN0aW9uYXJ5LgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAucGF0aGAgLSBUaGUga2V5IHBhdGgKICAqIGAucmVxdWlyZWRgIC0gSWYgc2V0IHRvIHRydWUsIGFuZCB0aGUga2V5IHBhdGggdmFsdWUgaXMgbm90IGZvdW5kIG9yIGVtcHR5LCB0aGUgdGVtcGxhdGUgd2lsbCBmYWlsIChPcHRpb25hbCkKICAqIGAuZGF0YWAgLSBUaGUgZGljdGlvbmFyeSB0byBsb29rdXAKCiMjIyMgUmV0dXJucwoKICBEaWN0aW9uYXJ5IChXaXRoIGtleSBgLnJlc3VsdGAgaW4gY2FzZSB0aGUga2V5IHJlc29sdmVzIHRvIGEgbGlzdCkKCiMjIyMgVXNhZ2U6CgpgYGAKey0gaW5jbHVkZSAibGliLnV0aWxzLmRpY3RzLmxvb2t1cCIgKGRpY3QgInBhdGgiICJzdWIua2V5IiAiZGF0YSIgKGRpY3QgInN1YiIgKGRpY3QgImtleSIgKGxpc3QgIkEiICJCIiAiQyIpKSkpIH0KYGBgCgpXaWxsIHJlc3VsdCBpbgoKYGBgCnJlc3VsdDoKICAtIEEKICAtIEIKICAtIEMKYGBgCgotLS0KCiMjIyBVbnNldAoKVW5zZXQgYSBrZXkgYnkgcGF0aCBpbiBhIGRpY3Rpb25hcnkKCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4KCiAgKiBgLnBhdGhgIC0gVGhlIGtleSBwYXRoCiAgKiBgLmRhdGFgIC0gVGhlIGRpY3Rpb25hcnkgdG8gbG9va3VwCgojIyMjIFJldHVybnMKCkRpcmVjdGx5IHJlbW92ZXMga2V5IG9uIGRpY3Rpb25hcnksIG5vIHJldHVybgoKIyMjIyBVc2FnZToKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuZGljdHMudW5zZXQiIChkaWN0ICJwYXRoIiAic3ViLmtleSIgImRhdGEiIChkaWN0ICJzdWIiIChkaWN0ICJrZXkiIChsaXN0ICJBIiAiQiIgIkMiKSkpKSB9CmBgYAoKLS0tCgojIyMgU2V0CgpTZXQgYSBrZXkgYW5kIGl0J3MgdmFsdWUgYnkgcGF0aCBpbiBhIGRpY3Rpb25hcnkuIFRoZSBlbnRpcmUgcGF0aCBpcyBjcmVhdGVkLCBtZWFuaW5nIHN1YnBhdGhzIGRvbid0IGhhdmUgdG8gZXhpc3QgdG8gYXNzaWduIGEgdmFsdWUuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5wYXRoYCAtIFRoZSBrZXkgcGF0aAogICogYC52YWx1ZWAgLSBUaGUgdmFsdWUgdG8gc2V0CiAgKiBgLmRhdGFgIC0gVGhlIGRpY3Rpb25hcnkgdG8gbG9va3VwCgojIyMjIFJldHVybnMKCkRpcmVjdGx5IHJlbW92ZXMga2V5IG9uIGRpY3Rpb25hcnksIG5vIHJldHVybgoKIyMjIyBVc2FnZToKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuZGljdHMuc2V0IiAoZGljdCAicGF0aCIgIm5ldy5zdWIua2V5IiAidmFsdWUiIChkaWN0ICJzb21ldGhpbmciICJuZXciKSAiZGF0YSIgKGRpY3QgInN1YiIgKGRpY3QgImtleSIgKGxpc3QgIkEiICJCIiAiQyIpKSkpIH0KYGBgCgpXaWxsIHJlc3VsdCBpbjoKCmBgYApuZXc6CiAgc3ViOgogICAga2V5OgogICAgICBzb21ldGhpbmc6IG5ldwpzdWI6CiAga2V5OgogICAgLSBBCiAgICAtIEIKICAgIC0gQwpgYGAKCiMjIFtFeHRyYXNdKC4vdGVtcGxhdGVzL3V0aWxzL19leHRyYXMudHBsKQoKLS0tCgojIyMgRW52aXJvbm1lbnQKClJldHVybnMgdXNlZnVsIGVudmlyb25tZW50IHZhcmlhYmxlcyBiZWluZyB1c2VkIGZvciBjb250YWluZXIuIEluIGFkZGl0aW9uIGFkZHMgYnVpbHQtaW4gcHJveHkgc3VwcG9ydCB0byB5b3VyIGNoYXJ0LgpNZWFuaW5nIHByb3h5IHdpbGwgYmUgc2V0IGRpcmVjdGx5IGluIGVudmlyb25tZW50IHZhcmlhYmxlcyByZXR1cm5lZCBieSB0aGUgdGVtcGxhdGUuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5gIC0gSW5oZXJpdGVkIFJvb3QgQ29udGV4dCAoUmVxdWlyZWQpCgojIyMjIFN0cnVjdHVyZQoKVGhpcyB0ZW1wbGF0ZSBzdXBwb3J0cyB0aGUgZm9sbG93aW5nIGtleSBzdHJ1Y3R1cmU6CgogICogW1Byb3h5IFZhbHVlc10oLi90ZW1wbGF0ZXMvdmFsdWVzL2V4dHJhcy9fcHJveHkueWFtbCkKCiMjIyMgUmV0dXJucwoKWUFNTCBTdHJ1Y3R1cmUsIFN0cmluZwoKVXNhZ2U6CgpgYGAKZW52OiB7LSBpbmNsdWRlICJsaWIudXRpbHMuZXh0cmFzLmVudmlyb25tZW50IiAkIHwgbmluZGVudCAyIH0KYGBgCgotLS0KCiMjIyBFeHRyYVJlc291cmNlcwoKQWxsb3dzIHRvIGhhdmUgZXh0cmEgcmVzb3VyY2VzIGluIHRoZSBjaGFydC4gUmV0dXJucyBraW5kIExpc3Qgd2l0aCBhbGwgZ2l2ZW4ga3ViZXJuZXRlcyBleHRyYSByZXNvdXJjZXMuCgojIyMjIEFyZ3VtZW50cwoKSWYgYW4gYXMgcmVxdWlyZWQgbWFya2VkIGFyZ3VtZW50IGlzIG1pc3NpbmcsIHRoZSB0ZW1wbGF0ZSBlbmdpbmUgd2lsbCBmYWlsIGludGVudGlvbmFsbHkuCgogICogYC5gIC0gSW5oZXJpdGVkIFJvb3QgQ29udGV4dCAoUmVxdWlyZWQpCgojIyMjIEtleXMKClRoaXMgZnVuY3Rpb24gZW5hYmxlcyB0aGUgZm9sbG93aW5nIGtleXM6CgpgYGAKIyMgUmF3IEt1YmVybmV0ZXMgcmVzb3VyY2VzCiMgZXh0cmFSZXNvdXJjZXMgLS0KZXh0cmFSZXNvdXJjZXM6IFtdCiMKIyAtIGtpbmQ6IENvbmZpZ01hcAojICAgYXBpVmVyc2lvbjogdjEKIyAgIG1ldGFkYXRhOgojICAgICBuYW1lOiBleGFtcGxlLWNvbmZpZ21hcAojICAgZGF0YToKIyAgICAgZGF0YWJhc2U6IG1vbmdvZGIKIyAgICAgZGF0YWJhc2VfdXJpOiBtb25nb2RiOi8vbG9jYWxob3N0OjI3MDE3CiMKYGBgCgojIyMjIFJldHVybnMKCllBTUwgU3RydWN0dXJlLCBTdHJpbmcKClVzYWdlOgoKYGBgCmVudjogey0gaW5jbHVkZSAibGliLnV0aWxzLmV4dHJhcy5yZXNvdXJjZXMiICQgfCBuaW5kZW50IDIgfQpgYGAKCiMjIFtFcnJvcnNdKC4vdGVtcGxhdGVzL3V0aWxzL19lcnJvcnMudHBsKQoKLS0tCgojIyMgRmFpbAoKRXhlY3V0ZXMgYSBmYWlsIGJ1dCBhZGRzIHR3byBuZXcgbGluZXMgdG8gbWFrZSB0aGUgZXJyb3IgbW9yZSB2aXNpYmxlLgoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LgoKICAqIGAuYCAtICBFcnJvciBNZXNzYWdlCgojIyMjIFJldHVybnMKCkhlbG0gRmFpbAoKIyMjIyBVc2FnZToKCmBgYAp7LSBpbmNsdWRlICJsaWIudXRpbHMuZXJyb3JzLmZhaWwiIChwcmludGYgIk15IEN1c3RvbSBFcnJvciIpIH0KYGBgCgojIyMgdW5tYXJzaGFsaW5nRXJyb3IKLS0tCgpFdmFsdWF0ZXMgYSBkaWN0aW9uYXJ5IHdoaWNoIHdhcyBwYXJzZWQgZnJvbSBZQU1sIGlmIGl0IGhhcyBhbiBFcnJvciBmaWVsZC4KCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4gUmV0dXJucyBUcnVlIGlmIHRoYXQncyB0aGUgY2FzZS4KCiAgKiBgLmAgLSAgRGF0YQoKIyMjIyBSZXR1cm5zCgpCb29sCgojIyMjIFVzYWdlOgoKYGBgCnstIGlmIG5vdCAoaW5jbHVkZSAibGliLnV0aWxzLmVycm9ycy51bm1hcnNoYWxpbmdFcnJvciIgKGZyb21ZYW1sIChpbmNsdWRlICJteS5kYXRhIiAkKSkpIH0KTm8gRXJyb3IhCnstIGVsc2UgLX0KRXJyb3I6IChmcm9tWWFtbCAoaW5jbHVkZSAibXkuZGF0YSIgJCkpLkVycm9yCnstIGVuZCAtfQpgYGAKCi0tLQoKIyMjIFBhcmFtcwoKUHJpbnRzIGFuIGVycm9yIHRoYXQgYSB0ZW1wbGF0ZSBpcyBtaXNzaW5nIHBhcmFtZXRlcnMKCiMjIyMgQXJndW1lbnRzCgpJZiBhbiBhcyByZXF1aXJlZCBtYXJrZWQgYXJndW1lbnQgaXMgbWlzc2luZywgdGhlIHRlbXBsYXRlIGVuZ2luZSB3aWxsIGZhaWwgaW50ZW50aW9uYWxseS4gUmV0dXJucyBUcnVlIGlmIHRoYXQncyB0aGUgY2FzZS4KCiAgKiBgLnRwbGAgLSAgVGVtcGxhdGUgTmFtZQogICogYC5wYXJhbXNgIC0gIFBhcmFtZXRlciBMaXN0CgojIyMjIFJldHVybnMKCkhlbG0gRmFpbAoKIyMjIyBVc2FnZToKCmBgYAp7LSBpZiBhbmQgJC5kYXRhICQuY3R4fQpEbyBTdHVmZgp7LSBlbHNlIC19CiAgey0gaW5jbHVkZSAibGliLnV0aWxzLmVycm9ycy5wYXJhbXMiIChkaWN0ICJ0cGwiICJteS50cGwiICJwYXJhbXMiIChsaXN0ICJkYXRhIiAiY3R4IikgfQp7LSBlbmQgLX0KYGBgCgojIFtUeXBlc10oLi90ZW1wbGF0ZXMvdXRpbHMvX3R5cGVzLnRwbCkKCi0tLQoKIyMjIFZhbGlkYXRlCgpWYWxpZGF0ZSBUeXBlcyBhZ2FpbnN0IGRhdGEuIEl0J3MgYSBzaW1wbGUgYWJzdHJhY3Rpb24gb2YganNvbiBzY2hlbWEgZm9yIGdvIHNwcmlnLgoKIyMjIyBUeXBlCgpUaGlzIGlzIHdoYXQgYSB0eXBlIGRlY2xhcnRpb24gY291bGQgbG9vayBsaWtlOgoKYGBgCnstIGRlZmluZSAibXkudHlwZSIgLX0KCiMgRmllbGQgQ29uZmlnLCBtYXRjaGVzIHRoZSBmaWVsZCBuYW1lICdmaWVsZC0yJy4gVGhlIGZvbGxvd2luZyBwcm9wZXJ0aWVzIGFyZSBzdXBwb3J0ZWQ6MjIKZmllbGQtMjoKCiAgIyBEZWNsYXJlZCAnZmllbGQtMicgYXMgUmVxdWlyZWQKICByZXF1aXJlZDogdHJ1ZQoKICAjIEFsbG93ZWQgdHlwZXMgZm9yIHRoZSBjb250ZW50IG9mICdmaWVsZC0yJwogIHR5cGVzOiBbICJzdHJpbmciLCAic2xpY2UiIF0KCiAgIyBEZWZhdWx0IFZhbHVlIGlmIHRoZSBmaWVsZCBkb2VzIG5vdCBoYXZlIGEgdmFsdWUKICBkZWZhdWx0OiAiZGVmYXVsdC12YWx1ZSIKCiAgIyBBbGxvd2VkIFZhbHVlcyBmb3IgdGhlIGZpZWxkcyB2YWx1ZQogIHZhbHVlczogWyAiZGV2IiwgInByb2QiIF0KCiMgRmllbGQgd2l0aCBqdXN0IHR5cGUKZmllbGQtMzoKICB0eXBlczogWyAibWFwIiBdCgojIEZpZWxkIHdpdGgganVzdCBkZWZhdWx0CmZpZWxkLTM6CiAgZGVmYXVsdDogImVhc3QiCgojIEZvciBuZXN0ZWQgZGljdGlvbmFyaWVzIHlvdSBuZWVkIHRvIHVzZSB0aGUgX3Byb3BzIGtleXdvcmQuIElmIGEgZmllbGQgaGFzIHRoZSBfcHJvcHMga2V5d29yZAojIGFzIGtleSwgZXZlcnl0aGluZyBiZWxvdyB0aGF0IGZpZWxkIGlzIHRyZWF0ZWQgYXMgbmVzdGVkIHJlY3Vyc2lvbgpmaWVsZC00OgogIF9wcm9wczoKICAgIGZpZWxkLTQtc3ViLTE6CiAgICAgIHR5cGVzOiBbICJzdHJpbmciIF0KICAgICAgcmVxdWlyZWQ6IHRydWUKICAgIGZpZWxkLTQtc3ViLTI6CiAgICAgIF9wcm9wczoKICAgICAgICBmaWVsZC00LXN1Yi0yLXN1Yi0xOgogICAgICAgICAgdHlwZXM6IFsgImJvb2xlYW4iIF0Key0gZW5kIC19CmBgYAoKIyMjIyBBcmd1bWVudHMKCklmIGFuIGFzIHJlcXVpcmVkIG1hcmtlZCBhcmd1bWVudCBpcyBtaXNzaW5nLCB0aGUgdGVtcGxhdGUgZW5naW5lIHdpbGwgZmFpbCBpbnRlbnRpb25hbGx5LiBSZXR1cm5zIFRydWUgaWYgdGhhdCdzIHRoZSBjYXNlLgoKICAqIGAudHlwZWAgLSAgVGVtcGxhdGUgTmFtZSBvZiBUeXBlCiAgKiBgLmRhdGFgIC0gQ2hlY2sgVHlwZSBhZ2FpbnN0IHRoZSBnaXZlbiBkYXRhCiAgKiBgLnZhbGlkYXRlYCAtIE9ubHkgdmFsaWRhdGUsIGRvbid0IGFzc2lnbiBkZWZhdWx0IHZhbHVlcwogICogYC5wcm9wZXJ0aWVzYCAtIERpcmVjdGx5IGFzc2lnbiB0eXBlIHByb3BlcnRpZXMgaW5zdGVhZCBvZiB1c2luZyBhIHRlbXBsYXRlCiAgKiBgLmN0eGAgLSAgR2xvYmFsIENvbnRleHQKCiMjIyMgUmV0dXJucwoKICAqIGAuaXNUeXBlYCAtICBJZiBnaXZlbiBkYXRhIGlzIHR5cGUKICAqIGAuZXJyb3JzYCAtICBFcnJvcnMKCiMjIyMgVXNhZ2U6CgpgYGAKey0gJHZhbGlkYXRlIDo9IGZyb21ZYW1sIChpbmNsdWRlICJsaWIudXRpbHMudHlwZXMudmFsaWRhdGUiIChkaWN0ICJ0eXBlIiAibXkudHlwZSIgImRhdGEiIHNvbWUuZGF0YSAiY3R4IiAkKSkgLX0Key0gaWYgJHZhbGlkYXRlLmlzVHlwZSAtfQogIFZhbGlkCnstIGVuZCAtfQpgYGA=
                  unit_tests/dict_test.yaml: c3VpdGU6IGxpYnJhcnkvZGljdGlvbmFyaWVzIHVuaXQgdGVzdHMKdGVtcGxhdGVzOgogIC0gdW5pdF90ZXN0LnlhbWwKdGVzdHM6CiAgLSBpdDogbWFuaWZlc3Qgc25hcHNob3QKICAgIGFzc2VydHM6CiAgICAgIC0gbWF0Y2hTbmFwc2hvdDoge30KICAtIGl0OiBzdW1tYXJ5IHNuYXBzaG90CiAgICBzZXQ6CiAgICAgIHVuaXRfdGVzdDogdHJ1ZQogICAgICBzdW1tYXJ5OiB0cnVlCiAgICBhc3NlcnRzOgogICAgICAtIG1hdGNoU25hcHNob3Q6IHt9CgoKICAjIyBDaGVjayBEaWN0aW9uYXJ5IEZ1bmN0aW9ucwoKICAtIGl0OiAiW0RpY3RzXTogTWVyZ2UgT3BlcmF0aW9uIgogICAgc2V0OgogICAgICB1bml0X3Rlc3Q6IAogICAgICAgIHJ1bjogdHJ1ZQogICAgICAgIHR5cGU6ICJkaWN0Lm1lcmdlIgogICAgICBCYXNlOgogICAgICAgIHNwZWM6CiAgICAgICAgICBzZWxlY3RvcjoKICAgICAgICAgICAgYXBwOiBuZ2lueAogICAgICAgICAgcG9ydHM6CiAgICAgICAgICAtIHBvcnQ6IDgwCiAgICAgICAgICAgIG5hbWU6IGh0dHAKICAgICAgICAgICAgdGFyZ2V0UG9ydDogODAKICAgICAgICAgIC0gcG9ydDogNDQzCiAgICAgICAgICAgIG5hbWU6IGh0dHBzCiAgICAgICAgICAgIHRhcmdldFBvcnQ6IDgwCiAgICAgIERhdGE6CiAgICAgICAgc3BlYzoKICAgICAgICAgIHBvcnRzOgogICAgICAgICAgLSBfX2luamVjdF9fCiAgICAgICAgICAtIHBvcnQ6IDg0NDMKICAgICAgICAgICAgbmFtZTogaHR0cHMKICAgICAgICAgIC0gcG9ydDogOTAwMQogICAgICAgICAgICBuYW1lOiBtZXRyaWNzCiAgICAgICAgICAgIHRhcmdldFBvcnQ6IDkwMDEKICAgICAgCiAgICBhc3NlcnRzOgogICAgICAtIG1hdGNoU25hcHNob3Q6IHt9
                Release:
                  IsInstall: true
                  IsUpgrade: false
                  Name: release-name
                  Namespace: default
                  Revision: 1
                  Service: Helm
                Subcharts: {}
                Values:
                  global: {}
            Values:
              benchmark: false
              debug: false
              force: true
              global: {}
              helmize: {}
              helmize_file: ""
              library:
                global: {}
              show_config: false
              summary: false
        Template:
          BasePath: example-customization/templates
          Name: example-customization/templates/deploy.yaml
        Value: {}
        Values:
          contextRenderer: true
          debug: true
          helmize:
            benchmark: false
            debug: false
            force: true
            global: {}
            helmize: {}
            helmize_file: ""
            library:
              global: {}
            show_config: false
            summary: false
          summary: true
      inv: {}

```


