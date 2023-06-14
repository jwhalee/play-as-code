# elasticsearch

note: if the elasticsearch deployment goes down entirely, when it restarts kibana won't work anymore. You'll first need to shell into the elasticsearch pod and reset the password for the special `kibana_system` user:

find the pod:
`kubectl get po -A`

shell into the pod:
`kubectl exec -n <namespace-here> --stdin --tty <pod-name-here> -- bash`

then run the following command and follow the prompts:
`bin/elasticsearch-reset-password -u kibana_system -i grafana`

this will get kibana configured again.

exit the pod:
`exit`

refresh the [kibana UI](https://kibana.grafana.fun). it should work again.

also needed kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info --format='value(config.account)')

the k8s roles for elastic agent are not wanting to get ported into HCL so I'm leaving it for now.
