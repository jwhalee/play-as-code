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

g.dashboard.new('ES flight data')
+ g.dashboard.withUid('play-elastic-flights')
+ g.dashboard.withDescription('es flight data')
+ g.dashboard.graphTooltip.withSharedCrosshair()
+ g.dashboard.withTime({
    "from": "2022-08-11T20:58:15.282Z",
    "to": "2022-08-16T00:00:00.000Z"
  })
+ g.dashboard.withPanels([
  panels.geomap.base('flight data: geomap', queries.rawData),
  panels.table.base('flight data: table', queries.rawData)
])