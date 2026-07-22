resource "aws_db_subnet_group" "main" {
  name = "jenkins-db-subnet-group"
  subnet_ids = [aws_subnet.private.id,aws_subnet.private2.id]

  tags = {
    Name = "jenkins-db-subnet-group"
  }
}


resource "aws_db_instance" "postgres" {
  identifier = "jenkins-postgres" 
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = "appdb"
  username = "appadmin"
  password = var.db_password
  engine = "postgres"
  engine_version = "18.3"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot = true
  publicly_accessible = false
}
