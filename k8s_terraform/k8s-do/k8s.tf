resource "digitalocean_kubernetes_cluster" "hello-world" {
  name   = "hello-world"
  region = "nyc1"
  version = "1.21.2-do.2"

  node_pool {
    name       = "hello-pool"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}