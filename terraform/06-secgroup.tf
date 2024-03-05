resource "yandex_vpc_security_group" "cluster_group" {
  name        = "cluster_group"
  description = "cluster security group"
  network_id  = yandex_vpc_network.vpc_network.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "vpn_security_group" {
  name        = "vpn-security-group"
  network_id  = yandex_vpc_network.vpc_network.id

  ingress {
    protocol       = "TCP"
    description    = "ssh for local machine in home net"
    v4_cidr_blocks = var.access_devops_list
    port           = 22
  }

  ingress {
    description = "VPN Server TCP 443"
    protocol    = "TCP"
    from_port   = 443
    to_port     = 443
    v4_cidr_blocks = var.access_devops_list
  }

  ingress {
    description = "VPN Server UDP 1194"
    protocol    = "UDP"
    from_port   = 1194
    to_port     = 1194
    v4_cidr_blocks = var.access_devops_list
  }

  ingress {
    description = "Admin and Client Web UI TCP 943"
    protocol    = "TCP"
    from_port   = 943
    to_port     = 943
    v4_cidr_blocks = var.access_devops_list
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "nat-gate-sg" {
  name       = "nat-gate-sg"
  network_id = yandex_vpc_network.vpc_network.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh for local machine in home net"
    v4_cidr_blocks = var.access_devops_list
    port           = 22
  }

  ingress {
    protocol       = "ANY"
    description    = "Ingress any from subnet_a"
    v4_cidr_blocks = ["10.82.2.0/24"]
  }
}