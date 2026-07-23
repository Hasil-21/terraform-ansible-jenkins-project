resource "aws_instance" "jenkins-controller"{
  ami = "ami-006f82a1d5a27da54"
  instance_type = "t3.small"
  subnet_id = aws_subnet.public.id
  key_name = "DemoKeyPair"
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  associate_public_ip_address = true   

  tags ={
    Name = "jenkins-controller"
  }
}
