resource "aws_instance" "app" {
  ami = "ami-006f82a1d5a27da54"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name = "DemoKeyPair"
  associate_public_ip_address = true 

  tags = {
    Name = "app-server"
  }
}


resource "aws_lb" "app" {
  name = "app-alb"
  subnets = [aws_subnet.public.id,aws_subnet.public2.id]
  internal = false
  load_balancer_type = "application" 
  security_groups = [aws_security_group.alb.id]
}


resource "aws_lb_target_group" "app" {
  name = "app-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

  health_check {
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 15
  }
}


resource "aws_alb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id = aws_instance.app.id
  port = 80	
}


resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
} 
