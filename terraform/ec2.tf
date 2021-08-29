data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "nv-project-host" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  key_name 	  = aws_key_pair.deployer-with-ssh.key_name
  security_groups = [aws_security_group.ubuntu.name]
  associate_public_ip_address = true
  user_data       = file("installation.sh")
  tags = {
     Name = "ec-2-Jenkins"
  }
  depends_on = [aws_instance.nv-project-host]
}

# --- Association with key in order to ssh --- 
resource "aws_key_pair" "deployer-with-ssh" {
  key_name   = var.key_name
  public_key = file("~/.ssh/authorized_keys")
}
# --- Security group --- 
resource "aws_security_group" "ubuntu" {
  name        = "ubuntu-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"
  

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
