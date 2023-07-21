# #################################################
# ##                                             ##
# ##             community-statistics            ##
# ##                                             ## 
# #################################################

# # provision folder
# resource "grafana_folder" "play-folder-community" {
#   provider = grafana.play
#   uid   = "community-stats"
#   title = "Community Statistics"
# }

# # provision dashboard
# resource "grafana_dashboard" "play-dashboard-community-01" {
#   provider = grafana.play

#   config_json = file("dashboards/community/community-scorecard.json")
#   folder = grafana_folder.play-folder-community.id
# }

# # provision dashboard
# resource "grafana_dashboard" "play-dashboard-community-02" {
#   provider = grafana.play

#   config_json = file("dashboards/community/community-reports.json")
#   folder = grafana_folder.play-folder-community.id
# }