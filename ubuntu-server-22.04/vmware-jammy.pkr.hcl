packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "ubuntu-jammy" {
  iso_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.1-desktop-amd64.iso"
  iso_checksum = "md5:8c651682056205967d530697c98d98c3"
  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "arm-ubuntu-64"
  disk_adapter_type = "nvme"
  version = 19
  http_directory = "http"
  boot_command = [
        "<esc><wait>",
        "<esc><wait>",
        "<enter><wait>",
        "/install/vmlinuz<wait>",
        " initrd=/install/initrd.gz",
        " auto-install/enable=true",
        " debconf/priority=critical",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed_2.cfg<wait>",
        " -- <wait>",
        "<enter><wait>"
  ]
  usb = true
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Ubuntu Server 22.04"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.ubuntu-jammy"]
}
