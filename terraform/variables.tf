variable "folder_id" {
  description = "working folder cloud id"
  type = string
  default = "b1gqls06jbl13mnbvisk"
}

variable "cloud_id" {
  description = "cloud id"
  type = string
  default = "b1gfoiivdhn4urdg4n74"
}

variable "zone" {
  description = "access zone"
  type = string
  default = "ru-central1-a"
}

variable "ssh_path" {
  description = "path on local system ssh credentials to cloud machines"
  type = string
  default = "~/.ssh" 
}

variable "internal_addrs" {
  description = "A map of the internal IP addresses of the machines"
  type        = map(string)
}

variable "access_devops_list" {
  description = "List of CIDR blocks to resources (devops)"
  type        = list(string)
}