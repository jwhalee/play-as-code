import "experimental/csv"

option task = {name: "import noaa water samples (2019)", every: 1y}

csv.from(url: "https://influx-testdata.s3.amazonaws.com/noaa.csv")
    |> to(bucket: "noaa-water-sample", org: "grafana")