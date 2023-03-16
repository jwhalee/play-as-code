# declare initial provider        
terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.36.1"
    }
  }
}
provider "grafana" {
  alias = "play"

  url   = "https://play.grafana.org"
  auth  = "eyJrIjoiUDBMTHdMMGhwNzNrN2pLTGxiZmpsQVRyWWtCRVRlVUgiLCJuIjoicGxheS1hcy1jb2RlIiwiaWQiOjF9"
}