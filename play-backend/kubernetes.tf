terraform {
  backend "gcs" {
    bucket = "play-backend-tf-config"
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
}

# data "terraform_remote_state" "gke" {
#   backend = "local"

#   config = {
#     path = "../learn-terraform-provision-gke-cluster/terraform.tfstate"
#   }
# }

# Retrieve GKE cluster information
provider "google" {
  project    = "raintank-dev"
  region     = "us-central1"
}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {}

data "google_container_cluster" "my_cluster" {
  name     = "raintank-dev-play-grafana-gke"
  location = "us-central1"
}

provider "kubernetes" {
  host                   = "https://34.135.210.219"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate)
}
