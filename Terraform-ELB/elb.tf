# resource for ELB configuration
resource "aws_elb" "my-aws-elb" {
  name            = "my-aws-elb"
  security_groups = [aws_security_group.aws-elb-sg.id]
  subnets         = [aws_subnet.elb-public-subnet1.id, aws_subnet.elb-public-subnet2.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "my-aws-elb"
  }
}