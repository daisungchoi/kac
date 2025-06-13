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
  version    = "1.23.0"   # check latest available

  set {
    name  = "falcon.cid"
    value = "<YOUR-FALCON-CID-HERE>"
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
