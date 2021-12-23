module "k8s" {
  source  = "../../modules/do_k8s"
  project = var.project
  tags    = var.tags
}

resource "digitalocean_container_registry" "do_docker_registry" {
  name                   = var.project
  subscription_tier_slug = "starter"
}

resource "digitalocean_container_registry_docker_credentials" "do_docker_registry_credentials" {
  registry_name = digitalocean_container_registry.do_docker_registry.name
  write         = true
}