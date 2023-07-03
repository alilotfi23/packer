source "virtualbox-iso" "ubuntu" {
  boot_command = [
    "<enter><wait>",
    "<f6><esc>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs>",
    "/install/vmlinuz ",
    "initrd=/install/initrd.gz ",
    "net.ifnames=0 ",
    "auto-install/enable=true ",
    "debconf/priority=critical ",
    "preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/${var.preseed}",
    "<enter>"
  ]
  disk_size            = "${var.disk_size}"
  guest_os_type        = "${var.virtualbox_guest_os_type}"
  hard_drive_interface = "sata"
  headless             = "${var.headless}"
  http_directory       = "http"
  iso_checksum         = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_urls = [
    "${var.iso_path}/${var.iso_name}",
    "${var.iso_url}"
  ]
  output_directory     = "output"
  shutdown_command     = "echo '${var.ssh_password}'|sudo -S shutdown -P now"
  ssh_username         = "${var.ssh_username}"
  ssh_password         = "${var.ssh_password}"
  ssh_wait_timeout     = "10000s"
  guest_additions_mode = "disable"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--audio", "none"],
    ["modifyvm", "{{ .Name }}", "--usb", "off"],
    ["modifyvm", "{{ .Name }}", "--vram", "12"],
    ["modifyvm", "{{ .Name }}", "--vrde", "off"],
    ["modifyvm", "{{ .Name }}", "--nictype1", "virtio"],
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.cpus}"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.vm_name}"
  format                  = "ova"
}
