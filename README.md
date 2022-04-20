# Aviatrix-managed AWS TGW

Terraform module to create an Aviatrix-managed AWS TGW, mandatory Security Domains and the default connections
https://docs.aviatrix.com/HowTos/tgw_plan.html

### Diagram
<img src="https://github.com/bayupw/terraform-aviatrix-tgw-o/blob/main/images/terraform-aviatrix-tgw-o.png?raw=true">


## Sample usage

```hcl
module "tgw" {
  source  = "bayupw/tgw-o/aviatrix"
  version = "1.0.0"

  aws_account = "aws-account"
  aws_region  = "ap-southeast-2"
  tgw_name    = "avx-tgw"
  tgw_asn     = 65000
}
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-aviatrix-tgw-o/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-aviatrix-tgw-o/tree/master/LICENSE) for full details.