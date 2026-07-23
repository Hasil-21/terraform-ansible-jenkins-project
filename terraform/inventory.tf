resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory_generated.ini"
  content = <<-EOT
    [app]
    appserver ansible_host=${aws_instance.app.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/DemoKeyPair.pem
    
    [jenkins]
    jenkinscontroller ansible_host=${aws_instance.jenkins-controller.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/DemoKeyPair.pem
  EOT
}
