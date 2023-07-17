// dashboard.jsonnet
local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local panels = import './panels.libsonnet';
local queries = import './queries.libsonnet';
// local variables = import './variables.libsonnet';
local geomap = g.panels.geomap;
local fieldConfig = geomap.fieldConfig;
local defaults = geomap.fieldConfig.defaults;
local custom = geomap.fieldConfig.defaults.custom;
local override = geomap.fieldConfig.overrides;
local options = geomap.options;

g.dashboard.new('Elasticsearch 8: Flight Data')
+ g.dashboard.withUid('play-elastic-flight-data')
+ g.dashboard.withDescription('Elasticsearch flight data')
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
  panels.geomap.base('flight data: geomap', queries.rawData),
  panels.table.base('flight data: table', queries.rawData)
])