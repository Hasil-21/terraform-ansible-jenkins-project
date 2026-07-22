resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory_generated.ini"
  content = <<-EOT
    [app]
    appserver ansible_host=${aws_instance.app.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/DemoKeyPair.pem
  EOT
}
