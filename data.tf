data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "region-name"
    values = ["us-east-1"]
  }
}

locals {
  azs=slice(data.aws_availability_zones.available.names,0,2)
}