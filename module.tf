data "external" "vault_token" {
  program = ["bash", "${path.module}/scripts/approle.sh"]

  query = {
    vault_addr = "${var.vault_addr}"
    secret_id = "${var.secret_id}"
    role_id = "${var.role_id}"
  }
}

output "vault_token" {
  value = "${data.external.vault_token.result["vault_token"]}"
}