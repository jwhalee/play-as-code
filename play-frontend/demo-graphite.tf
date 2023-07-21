# #################################################
# ##                                             ##
# ## graphite datasource, folder, and dashboards ##
# ##                                             ## 
# #################################################

# # provision datasource
# resource "grafana_data_source" "play-ds-graphite-01" {
#   provider = grafana.play

#   basic_auth_enabled  = false
#   basic_auth_username = ""
#   is_default          = true 
#   name                = "Graphite"
#   type                = "graphite"
#   url                 = "http://graphite.play-grafana:8080"
#   # TODO: make uid more unique
#   uid                 = "000000001"
#   json_data_encoded   = jsonencode({
#     graphiteType    = "default"
#     graphiteVersion = "1.0"
#     keepCookies     = []
#   })
# }

# # provision datasource
# resource "grafana_data_source" "play-ds-graphite-02" {
#   provider = grafana.play

#   basic_auth_enabled  = false
#   basic_auth_username = ""
#   is_default          = false 
#   name                = "Graphite: wikimedia.org metrics"
#   type                = "graphite"
#   url                 = "https://graphite.wikimedia.org"
#   uid                 = "play-graphite-wikimedia"
#   json_data_encoded   = jsonencode({
#     graphiteType    = "default"
#     graphiteVersion = "1.1"
#   })
# }

# # provision folder
# resource "grafana_folder" "play-folder-graphite" {
#   provider = grafana.play
#   uid   = "demo-graphite"
#   title = "Demo: Graphite"
# }

# # provision dashboard
# resource "grafana_dashboard" "play-dashboard-graphite-01" {
#   provider = grafana.play

#   config_json = file("dashboards/graphite/templated-nested.json")
#   folder = grafana_folder.play-folder-graphite.id
# }

# # provision dashboard
# resource "grafana_dashboard" "play-dashboard-graphite-02" {
#   provider = grafana.play

#   config_json = file("dashboards/graphite/wikimedia-1.json")
#   folder = grafana_folder.play-folder-graphite.id
# }