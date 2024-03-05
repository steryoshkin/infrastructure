resource "yandex_compute_instance" "vpn-server" {
  name        = "vpn-server"
  platform_id = "standard-v1"
  zone        = "${var.zone}"

  resources {
    core_fraction = 20
    cores  = 2               
    memory = 2               
  }

  boot_disk {
    initialize_params {
      image_id    = yandex_compute_image.openvpn.id
      size     = 20           
      type     = "network-hdd" 
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = true           
    security_group_ids = [yandex_vpc_security_group.vpn_security_group.id]
    ip_address = var.internal_addrs["vpn-server"]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("${local.path_vpn}/id_rsa.pub")}"
  }
}

locals {
  path_vpn = "${var.ssh_path}/vpn-server"
}
