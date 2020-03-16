{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kubernetes.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubernetes.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubernetes.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the service name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "serviceName" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get the nearest flavor name for the EnterCloudSuite provider.
*/}}
{{- define "ecsFlavor" -}}
{{- $flavors := dict "1-1" "x2" "1-2" "x3" "2-2" "x3" "2-4" "x4" "4-4" "x5" "4-8" "x5" "8-16" "x6" -}}
{{- $key := (printf "%g-%g" .vcpu .ram) -}}
{{- printf "%s.%s" "e3standard" (index $flavors $key)}}
{{- end -}}

{{/*
Get the service internal version.
We add a suffix to the given version.
*/}}
{{- define "serviceVersion" -}}
{{- $versions := dict "1.15.3" "19-a56839a3" "1.14.3" "505" -}}
{{- printf "%s-%s" . (index $versions .)}}
{{- end -}}
