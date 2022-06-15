resource "aws_security_group" "security-web" {
  name        = "WIM-${var.env5}-security-group"
  description = "WIM-${var.env5} security group"
  vpc_id      = aws_vpc.jenkins.id
  dynamic "ingress" {
    for_each = local.port
    content {
      description = "description ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
