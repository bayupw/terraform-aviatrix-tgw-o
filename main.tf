# Create an Aviatrix AWS TGW
resource "aviatrix_aws_tgw" "this" {
  cloud_type         = local.cloud_type
  account_name       = var.aws_account
  region             = var.aws_region
  tgw_name           = var.tgw_name
  aws_side_as_number = var.tgw_asn

  manage_vpc_attachment             = false
  manage_transit_gateway_attachment = false
  manage_security_domain            = false
  enable_multicast                  = var.enable_multicast
  cidrs                             = var.tgw_cidrs
}

# Create Mandatory Security Domains based on local.mandatory_domains
resource "aviatrix_aws_tgw_security_domain" "this" {
  for_each = toset(local.mandatory_domains)

  name     = each.value
  tgw_name = aviatrix_aws_tgw.this.tgw_name

  depends_on = [aviatrix_aws_tgw.this]
}

# Create Mandatory Security Domain Connections
resource "aviatrix_aws_tgw_peering_domain_conn" "this" {
  for_each = local.connections_map

  tgw_name1    = aviatrix_aws_tgw.this.tgw_name
  tgw_name2    = aviatrix_aws_tgw.this.tgw_name
  domain_name1 = each.value.domain1
  domain_name2 = each.value.domain2

  depends_on = [aviatrix_aws_tgw_security_domain.this]
}