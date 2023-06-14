# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-play-grafana-gke"
  location = var.region
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-highmem-2"
    tags         = ["gke-node", "${var.project_id}-play-grafana-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

resource "google_compute_address" "cluster_ip" {
  name   = "cluster-ip"
  region = "us-central1"
}

resource "google_compute_address" "play_influx_ip" {
  name   = "play-influx-ip"
  region = "us-central1"
}

resource "google_compute_address" "play_opentsdb_ip" {
  name   = "play-opentsdb-ip"
  region = "us-central1"
}

resource "google_compute_address" "play_dev_ip" {
  name   = "play-dev-ip"
  region = "us-central1"
}

resource "google_compute_address" "play_elastic_ip" {
  name   = "play-elastic-ip"
  region = "us-central1"
}

resource "google_compute_address" "play_kibana_ip" {
  name   = "play-kibana-ip"
  region = "us-central1"
}

# # Copyright (c) HashiCorp, Inc.
# # SPDX-License-Identifier: MPL-2.0

# terraform {
#   backend "gcs" {
#     bucket = "play-cluster-tf-config"
#   }  
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "4.27.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.0.1"
#     }
#   }

#   required_version = ">= 0.14"
# }

# data "google_client_config" "default" {}
# data "google_container_cluster" "play_grafana" {
#   name     = "raintank-dev-play-grafana-gke"
#   location = "us-central1"
# }
# provider "kubernetes" {
#   host                   = "https://34.135.210.219"
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = base64decode(data.google_container_cluster.play_grafana.master_auth[0].cluster_ca_certificate)
# }

