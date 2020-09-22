provider "aws" {
  region                  = "${var.aws_region}"
  profile                 = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
}

resource "random_id" "instance_id" {
  byte_length = 4
}

////////////////////////////////
////////////VPC////////////////
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name          = "${var.tag_name}-vpc"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Contact     = "${var.tag_contact}"
    X-Application = "${var.tag_application}"
    X-TTL         = "${var.tag_ttl}"
  }
}

////////////////////////////////
////////////Gateway//////////////
resource "aws_internet_gateway" "k8s_gateway" {
  vpc_id = "${aws_vpc.k8s_vpc.id}"
  tags {
    Name = "${var.tag_name}_k8s_gateway-${var.tag_application}"
  }
}

////////////////////////////////
////////////Access//////////////
resource "aws_route" "k8s_internet_access" {
  route_table_id         = "${aws_vpc.k8s_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.k8s_gateway.id}"
}

////////////////////////////////
////////////Subnet//////////////
resource "aws_subnet" "k8s_subnet" {
  vpc_id                  = "${aws_vpc.k8s_vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.tag_name}_k8s_subnet-${var.tag_application}"
  }
}


////////////////////////////////
////////Instance Data///////////
/////Specific Chef CentOS/////
# data "aws_ami" "centos" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["chef-highperf-centos7-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["446539779517"]
#}

data "aws_ami" "centos" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}