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

variable "grafana-token" {}
variable "grafana-url" {}

provider "grafana" {
  alias = "play"

  url   = "${var.grafana-url}"
  auth  = "${var.grafana-token}"
}

# # provision folder
# resource "grafana_folder" "play-grafana" {
#   provider = grafana.play
#   uid   = "play-grafana"
#   title = "play-grafana"
# }

# output "play_folder" {
#   value = resource.grafana_folder.play-grafana
# }