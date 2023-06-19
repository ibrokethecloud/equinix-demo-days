// IP attachment to be added to seed node, and this is subsequently assigned as Harvester vip
// in the config.yaml
resource "random_password" "password" {
  length  = 16
  special = false
}

resource "random_password" "token" {
  length  = 16
  special = false
}

resource "equinix_metal_reserved_ip_block" "harvester_vip_primary" {
  project_id = data.equinix_metal_project.project.project_id
  metro      = var.metro
  type       = "public_ipv4"
  quantity   = 1
}

resource "equinix_metal_device" "primary_cluster" {
  hostname         = "${var.hostname_prefix}-1"
  plan             = var.plan
  metro            = var.metro
  operating_system = "custom_ipxe"
  billing_cycle    = var.billing_cylce
  project_id       = data.equinix_metal_project.project.project_id
  ipxe_script_url  = "${var.ipxe_script}${element(split("v", var.harvester_version), 1)}"
  always_pxe       = "false"
  user_data        = templatefile("${path.module}/create.tpl", { version = var.harvester_version, password = random_password.password.result, token = random_password.token.result, vip = equinix_metal_reserved_ip_block.harvester_vip_primary.network, hostname_prefix = var.hostname_prefix, ssh_key = var.ssh_key, count = "1" })
}


resource "equinix_metal_ip_attachment" "first_address_assignment_primary_cluster" {
  device_id     = equinix_metal_device.primary_cluster.id
  cidr_notation = join("/", [cidrhost(equinix_metal_reserved_ip_block.harvester_vip_primary.cidr_notation, 0), "32"])
}


// convert bond1 port to layer2-individual
resource "equinix_metal_port" "convert_bond1_primary_cluster" {
  port_id = [for val in equinix_metal_device.primary_cluster.ports : val.id if val.name == "bond1"][0]
  bonded  = false
  layer2  = true
}

// introduce delay to ensure port has been converted before attempting vlan attachment
resource "time_sleep" "wait_for_network_change" {
  depends_on      = [equinix_metal_port.convert_bond1_primary_cluster]
  create_duration = "240s"
}

resource "equinix_metal_port_vlan_attachment" "vlan_attachment_primary_cluster" {
  device_id = equinix_metal_device.primary_cluster.id
  vlan_vnid = var.vlan_attachment
  port_name = "eth1"
}

