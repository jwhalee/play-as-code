local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local esQuery = g.query.elasticsearch;
// local variables = import './variables.libsonnet';

{
  rawData:
       esQuery.withMetrics({
      "type": "raw_data"
    })
}
