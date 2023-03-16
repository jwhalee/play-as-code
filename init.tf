###############################################
##                                           ##
## STEP 1: declare initial provider          ##
##                                           ## 
###############################################

terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.36.1"
    }
  }
}

# Declaring the primary provider to be only used for creating the cloud-stack
provider "grafana" {
  alias         = "primary"

  cloud_api_key = "eyJrIjoiYjM4MTZiZjM5M2FhMjhjZWNmNDUxMGU1MzM4NGNmYTEyOTQwNjVjNyIsIm4iOiJVWFJFU0VBUkNIIiwiaWQiOjUwMDB9" 
}

####################################################################
##                                                                ##
## STEP 2: create stack, Grafana API key, and set second provider ##
##                                                                ## 
####################################################################

# Creating an API key in Grafana instance to be used for creating resources in Grafana instance
# resource "grafana_cloud_stack_api_key" "play" {
#   provider = grafana.primary

#   stack_slug = grafana_cloud_stack.play.slug
#   name       = grafana_cloud_stack.play.name
#   role       = "Admin" 
# }

# Declaring the second provider to be used for creating resources in Grafana        
provider "grafana" {
  alias = "play"

  url   = "https://play.grafana.org"
  auth  = "eyJrIjoiUDBMTHdMMGhwNzNrN2pLTGxiZmpsQVRyWWtCRVRlVUgiLCJuIjoicGxheS1hcy1jb2RlIiwiaWQiOjF9"
}