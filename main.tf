variable "aws_access_key" {}
variable "aws_secret_key" {}

# These variables end up being declared twice, once in the module and
# once in this script so they can be refereced from the .tfvars file.
variable "aws_vpc_id" {}

variable "aws_subnet_a_id" {}
variable "aws_subnet_b_id" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

//Enable-WindowsOptionalFeature IIS-WebServerRole
/*module "rolling-deploy" {
  source = "rolling-deploy/"

  # These values come from the tfvars file
  aws_vpc_id      = "${var.aws_vpc_id}"
  aws_subnet_a_id = "${var.aws_subnet_a_id}"
  aws_subnet_b_id = "${var.aws_subnet_b_id}"
}*/

module "ecs" {
  source = "ecs/"

  # These values come from the tfvars file
  aws_vpc_id      = "${var.aws_vpc_id}"
  aws_subnet_a_id = "${var.aws_subnet_a_id}"
  aws_subnet_b_id = "${var.aws_subnet_b_id}"
}

# terraform get
# terraform plan

