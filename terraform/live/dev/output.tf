output "do_k8s_config" {
  value     = module.k8s.do_k8s_config
  sensitive = true
}

output "do_registry_config" {
  value     = digitalocean_container_registry_docker_credentials.do_docker_registry_credentials.docker_credentials
  sensitive = true
}
