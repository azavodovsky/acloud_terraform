output "instance_ip_1" {
  value = "${openstack_compute_instance_v2.arctic-instance-1.access_ip_v4}"
}
output "instance_ip_2" {
  value = "${openstack_compute_instance_v2.arctic-instance-2.access_ip_v4}"
}