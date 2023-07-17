#################################################
##                                             ##
##             REDIS datasource                ##
##                                             ## 
#################################################


# provision datasource
resource "grafana_data_source" "play-ds-redis-01" {
  provider = grafana.play
  
  basic_auth_enabled  = false
  basic_auth_username = ""
  database_name       = ""
  is_default          = false 
  name                = "Redis"
  type                = "redis-datasource"
  url                 = "redis://34.133.99.59:6379"
  uid                 = "play-redis"
  json_data_encoded = jsonencode({
    tlsAuth       = false
    tlsSkipVerify = true
  })
}
