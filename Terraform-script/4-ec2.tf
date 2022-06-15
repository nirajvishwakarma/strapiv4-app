resource "aws_instance" "jenkins-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2-key
  subnet_id              = aws_subnet.jenkins-public.id
  vpc_security_group_ids = [aws_security_group.security-web.id]
  user_data              = file("user-data.sh")
  tags = {
    "Name" = "WIM-Jenkins-Server"
  }
  root_block_device {
    volume_size = 30 # in GB <<----- I increased this!
    volume_type = "gp2"
  }

}


resource "aws_iam_role" "ec2_ecr_role" {
  name = "ec2_ecr_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.ec2_ecr_role.name
}
