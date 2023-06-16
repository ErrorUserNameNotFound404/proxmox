terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.7.4"
    }
  }

  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_api_url          = var.api_url
  pm_api_token_id     = var.token_id
  pm_api_token_secret = var.token_secret
  pm_tls_insecure     = true
}

resource "proxmox_lxc" "basic" {
  target_node     = var.proxmox_host
  ssh_public_keys = var.ssh_key
  hostname        = "lxc-Ubuntu-git"
  description     = "test Ubuntu linux lxc for git"
  ostemplate      = "RAID:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  cores           = 1
  memory          = 512
  nameserver      = "10.1.10.2"
  onboot          = true


  // Terraform will crash without rootfs defined
  rootfs {
    storage = "RAID"
    size    = "50G"

  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.1.10.3/24"
  }
}