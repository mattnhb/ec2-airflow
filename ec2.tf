resource "aws_instance" "instance" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.large"

  tags = {
        Name = "airflow"
    }

  key_name               = "terraform-aws"
  vpc_security_group_ids = [aws_security_group.acesso-ssh.id,
                            aws_security_group.acesso-externo.id]
  user_data              = data.template_file.user_data.rendered
  
}