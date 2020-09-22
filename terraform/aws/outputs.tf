output "k8s_cluster_public_ip" {
  value = "${aws_instance.k8s_cluster.*.public_ip}"
}
