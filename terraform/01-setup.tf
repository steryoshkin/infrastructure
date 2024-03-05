# init provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.104.0"
    }
  }
}

# service account authorized key (terraform managment)
provider "yandex" {
  service_account_key_file = "./credentials/authorized_key.json"
  cloud_id                 = "${var.cloud_id}"
  folder_id                = "${var.folder_id}"
}


/**
* ready-made virtual machine images
*/

# ubuntu 22 base image
resource "yandex_compute_image" "ubuntu-2204-lts" {
  source_family = "ubuntu-2204-lts"
}

# openvpn access server base image (to cloud net)
resource "yandex_compute_image" "openvpn" {
  source_family = "openvpn"
}

# ubuntu 22 base image with base nat configuration
resource "yandex_compute_image" "nat-instance-ubuntu-2204" {
  source_family = "nat-instance-ubuntu-2204"
}


# state terraform backend config
terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "tf-state-config"
    region     = "ru-central1"
    key        = "infr.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}