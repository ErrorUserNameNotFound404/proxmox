variable "ssh_pub_key" {
}

variable "proxmox_host" {
  default = "proxmox"
}

variable "api_url" {
}

variable "token_secret" {
}

variable "token_id" {
}

variable "gateway" {

}

variable "nameserver" {
  
}

variable "ubuntu_templete" {
  default = "RAID:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
}