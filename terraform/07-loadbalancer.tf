
# resource "yandex_lb_network_load_balancer" "lb-ext" {
#   name = "external-load-balancer"
#   deletion_protection = false

#   listener {
#     name        = "httplistener"
#     port        = 80
#     target_port = 80
#     protocol    = "tcp"
#     external_address_spec   {
#       address    = yandex_vpc_address.lb_address.external_ipv4_address[0].address
#       ip_version = "ipv4"
#     }
#   }

#   listener {
#     name        = "httpslistener"
#     port        = 443
#     target_port = 443
#     protocol    = "tcp"
#     external_address_spec   {
#       address    = yandex_vpc_address.lb_address.external_ipv4_address[0].address
#       ip_version = "ipv4"
#     }
#   }

#   attached_target_group {
#     target_group_id = yandex_lb_target_group.target-group.id
#     healthcheck {
#       interval = 2
#       name = "http"
#       http_options {
#         # traefik ping route and entrypoint
#         port = 8082
#         path = "/ping" 
#       }
#     }
#   }
# }

# resource "yandex_lb_target_group" "target-group" {
#   name      = "target-group"
#   region_id = "ru-central1"

#   target {
#     subnet_id = yandex_vpc_subnet.subnet_a.id
#     address   = yandex_compute_instance.nomad-member-1.network_interface.0.ip_address
#   }
# }
