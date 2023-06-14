resource "kubernetes_config_map_v1" "elastic-agent-configmap" {
  metadata {
    name = "agent-node-datastreams"
    namespace = "kube-system"
    labels = {
      "k8s-app" = "elastic-agent"
    }
  }

  data = {
    "agent.yml" = "${file("${path.module}/assets/agent.yml")}"
  }
}