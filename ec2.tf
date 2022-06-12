#Specify key pair 
resource "aws_key_pair" "Stack_KP" {
  key_name   = "stack_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Declare local variables
locals {
  prefix = "clixx"
  version = "-1.0"
}

#Extract subnet id from given VPC
data "aws_subnets" "stack_subs" {
  filter {
    name = "vpc-id"
    values = ["var.vpc_id"]
  }
}

data "aws_subnet" "stack_subnets" {
  for_each = data.aws_subnets.stack_subs.ids
  id       = each.value
}

#Print to standard out subnet id that has been iterated from given VPC
output "subnet_id" {
  #value = [for s in data.aws_subnet.stack_subnets : s.cidr_block]
  value = [for s in data.aws_subnet.stack_subnets : s.id]
}

resource "aws_instance" "Server" {
  for_each = data.aws_subnet_ids.stack_sub_id_list.ids  //create an ec2 instance for each existing subnet
  subnet_id     = each.key  //Create an EC2 Instance for each subnet
#   ami           = data.aws_ami.stack_ami.id
  ami = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.stack-sg.id]
  user_data = file("./scripts/bootstrap.tpl")
  key_name = aws_key_pair.Stack_KP.key_name
#  subnet_id = var.subnet
 root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
    encrypted= "false"
  }
  tags = {
   Name        = "Stack-Dev-Server-${each.key}"
   Environment = var.environment
   OwnerEmail  = var.tag_owner_email
  }

}