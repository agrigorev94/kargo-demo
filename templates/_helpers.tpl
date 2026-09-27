{{/*
Render a Pod for one component.
Usage: {{ include "console.pod" (dict "name" "protostar" "root" $) }}
*/}}
{{- define "console.pod" -}}
{{- $c := index .root.Values .name -}}
apiVersion: v1
kind: Pod
metadata:
  name: {{ .name }}
  labels:
    app.kubernetes.io/name: {{ .name }}
    app.kubernetes.io/instance: {{ .root.Release.Name }}
    app.kubernetes.io/part-of: {{ .root.Chart.Name }}
    app.kubernetes.io/managed-by: {{ .root.Release.Service }}
    helm.sh/chart: {{ printf "%s-%s" .root.Chart.Name .root.Chart.Version }}
spec:
  containers:
    - name: {{ .name }}
      image: "{{ $c.image.registry }}/{{ $c.image.repository }}:{{ $c.image.tag }}"
      ports:
        - name: http
          containerPort: 80
{{- end -}}
