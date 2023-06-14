// dashboard.jsonnet
local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

g.dashboard.new('Elasticsearch 8: e-Commerce Data')
+ g.dashboard.withUid('play-elastic-ecommerce')
+ g.dashboard.withDescription('es ecommerce data')
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withTags([
    "elasticsearch",
    "play-grafana",
    "community",
  ])
+ g.dashboard.withTime({
    "from": "now-6h",
    "to": "now"
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
