output "do_k8s_config" {
  value     = digitalocean_kubernetes_cluster.do_k8s.kube_config.0
  sensitive = true
}