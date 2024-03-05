# private cloud docker registry
resource "yandex_container_registry" "docker-registry" {
  name = "docker-registry"
}