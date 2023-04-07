# declare initial provider        
terraform {
  backend "gcs" {
    bucket = "play-grafana-tf-config"
  }
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.36.1"
    }
  }
}

variable "grafana-token" {}
variable "grafana-url" {}

provider "grafana" {
  alias = "play"

  url   = "${var.grafana-url}"
  auth  = "${var.grafana-token}"
}