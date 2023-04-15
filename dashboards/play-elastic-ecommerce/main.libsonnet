// dashboard.jsonnet
local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

g.dashboard.new('Elasticsearch 8: e-Commerce Data')
+ g.dashboard.withUid('play-elastic-ecommerce')
+ g.dashboard.withDescription('es ecommerce data')
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withTime({
    "from": "2022-07-11T20:58:15.282Z",
    "to": "2022-07-13T06:26:47.391Z"
  })
+ g.dashboard.withPanels([
  g.panel.table.new('ecommerce data')
  + g.panel.table.withDatasource('play-elastic-ecommerce')
  + g.panel.table.gridPos.withW(24)
  + g.panel.table.gridPos.withH(8)
  + g.panel.table.withTargets([
    g.query.elasticsearch.withMetrics({
      "type": "raw_data"
    })
  ])
])
