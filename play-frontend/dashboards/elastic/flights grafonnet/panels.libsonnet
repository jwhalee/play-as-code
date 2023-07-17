local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

{
  geomap: {
    local geomap = g.panel.geomap,
    local options = geomap.options,
    local layers = geomap.options.layers,
    local basemap = geomap.options.basemap,
    local location = geomap.options.layers.location,
    local transformations = geomap.transformations,

    base(title, targets):
      geomap.new(title)
      + geomap.withTargets(targets)
      + geomap.withDatasource('play-elastic-flights')
      + geomap.withInterval('1m')
      + geomap.gridPos.withW(24)
      + geomap.gridPos.withH(8)
      + basemap.withName('base')
      + basemap.withType('default')
      + basemap.withConfig('{}')
      + options.withTooltip( {"mode": "details"} ) 
      + options.withLayers(
        location.withLongitude('DestLocation.lon')
        + location.withMode('coords')
        + location.withLatitude('DestLocation.lat')
        + layers.withConfig({})
        + layers.withFilterData({
              "id": "byRefId",
              "options": "A"
            },)
        + layers.withName('Layer 0')
        + layers.withType('markers')
      )
      + geomap.withTransformations([
        transformations.withId('convertFieldType')
        + transformations.withOptions({
            "conversions": [
              {
                "destinationType": "number",
                "targetField": "DestLocation.lat"
              },
              {
                "destinationType": "number",
                "targetField": "DestLocation.lon"
              }
            ],
            "fields": {}
          })
  ]),
  },
  table: {
    local table = g.panel.table,
    local options = table.options,

    local transformations = table.transformations,

    base(title, targets):
      table.new(title)
      + table.withTargets(targets)
      + table.withDatasource('play-elastic-flights')
      + table.withInterval('1m')
      + table.gridPos.withW(24)
      + table.gridPos.withH(8)
      // + options.withTooltip( {"mode": "details"} ) 
      + table.withTransformations([
        transformations.withId('convertFieldType')
        + transformations.withOptions({
            "conversions": [
              {
                "destinationType": "number",
                "targetField": "DestLocation.lat"
              },
              {
                "destinationType": "number",
                "targetField": "DestLocation.lon"
              }
            ],
            "fields": {}
          })
  ]),
  }
}
