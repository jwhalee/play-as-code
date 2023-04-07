# ###################################################
# ##                                               ##
# ## PROMETHEUS datasource, folder, and dashboards ##
# ##                                               ## 
# ###################################################

# # provision datasource
# resource "grafana_data_source" "play-ds-prom" {
#   provider = grafana.play

#   type          = "prometheus"
#   name          = "play-prom"
#   url           = "https://prometheus.grafana.fun"
#   uid           = "play-prom"
#   json_data_encoded = jsonencode({
#     httpMethod: "POST"
#   })
# }

# # provision folder
# resource "grafana_folder" "play-folder-prom" {
#   provider = grafana.play

#   title = "Prometheus"
# }

# # provision dashboard
# resource "grafana_dashboard" "play-dashboard-prom-01" {
#   provider = grafana.play

#   config_json = file("dashboards/prom/TK.json")
#   folder = grafana_folder.play-folder-prom.id
# }

# # # provision dashboard
# # resource "grafana_dashboard" "play-dashboard-influx-02" {
# #   provider = grafana.play

# #   config_json = file("dashboards/influx/influx-usgs-earthquakes.json")
# #   folder = grafana_folder.play-folder-influx.id
# # }

# # # provision dashboard
# # resource "grafana_dashboard" "play-dashboard-influx-03" {
# #   provider = grafana.play

# #   config_json = file("dashboards/influx/influx-water-samples.json")
# #   folder = grafana_folder.play-folder-influx.id
# # }

# # # provision dashboard
# # resource "grafana_dashboard" "play-dashboard-influx-04" {
# #   provider = grafana.play

# #   config_json = file("dashboards/influx/influx-internal-metrics.json")
# #   folder = grafana_folder.play-folder-influx.id
# # }