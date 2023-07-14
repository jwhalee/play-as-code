# influxdb & telegraf

if you need to re-add the initial datasets, find the new influxdb pod and the namespace it is running in:

`kubectl get po -A`

Then run:

`kubectl exec -n <NAMESPACE-HERE> --stdin --tty <POD-NAME-HERE> -- bash scripts/setup.sh`

add scraper for /metrics --> grafana bucket.
