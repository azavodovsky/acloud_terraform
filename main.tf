resource "openstack_compute_instance_v2" "arctic-instance-1" {
  name = "arctic-instance-1"
  availability_zone = "${var.instance_zone}"
  flavor_name = "${var.instance_type}"
  key_pair = "${openstack_compute_keypair_v2.arctic-keypair.name}"
  security_groups = [
    "${openstack_compute_secgroup_v2.arctic-secgroup.name}"]

  block_device {
    uuid = "8de5e01b-ae70-48aa-9812-ebbb5042ba19"
    source_type = "image"
    volume_size = 50
    boot_index = 0
    destination_type = "volume"
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y install python"]
    connection {
      type = "ssh"
      user = "debian"
      private_key = "${file(var.ssh_key)}"
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -s -i \"${openstack_compute_instance_v2.arctic-instance-1.access_ip_v4},\" --private-key ${var.ssh_key_file} ansible/arctic-server-playbook.yml"

  }

   network {
     name = "public_network"
 }



  network {
    name = "${openstack_networking_network_v2.arctic_network_1.name}"
    fixed_ip_v4 = "192.168.199.44"
  }

}




resource "openstack_compute_instance_v2" "arctic-instance-2" {
  name            = "arctic-instance-2"
  availability_zone = "${var.instance_zone}"
  flavor_name     = "${var.instance_type}"
  key_pair        = "${openstack_compute_keypair_v2.arctic-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.arctic-secgroup.name}"]

    block_device {
    uuid                  = "8de5e01b-ae70-48aa-9812-ebbb5042ba19"
    source_type           = "image"
    volume_size           = 50
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = ["sudo apt-get -y install python"]
    connection {
      type        = "ssh"
      user        = "debian"
      private_key = "${file(var.ssh_key)}"
    }
  }



     provisioner "local-exec" {
     command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -s -i \"${openstack_compute_instance_v2.arctic-instance-2.access_ip_v4},\" --private-key ${var.ssh_key_file} ansible/arctic-client-playbook.yml"

  }


  network {
    name = "public_network"
  }
   network {
    name="${openstack_networking_network_v2.arctic_network_1.name}"
    fixed_ip_v4 = "192.168.199.55"
  }

}

resource "openstack_compute_secgroup_v2" "arctic-secgroup" {
  name        = "arctic-secgroup"
  description = "a security group"

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

    rule {
      from_port = -1
      to_port = -1
      ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_networking_network_v2" "arctic_network_1" {
  name           = "artic_network_1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "subnet_1"
  network_id = "${openstack_networking_network_v2.arctic_network_1.id}"
  cidr       = "192.168.199.0/24"
  ip_version = 4
}