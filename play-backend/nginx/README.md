we used helm and bound the load balancer to a static IP like this:

`helm install nginx-ingress nginx-stable/nginx-ingress -n play-backends --set controller.service.loadBalancerIP=34.133.192.185`

that static IP, `nginx` was also manually created:
run:
`gcloud compute addresses describe nginx --region us-central1`

foo
