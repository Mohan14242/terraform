variable "cidr_block" {

  
}

variable "enable_dns_hostnames" {
    default = true
  
}

variable "common_tags" {
    default = {}
  
}

variable "project_name" {
  
}
variable "vpc_tags" {
    default = {}
  
}

variable "public_subnet_cidr" {
    type = list 
    validation {
      condition = length(var.public_subnet_cidr) ==2
      error_message = "please provode two public network cidr ocl y"
    }
  
}

variable "public_subnet_tags" {
    default = ["public_subnet1","public_subnet2"]
  
}
variable "private_subnet_cidr" {
    type = list 
    validation {
      condition = length(var.private_subnet_cidr)==2
      error_message = "please enter the two cidr values for subnets"
    }
  
}
variable "private_subnet_tags" {
  
  default = ["private_subnet1","private_subnet2"]
}

variable "database_subnet_cidr" {
    type=list 
    validation {
      condition = length(var.database_subnet_cidr) ==2
      error_message = "please enter only two data base subntes only"
    }
    
  
}

variable "database_subnet_tags" {
    default = ["database_subnet1","database_subnet2"]
  
}

variable "public_route_tags" {
    default = ["public_route_table"]
  
}
variable "private_route_tags" {
    default = ["private_route_table"]
  
}
variable "database_route_tags" {
    default = ["database_route_table"]
  
}
variable "public_subnet_ids" {

  
}
variable "private_subnet_ids" {
  
}
variable "database_subnet_ids" {
  
}

