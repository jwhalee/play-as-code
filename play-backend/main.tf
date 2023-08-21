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

# Retrieve GKE cluster information
provider "google" {
  project = "raintank-dev"
  region  = "us-central1"
}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
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

module "elasticstack" {
  source          = "./elasticstack"
  namespace-prod  = var.namespace-prod
  elastic_version = var.elastic_version
}

# module "grafana" {
#   source          = "./grafana"
#   namespace       = var.namespace
#   play_dev_ip     = var.play_dev_ip
#   grafana_version = var.grafana_version
# }

module "influxdb" {
  source           = "./influxdb"
  namespace-prod   = var.namespace-prod
  influxdb_version = var.influxdb_version
}

module "mysql" {
  source         = "./mysql"
  cluster_ip     = var.cluster_ip
  namespace-prod = var.namespace-prod
  mysql_version  = var.mysql_version
}

module "redis" {
  source         = "./redis"
  cluster_ip     = var.cluster_ip
  namespace-prod = var.namespace-prod
  redis_version  = var.redis_version
}

module "clickhouse" {
  source             = "./clickhouse"
  namespace-prod     = var.namespace-prod
  clickhouse_version = var.clickhouse_version
}

module "opentsdb" {
  source         = "./opentsdb"
  namespace-prod = var.namespace-prod
}

module "postgres" {
  source           = "./postgres"
  cluster_ip       = var.cluster_ip
  namespace-prod   = var.namespace-prod
  postgres_version = var.postgres_version
}

module "k6-http" {
  source         = "./k6-http"
  namespace-prod = var.namespace-prod
}

module "k6-bin" {
  source         = "./k6-php"
  namespace-prod = var.namespace-prod
}