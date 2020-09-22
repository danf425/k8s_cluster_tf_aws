# Using Templates

1. Call the template into your `projectname.tf`       e.g:
```
////////////////////////////////
//////Templates/////////////////
data "template_file" "deploy-chef-automate" {
  template = "${file("${path.module}/../templates/deploy-chef-automate")}"
}
```

2. Add the executable within the `aws_instance` resource of `projectname.tf`     e.g.
```
provisioner "file" {
    content     = "${data.template_file.deploy-chef-automate.rendered}"
    destination = "/tmp/deploy-chef-automate.sh"
}

provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/deploy-chef-automate.sh",
        "sudo /tmp/deploy-chef-automate.sh",
    ]
}
```


# Requirements:
 - Automate requires t2.large
