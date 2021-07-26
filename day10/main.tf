provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"

}

resource "kubernetes_pod" "test" {
  metadata {
    name = "terraform-example"
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

    }
  }
}