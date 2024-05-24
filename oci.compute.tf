resource "tls_private_key" "ssh_key" {
  count = var.compute_ssh_key == null ? 1 : 0

  algorithm = var.created_ssh_key_algorithm
}
