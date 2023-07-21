# declare initial provider        
terraform {
  backend "gcs" {
    bucket = "play-frontend-tf-config"
  }
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.36.1"
    }
  }
}

provider "grafana" {
  alias = "play"

  url   = "${var.grafana-url}"
  auth  = "${var.grafana-token}"
}
