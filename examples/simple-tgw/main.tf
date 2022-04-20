module "tgw" {
  source  = "bayupw/tgw-o/aws"
  version = "1.0.0"

  aws_account = "aws-account"
  aws_region  = "ap-southeast-2"
  tgw_name    = "avx-tgw"
  tgw_asn     = 65000
}