resource "kubernetes_service_account_v1" "service_account_elastic_agent" {
  metadata {
    name = "elastic-agent"
    namespace = "kube-system"
    labels = {
      "k8s-app" = "elastic-agent"
    }
  }
}