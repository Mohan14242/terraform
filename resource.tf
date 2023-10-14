resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = true

    tags=merge(
        var.common_tags,
        {
            Name=var.project_name
        },
        var.vpc_tags
    )
    
  
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    map_public_ip_on_launch = true
     vpc_id = aws_vpc.main.id
    availability_zone = local.azs[count.index]
    cidr_block = var.public_subnet_cidr[count.index]
    tags=merge(
        {
            Name=var.public_subnet_tags[count.index]
        },
    
    
    )

  
}


resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.main.id
    availability_zone = local.azs[count.index]
    cidr_block = var.private_subnet_cidr[count.index]
    tags=merge(
        {
            Name=var.private_subnet_tags[count.index]
        },
    
    
    )

  
}
resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.main.id
  
}

resource "aws_subnet" "databse" {
    count = length(var.database_subnet_cidr)
    
    vpc_id = aws_vpc.main.id
    availability_zone = local.azs[count.index]
    cidr_block = var.database_subnet_cidr[count.index]
    tags=merge(
        {
            Name=var.database_subnet_tags[count.index]
        }
    
    
    )

  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IG.id
    }
    tags={
        Name="public _route_table"
    }
   
  
}
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.example.id
    }
    tags ={
        Name="prvate route_table"
    }

   
  
}
resource "aws_route_table" "database" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.example.id
    }
    tags={
        Name="database_route_table"
    }

  
}
resource "aws_route_table_association" "public_association" {
    count = length(var.public_subnet_cidr)
    subnet_id = var.public_subnet_ids[count.index]
    route_table_id = aws_route_table.public.id
   
   
  
}
resource "aws_route_table_association" "private_association" {
    count = length((var.private_subnet_cidr))
    subnet_id = var.private_subnet_ids[count.index]
    route_table_id = aws_route_table.private.id
  

}
resource "aws_route_table_association" "database_association" {
    count = length(var.database_subnet_cidr)
    subnet_id = var.database_subnet_ids[count.index]
    route_table_id = aws_route_table.database.id
}

resource "aws_eip" "eip" {
    domain = "vpc"
  
}
resource "aws_nat_gateway" "example" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public[0].id

    tags = {
      Name="NAT gateway"
    }
  
  depends_on = [ aws_internet_gateway.IG ]
}

resource "aws_db_subnet_group" "roboshop" {
    name=var.project_name
    subnet_ids = aws_subnet.databse[*].id


  
}



# resource "aws_internet_gateway" "IG" {
#     vpc_id = aws_vpc.vpc.id
  
#   tags=merge(
#     var.common_tags
#   )
# }


# resource "aws_subnet" "public" {
#     cidr_block = "10.0.1.0/26"
#     vpc_id = aws_vpc.vpc.id
  
# }
# resource "aws_subnet" "private" {
#     cidr_block = "10.0.11.0/26"
#     vpc_id = aws_vpc.vpc.id
  
# }
# resource "aws_subnet" "database" {
#     cidr_block = "10.0.12.0/26"
#     vpc_id = aws_vpc.vpc.id
  
# }

