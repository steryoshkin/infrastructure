resource "yandex_compute_instance" "nfs" {
  name        = "nfs"
  platform_id = "standard-v1"
  zone        = "${var.zone}"

  resources {
    core_fraction = 20
    cores  = 2               
    memory = 2               
  }

  boot_disk {
    initialize_params {
      image_id    = yandex_compute_image.ubuntu-2204-lts.id
      size     = 20            
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_a.id
    nat       = false      
    ip_address = var.internal_addrs["nfs"]
    security_group_ids = [yandex_vpc_security_group.cluster_group.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("${local.path_nfs}/id_rsa.pub")}"
  }
}

locals {
  path_nfs = "${var.ssh_path}/nfs"
}