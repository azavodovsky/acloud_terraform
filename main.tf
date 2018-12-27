resource "openstack_compute_instance_v2" "artic-instance-1" {
  name            = "artic-instance-1"
  image_id        = "8de5e01b-ae70-48aa-9812-ebbb5042ba19"
  flavor_name      = "${var.instance_type}"
  key_pair        = "${openstack_compute_keypair_v2.arctic-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.arctic-secgroup.name}"]

   provisioner "local-exec" {
 command = "sleep 120;ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -s -i \"${openstack_compute_instance_v2.artic-instance-1.access_ip_v4},\" --key-file=~/.ssh/id_pub ansible/artic-playbook.yml"

  }

  network {
    name = "public_network"
  }
}
resource "openstack_compute_instance_v2" "artic-instance-2" {
  name            = "artic-instance-2"
  image_id        = "8de5e01b-ae70-48aa-9812-ebbb5042ba19"
  flavor_name      = "${var.instance_type}"
  key_pair        = "${openstack_compute_keypair_v2.arctic-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.arctic-secgroup.name}"]


     provisioner "local-exec" {
 command = "sleep 120;ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -s -i \"${openstack_compute_instance_v2.artic-instance-1.access_ip_v4},\" --key-file=~/.ssh/id_pub ansible/artic-playbook.yml"

  }


  network {
    name = "public_network"
  }
}

resource "openstack_compute_secgroup_v2" "arctic-secgroup" {
  name        = "arctic-secgroup"
  description = "a security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
