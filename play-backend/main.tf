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
    # elasticstack = {
    #   source  = "elastic/elasticstack"
    #   version = "~> 0.5.0"
    # }
  }
}

# Retrieve GKE cluster information
provider "google" {
  project    = "raintank-dev"
  region     = "us-central1"
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
  source                   = "./elasticstack"
  namespace                = var.namespace
  play_elastic_ip          = var.play_elastic_ip
  play_kibana_ip           = var.play_kibana_ip
  play_elastic_domain_name = var.play_elastic_domain_name
  elastic_version          = var.elastic_version
}

module "grafana" {
  source          = "./grafana"
  namespace       = var.namespace
  play_dev_ip     = var.play_dev_ip
  grafana_version = var.grafana_version
}

module "influxdb" {
  source           = "./influxdb"
  namespace        = var.namespace
  play_influx_ip   = var.play_influx_ip
  influxdb_version = var.influxdb_version
}

module "telegraf" {
  source           = "./telegraf"
  namespace        = var.namespace
  telegraf_version = var.telegraf_version
}

module "mysql" {
  source        = "./mysql"
  cluster_ip    = var.cluster_ip
  namespace     = var.namespace
  mysql_version = var.mysql_version
}

module "redis" {
  source        = "./redis"
  cluster_ip    = var.cluster_ip
  namespace     = var.namespace
  redis_version = var.redis_version
}

# THIS ONE CRASHES ON STARTUP RN
# module "pyroscope" {
#   source = "./pyroscope"
#   cluster_ip = var.cluster_ip
#   namespace = var.namespace
# }

# module "clickhouse" {
#   source = "./clickhouse"
#   cluster_ip = var.cluster_ip
#   namespace = var.namespace
# }

module "opentsdb" {
  source    = "./opentsdb"
  namespace = var.namespace
  ip        = var.play_opentsdb_ip
}

module "phlare" {
  source         = "./phlare"
  cluster_ip     = var.cluster_ip
  namespace      = var.namespace
  phlare_version = var.phlare_version
}

# module "postgres" {
#   source = "./postgres"
#   cluster_ip = var.cluster_ip
#   namespace = var.namespace
# }

# module "nginx" {
#   source = "./nginx"
#   cluster_ip = var.cluster_ip
#   namespace = var.namespace
# }