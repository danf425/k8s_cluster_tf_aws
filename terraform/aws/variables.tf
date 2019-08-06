////////////////////////////////
//// AWS Connection/////////////
variable "aws_profile" {}
variable "aws_region" {
  default = "us-west-2"
}
/////////////////////////////////
//////////Route53 Settings///////
variable "route53_zone_id" {}
variable "route53_zone_name" {}
////////////////////////////////
//////////AWS Key Info/////////
variable "aws_key_pair_file" {}
variable "aws_key_pair_name" {}
/////////////////////////////////
////////////////////////////////
////AWS Server Settings///////////
variable "aws_image_user" {
  default = "centos"
}
variable "test_server_instance_type" {
  default = "m5.large"
}
vairbale "count" { 
  default = "1" 
}

////////////////////////////
// Tags////////////////////
variable "tag_customer" {}

variable "tag_project" {}

variable "tag_name" {}

variable "tag_dept" {}

variable "tag_contact" {}

variable "tag_application" {}

variable "tag_ttl" {
  default = 4
}


////////////////////////////////////
/////Habitat Specific Variables/////
variable "channel" { default = "stable" }
variable "dev_channel" { default = "unstable" }
variable "prod_channel" { default = "stable" }
variable "origin" {}
