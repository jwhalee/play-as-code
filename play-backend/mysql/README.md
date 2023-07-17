# mysql

as long as the persistent volume does not fall down, MySQL will persist data across restarts / other events.

in the event of a total data loss, you will need to shell into the mysql pod and run a script. this script will set up the grafanaReadOnly user and download and install the Sakila and World_x datasets from the official mysql repository.

1) find the pod and namespace: `kubectl get po -A`
2) shell into the pod: `kubectl exec -n <NAMESPACE> --stdin --tty <POD-NAME> -- bash setup.sh`
