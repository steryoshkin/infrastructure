# public ip address for nat instance 
# the machine from whose IP address all cluster services will access the Internet resources
resource "yandex_vpc_address" "nat-addr" {
  name = "nat-addr"
  deletion_protection = false

  external_ipv4_address {
    zone_id                  = "${var.zone}"
    ddos_protection_provider = "qrator"
  }
}

# single entry point to cluster (public ip adress of load balancer)
resource "yandex_vpc_address" "lb_address" {
  name = "lb_address"
  deletion_protection = true
  external_ipv4_address {
    zone_id                  = "${var.zone}"
    ddos_protection_provider = "qrator"
  }
}

resource "yandex_vpc_network" "vpc_network" {
  folder_id = "${var.folder_id}"
  name = "vpc_network"
}

resource "yandex_vpc_route_table" "rt" {
  name       = "rt"
  network_id = yandex_vpc_network.vpc_network.id
  
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = yandex_compute_instance.natgate.network_interface.0.ip_address
  }
}

resource "yandex_vpc_subnet" "subnet_nat" {
  name           = "subnet_nat"
  zone           = "${var.zone}"
  network_id     = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = ["10.82.1.0/24"]
  dhcp_options {
    domain_name_servers = ["1.1.1.1"] # cloudflare
  }
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "subnet_a"
  zone           = "${var.zone}"
  network_id     = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = ["10.82.2.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id # all routing through nat instance in subnet_nat
  dhcp_options {
    domain_name_servers = ["1.1.1.1"] # cloudflare
  }
}

