// dashboard.jsonnet
local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

g.dashboard.new('Elasticsearch 8: Web Logs')
+ g.dashboard.withUid('play-elastic-web-logs')
+ g.dashboard.withDescription('es web logs')
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withTags([
    "elasticsearch",
    "play-grafana",
    "community",
  ])
+ g.dashboard.withTime({
    "from": "2022-07-11T20:58:15.282Z",
    "to": "2022-07-13T06:26:47.391Z"
  })
+ g.dashboard.withPanels([
  g.panel.logs.new('web logs')
  + g.panel.logs.withDatasource('play-elastic-web-logs')
  + g.panel.logs.gridPos.withW(24)
  + g.panel.logs.gridPos.withH(8)
  + g.panel.logs.withTargets([
    g.query.elasticsearch.withMetrics({
      "type": "logs"
    })
  ]),
  g.panel.table.new('web logs')
  + g.panel.table.withDatasource('play-elastic-web-logs')
  + g.panel.table.gridPos.withW(24)
  + g.panel.table.gridPos.withH(8)
  + g.panel.table.withTargets([
    g.query.elasticsearch.withMetrics({
      "type": "logs"
    })
  ])
])
