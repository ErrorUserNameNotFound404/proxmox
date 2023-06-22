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

resource "proxmox_lxc" "lxc_ubuntu" {
  target_node     = var.proxmox_host
  ssh_public_keys = var.ssh_pub_key
  hostname        = "lxc-Ubuntu-git"
  description     = "test Ubuntu linux lxc for git"
  ostemplate      = var.ubuntu_templete
  cores           = 1
  memory          = 512
  nameserver      = var.nameserver
  onboot          = true

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

resource "proxmox_vm_qemu" "kaliVM" {
  target_node = var.proxmox_host
  name        = "KaliVM"
  clone       = "Kali-Everything"
  full_clone  = true
  memory      = 4096
  cpu         = 4
}

resource "proxmox_vm_qemu" "KaliTHM" {
  target_node = var.proxmox_host
  name        = "KaliTHM"
  sshkeys     = var.ssh_pub_key
  clone       = "Kali-Everything"
  full_clone  = true
  memory      = 8192
  cpu         = 8
  ipconfig0   = "ip=${"10.1.10.5/24"},gw=${var.gateway}"
}