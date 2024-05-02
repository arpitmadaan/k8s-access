# main.tf

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4.0"
    }
  }
}

provider "kubernetes" {
# specify your kubeconfig file location
  config_path = "admin.conf" 
}


resource "kubernetes_role_binding" "role_binding" {
  count = length(var.role_bindings)

  metadata {
    name      = "${var.role_bindings[count.index].access_level}-${var.role_bindings[count.index].namespace}-${var.role_bindings[count.index].username}"
    namespace = var.role_bindings[count.index].namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "${var.role_bindings[count.index].access_level}-cluster-role"
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.role_bindings[count.index].username
    namespace = "default"
  }
}
