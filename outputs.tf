output "tgw" {
  description = "The created Aviatrix Managed AWS TGW aviatrix_aws_tgw as an object with all of it's attributes"
  value       = aviatrix_aws_tgw.this
}

output "security_domain" {
  description = "The created mandatory security domains aviatrix_aws_tgw_security_domain as an object with all of it's attributes"
  value       = aviatrix_aws_tgw_security_domain.this
}

output "domain_conn" {
  description = "The created mandatory dp,aom cpmmectopms aviatrix_aws_tgw_peering_domain_conn as an object with all of it's attributes"
  value       = aviatrix_aws_tgw_peering_domain_conn.this
}