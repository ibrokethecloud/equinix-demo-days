output "harvester_url_primary" {
  value = "https://${equinix_metal_reserved_ip_block.harvester_vip_primary.network}/"
}

output "seed_ip_primary" {
  value = equinix_metal_device.primary_cluster.access_public_ipv4
}

output "mac_addresses_primary" {
  value = equinix_metal_device.primary_cluster.ports
}

output "harvester_url_secondary" {
  value = "https://${equinix_metal_reserved_ip_block.harvester_vip_secondary.network}/"
}

output "seed_ip_primary" {
  value = equinix_metal_device.secondary_cluster.access_public_ipv4
}

output "mac_addresses_primary" {
  value = equinix_metal_device.secondary_cluster.ports
}
