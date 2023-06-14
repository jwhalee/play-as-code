# resource "kubernetes_cluster_role_binding_v1" "cluster_role_binding_elastic_agent" {
#   metadata {
#     name = "elastic-agent"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "elastic-agent"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "elastic-agent"
#     namespace = "kube-system"
#   }
# }

# resource "kubernetes_role_binding_v1" "role_binding_elastic_agent" {
#   metadata {
#     name = "elastic-agent"
#     namespace = "kube-system"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Role"
#     name      = "elastic-agent"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "elastic-agent"
#     namespace = "kube-system"
#   }
# }

# resource "kubernetes_role_binding_v1" "role_binding_elastic_agent_kubeadm_config" {
#   metadata {
#     name = "elastic-agent-kubeadm-config"
#     namespace = "kube-system"
#   }
#   subject {
#     kind      = "ServiceAccount"
#     name      = "elastic-agent"
#     namespace = "kube-system"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Role"
#     name      = "elastic-agent-kubeadm-config"
#   }
# }

# resource "kubernetes_cluster_role_v1" "cluster_role_elastic_agent" {
#   metadata {
#     name = "elastic-agent"
#     labels = {
#       "k8s-app" = "elastic-agent"
#     }
#   }

#   rule {
#     api_groups = [""]
#     resources  = [
#       "nodes",
#       "namespaces",
#       "events",
#       "pods",
#       "services",
#       "configmaps",
#       # Needed for cloudbeat
#       "serviceaccounts",
#       "persistentvolumes",
#       "persistentvolumeclaims",
#     ]
#     verbs = ["get", "list", "watch"]
#   }

# # #   rule {
# # #     api_groups = [""]
# # #     resources  = [
# # #       "secrets",
# # #     ]
# # #     verbs = ["get"]
# # #   }

#   rule {
#     api_groups = ["extensions"]
#     resources  = [
#       "replicasets",
#     ]
#     verbs = ["get", "list", "watch"]
#   }

#   rule {
#     api_groups = ["apps"]
#     resources  = [
#       "statefulsets",
#       "deployments",
#       "replicasets",
#       "daemonsets",
#     ]
#     verbs = ["get", "list", "watch"]
#   }

#   rule {
#     api_groups = ["batch"]
#     resources  = [
#       "jobs",
#       "cronjobs",
#     ]
#     verbs = ["get", "list", "watch"]
#   }

#   rule {
#     api_groups = [""]
#     resources  = [
#       "nodes",
#       "stats",
#     ]
#     verbs = ["get"]
#   }

#   rule {
#     non_resource_urls = ["/metrics"]
#     verbs = ["get"]
#   }

#   rule {
#     api_groups = ["rbac.authorization.k8s.io"]
#     resources  = [
#       "clusterrolebindings",
#       "clusterroles",
#       "rolebindings",
#       "roles",
#     ]
#     verbs = ["get", "list", "watch"]
#   }

#   rule {
#     api_groups = ["policy"]
#     resources  = [
#       "podsecuritypolicies",
#     ]
#     verbs = ["get", "list", "watch"]
#   }

#   rule {
#     api_groups = ["storage.k8s.io"]
#     resources  = [
#       "storageclasses",
#     ]
#     verbs = ["get", "list", "watch"]
#   }
# }

# resource "kubernetes_role_v1" "role_elastic_agent" {
#   metadata {
#     name = "elastic-agent"
#     labels = {
#       "k8s-app" = "elastic-agent"
#     }
#   }

#   rule {
#     api_groups     = ["coordination.k8s.io"]
#     resources      = ["leases"]
#     verbs          = ["get", "create", "update"]
#   }
# }

# resource "kubernetes_role_v1" "elastic-agent-kubeadm-config" {
#   metadata {
#     name = "elastic-agent-kubeadm-config"
#     labels = {
#       "k8s-app" = "elastic-agent"
#     }
#   }

#   rule {
#     api_groups     = [""]
#     resources      = ["configmaps"]
#     resource_names = ["kubeadm-config"]
#     verbs          = ["get"]
#   }
# }
