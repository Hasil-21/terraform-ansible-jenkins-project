output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}


output "private_subnet_id" {
  value = aws_subnet.private.id
}


output "jenkins_sg_id" {
  value = aws_security_group.jenkins.id
}


output "app_sg_id" {
  value = aws_security_group.app.id
}


output "db_sg_id" {
  value = aws_security_group.db.id
}


output "alb_sg_id" {
  value = aws_security_group.alb.id
}


output "rds_endpoint"{
  value = aws_db_instance.postgres.endpoint
}


output "alb_dns_name"{
  value = aws_lb.app.dns_name
}


output "app_instance_private_ip"{
  value = aws_instance.app.private_ip
}

output "jenkins_instance_private_ip"{
  value = aws_instance.jenkins-controller.private_ip
}

output "jenkins_instance_id"{
  value = aws_instance.jenkins-controller.id
}
