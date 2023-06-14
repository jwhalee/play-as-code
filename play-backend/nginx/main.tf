resource "kubernetes_ingress_v1" "example" {
  wait_for_load_balancer = true
  metadata {
    name = "example"
    namespace = var.namespace
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "playdev.grafana.fun"
      http {
        path {
          path = "/*"
          backend {
            service {
              name = "grafana"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }
  }
}

# Display load balancer hostname (typically present in AWS)
output "load_balancer_hostname" {
  value = kubernetes_ingress_v1.example.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP (typically present in GCP, or using Nginx ingress controller)
output "load_balancer_ip" {
  value = kubernetes_ingress_v1.example.status.0.load_balancer.0.ingress.0.ip
}