provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "devops_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Exemple d'AMI Ubuntu
  instance_type = "t2.micro"

  tags = {
    Name = "Jenkins-Deployed-EC2"
  }
}

output "instance_ip" {
  value = aws_instance.devops_server.public_ip
}
