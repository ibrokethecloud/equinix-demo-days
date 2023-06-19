output "harvester_url" {
  value = "https://${equinix_metal_reserved_ip_block.harvester_vip_primary.network}/"
}

output "seed_ip" {
  value = equinix_metal_device.primary_cluster.access_public_ipv4
}

output "mac_addresses" {
  value = equinix_metal_device.primary_cluster.ports
}
