variable "harvester_version" {
  default = "v1.2.0-rc2"
}

variable "node_count" {
  default = "1"
}

variable "project_name" {
  default = ""
}

variable "plan" {
  default = "n3.xlarge.x86"
}

variable "billing_cylce" {
  default = "hourly"
}

variable "metro" {
  default = "SG"
}

variable "ipxe_script" {
  default = "https://raw.githubusercontent.com/ibrokethecloud/equinix-demo-days/main/ipxe/ipxe-"
}

variable "hostname_prefix" {
  default = "harvester-pxe"
}


variable "ssh_key" {
  default     = ""
  description = "Your ssh key, examples: 'github: myghid' or 'ssh-rsa AAAAblahblah== keyname'"
}

variable "vlan_attachment" {
  default     = "100"
  description = "default vlan to attach layer2 interfaces to"
}
