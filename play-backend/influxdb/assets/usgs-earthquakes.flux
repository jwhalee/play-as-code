import "influxdata/influxdb/sample"
option task = { 
  name: "Collect USGS earthquake data",
  every: 15m,
}

sample.data(set: "usgs")
  |> to(
      org: "grafana",
      bucket: "usgs-earthquakes"
  )