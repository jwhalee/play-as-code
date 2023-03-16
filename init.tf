# declare initial provider        
terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.36.1"
    }
  }
}

variable "token" {}

provider "grafana" {
  alias = "play"

  url   = "https://play.grafana.org"
  auth  = "${var.token}"
}