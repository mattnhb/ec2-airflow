resource "aws_security_group" "acesso-ssh" {
    name = "acesso-ssh"
    description = "acesso-ssh"
    ingress {
      cidr_blocks = ["189.4.60.204/32"]
      description = "acesso-ssh"
      from_port = 22
      protocol = "tcp"
      to_port = 22
    }
    ingress {
      cidr_blocks = ["189.4.60.204/32"]
      description = "airflow"
      from_port = 8080
      protocol = "tcp"
      to_port = 8080
    }
    tags = {
        "Name" = "ssh"
        }
}

resource "aws_security_group" "acesso-externo" {
    name = "acesso-externo"
    description = "acesso-externo"
    egress {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "HTTP"
        from_port = 80
        protocol = "tcp"
        to_port = 80
        }
    egress {
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "HTTPS"
        from_port = 443
        protocol = "tcp"
        to_port = 443
        }
        tags = {
        "Name" = "http/https"
        }
}