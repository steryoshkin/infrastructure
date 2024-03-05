resource "yandex_compute_instance" "natgate" {
  name        = "natgate"
  platform_id = "standard-v3"
  zone        = "${var.zone}"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.nat-instance-ubuntu-2204.id
      size     = 10            
      type     = "network-hdd"
    }
  }

  network_interface {
    ip_address = var.internal_addrs["natgate"]
    subnet_id          = yandex_vpc_subnet.subnet_nat.id
    security_group_ids = [yandex_vpc_security_group.nat-gate-sg.id]
    nat                = true
    nat_ip_address     = yandex_vpc_address.nat-addr.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = "ubuntu:${file("${local.path_natgate}/id_rsa.pub")}"
  }
}

locals {
  path_natgate = "${var.ssh_path}/natgate"
}