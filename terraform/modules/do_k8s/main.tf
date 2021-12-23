resource "digitalocean_tag" "droplet_tags" {
  for_each = tomap(var.tags)
  name     = each.value
}

resource "digitalocean_kubernetes_cluster" "do_k8s" {
  name    = join("-", ["do", "k8s", var.project])
  region  = var.do_region
  version = data.digitalocean_kubernetes_versions.do_k8s_versions.latest_version

  node_pool {
    name       = join("-", ["do", "k8s", "pool", var.project])
    size       = var.instance_type
    node_count = var.node_numb
    tags       = values(digitalocean_tag.droplet_tags)[*].id
  }

  tags = values(digitalocean_tag.droplet_tags)[*].id
}
