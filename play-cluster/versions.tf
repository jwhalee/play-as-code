# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  backend "gcs" {
    bucket = "play-cluster-tf-config"
  }  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }

  required_version = ">= 0.14"
}

data "google_client_config" "default" {}
data "google_container_cluster" "play_grafana" {
  name     = "raintank-dev-play-grafana-gke"
  location = "us-central1"
}
provider "kubernetes" {
  host                   = "https://34.135.210.219"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.play_grafana.master_auth[0].cluster_ca_certificate)
}

