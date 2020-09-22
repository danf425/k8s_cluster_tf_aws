////////////////////////////////
//// AWS Connection/////////////
variable "aws_profile" {}
variable "aws_region" {
  default = "us-west-2"
}
/////////////////////////////////
//////////Route53 Settings///////
//variable "route53_zone_id" {}
//variable "route53_zone_name" {}
////////////////////////////////
//////////AWS Key Info/////////
variable "aws_key_pair_file" {}
variable "aws_key_pair_name" {}
/////////////////////////////////
////////////////////////////////
////AWS Server Settings///////////
variable "project_ami" {
  default = "ami-0036ab7a"
}

variable "aws_image_user" {
  default = "centos"
}
variable "server_instance_type" {
  default = "t2.medium"
}
variable "count" { 
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
  default = 48
}


