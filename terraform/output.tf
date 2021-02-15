output "gi_instance1_public_ip" {
  value = module.instance1.gi_instance_public_ip
}

output "gi_instance1_private_ip" {
  value = module.instance1.gi_instance_private_ip
}

output "gi_instance2_public_ip" {
  value = module.instance2.gi_instance_public_ip
}

output "gi_instance2_private_ip" {
  value = module.instance2.gi_instance_private_ip
}

output "gi_rds_endpoint" {
  value = module.rds.gi_rds_endpoint
}

output "gi_rds_port" {
  value = module.rds.gi_rds_port
}