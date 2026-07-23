resource "aws_security_group" "jenkins"{
  name = "jenkins-sg"
  description = "Allow SSH and Jenkins UI access"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins UI"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { 
    from_port = 0
    to_port = 0	
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}


resource "aws_security_group" "alb" {
  name = "alb-sg"
  description = "Allow HTTP from internet"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}


resource "aws_security_group" "app" {
  name        = "app-sg"
  description = "Allow HTTP from ALB and SSH from Jenkins"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from jenkins"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.jenkins.id]
  }

  ingress {
    description = "HTTP from ALB"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}


resource "aws_security_group" "db"{
  name = "db-sg"
  description = "Allow Postgres from app servers only"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Postgres from app-sg"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}
