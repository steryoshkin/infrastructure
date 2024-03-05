internal_addrs = {
    # subnet-a
    "vpn-server"     = "10.82.2.111"
    "nfs"            = "10.82.2.112"
    "master-a"       = "10.82.2.3"
    "builder"        = "10.82.2.4"
    "nomad-member-1" = "10.82.2.10"

    # subnet-nat
    "natgate"        = "10.82.1.254" 
}

# control access to your cloud resources through devops ip addresses list (example : ["92.193.4.106/32"] - access for only 92.193.4.106)
access_devops_list = ["0.0.0.0/0"]