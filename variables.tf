variable "global_domain" {
  description = "Openstack global domain"
}
variable "global_username" {
  description = "Openstack global username"
}
variable "global_auth_url" {
  description = "Openstack global auth url"
}
variable "api_password" {
  description = "Openstack global auth url"
}
variable "instance_type" {
  description = "Openstack global auth url"
}
variable "ssh_key"{
  description = "SSH key for provision"
}
variable "ssh_key_file" {
  description = "SSH key for provision"
}
variable "instance_zone" {
  description = "availability_zone"
  default = "SV1"
}