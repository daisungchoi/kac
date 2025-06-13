provider "helm" {
  kubernetes {
    config_path = "${path.module}/kubeconfig.yaml"
  }
}

resource "helm_release" "crowdstrike_kca" {
  name       = "falcon-sensor"
  namespace  = "falcon-system"
  create_namespace = true

  repository = "https://crowdstrike.github.io/falcon-helm"
  chart      = "falcon-sensor"
  version    = "1.32.0"   # check latest available

  set {
    name  = "falcon.cid"
    value = "FC848200B24D46B19026FED6553C5D17-79" # You need to change your sensor ID"
  }

  set {
    name  = "falcon.apd"
    value = "true"
  }

  set {
    name  = "falcon.tags"
    value = "EKS"
  }
}
