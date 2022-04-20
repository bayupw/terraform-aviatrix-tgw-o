variable "cloud_type" {
  description = "Type of cloud service provider: AWS or AWSGov"
  type        = string
  default     = "aws"

  validation {
    condition     = contains(["aws", "awsgov"], lower(var.cloud_type))
    error_message = "Invalid cloud type. Choose AWS or AWSGovCloud."
  }
}

variable "aws_account" {
  description = "Name of the cloud account in the Aviatrix controller"
  type        = string
  default     = "aws-account"
}

variable "aws_region" {
  description = "AWS region of AWS TGW to be created in"
  type        = string
  default     = "ap-southeast-2"
}

variable "tgw_name" {
  description = "Name of the AWS TGW to be created"
  type        = string
  default     = "avx-tgw"
}

variable "tgw_asn" {
  description = "BGP Local ASN (Autonomous System Number)"
  type        = number
  default     = 64512
}

variable "enable_multicast" {
  description = "Enable multicast"
  type        = bool
  default     = false
}

variable "tgw_cidrs" {
  description = "Set of TGW CIDRs"
  type        = list(string)
  default     = null
}

locals {
  cloud_type = lookup(local.cloud_type_map, lower(var.cloud_type), "aws")

  cloud_type_map = {
    aws    = 1,
    awsgov = 256,
  }

  mandatory_domains = ["Default_Domain", "Shared_Service_Domain", "Aviatrix_Edge_Domain"]

  #Create connections based on local.mandatory_domains
  connections = flatten([
    for domain in local.mandatory_domains : [
      for connected_domain in slice(local.mandatory_domains, index(local.mandatory_domains, domain) + 1, length(local.mandatory_domains)) : {
        domain1 = domain
        domain2 = connected_domain
      }
    ]
  ])

  #Create map object to be used in for_each
  connections_map = {
    for connection in local.connections : "${connection.domain1}:${connection.domain2}" => connection
  }
}