apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: frontend
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  {{- with $.data.ingress_class }}
  ingressClassName: {{ . }}
  {{- end }}
  tls:
  - hosts:
      - {{ $.data.ingress_name }}
    secretName: frontend-tls
  rules:
  - http:
      paths:
      - host: {{ $.data.ingress_name }}
        path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80