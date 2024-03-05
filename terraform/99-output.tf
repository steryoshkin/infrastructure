output "registry_id" {
  description = "private docker registry id after init"
  value = yandex_container_registry.docker-registry.id
}

output "registry_name" {
  description = "private docker registry name"
  value = yandex_container_registry.docker-registry.name
}