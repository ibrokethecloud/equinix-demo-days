## Harvester setup for Equinix Demo Days

Simple example using the terraform equinix provider to create a two single node clusters leveraging n3.xlarge.x86 instances.

The n3.xlarge.x86 instances support sr-iov and these are used to demo the new sr-iov network devices support in upcoming harvester v1.2.0

The terraform module, will place convert the bond1 interface on the instances from hybrided bonded into layer2 unbonded.

It will then attach eth1 from bond1 to the vlan ID 100. 

The output will provide details of the mac addresses for interfaces, as this makes it easier to identify device where sriov should be enabled.

The following env variables / terraform variables need to be defined before use:

```
METAL_AUTH_TOKEN="metal-auth-token"
TF_VAR_project_name="equinix-metal-project-name"
TF_VAR_vlan_id="vlan-to-attach-eth1"
```