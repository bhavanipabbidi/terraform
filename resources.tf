resource "aws_instance" "web" {
  ami           = "ami-01a4f99c4ac11b03c"
  instance_type = "t2.micro"
user_data = file("./scripts/httpd.sh")
vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  tags = {
    Name = "HelloWorld"
  }
}


resource "aws_security_group" "webserver_sg" {
  name        = "webserver SG"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "webserver port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "webserver_sg"
  }
}
