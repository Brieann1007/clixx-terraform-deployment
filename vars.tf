variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
 default = "us-east-1"
}

variable "a_zone" {
    default = "us-east-1b"
}

variable "PATH_TO_PRIVATE_KEY" {
    default = "stackkp"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "stackkp.pub"
}

variable "vpc_id" {
    default = "vpc-01dbe7bbbdd6c600e"
}

variable "subnet_ids" {
    type = list(string)
    default = [ "subnet-06dccc47694cd91cb",
"subnet-0ab5181a629cd9ece",
"subnet-0d564be42904e8d8e",
"subnet-0e30fff53cc3bf14b",
"subnet-01f4a6b504970cccc",
"subnet-0fb825aae345d856b",
"subnet-07c2a26e5041eb0d4", ]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "environment" {
  default = "Dev"
}

variable "tag_owner_email" {
  default = "briean1007@gmail.com"
}

variable "ami_id" {
    default = "ami-0022f774911c1d690"
}