//////////////////////////////////////////
/////////////Instance/////////////////////
resource "aws_instance" "k8s_cluster" {
  connection {
    user        = "${var.aws_image_user}"
    private_key = "${file("${var.aws_key_pair_file}")}"
  }

#  ami                         = "${var.project_ami}"
  ami                         = "${data.aws_ami.centos.id}"
  count                       = "${var.count}"
  instance_type               = "t2.medium"
  key_name                    = "${var.aws_key_pair_name}"
  subnet_id                   = "${aws_subnet.k8s_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.k8s.id}", "${aws_security_group.k8s.id}"]
  associate_public_ip_address = true

  tags {
    Name          = "k8s_${random_id.instance_id.hex}"
    X-Dept        = "${var.tag_dept}"
    X-Customer    = "${var.tag_customer}"
    X-Project     = "${var.tag_project}"
    X-Application = "${var.tag_application}"
    X-Contact     = "${var.tag_contact}"
    X-TTL         = "${var.tag_ttl}"
  }

}

