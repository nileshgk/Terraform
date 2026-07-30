#AWS DB Parameter Group for MariaDB
resource "aws_db_parameter_group" "aws_parameter" {
    name        = "mariadb-parameter-group"
    family      = "mariadb10.11"
    
    parameter {
        name  = "max_connections"
        value = "50"
    }
    
    tags = {
        Name        = "mariadb-parameter-group"
        environment = var.vpc_environment
    }
  
}
# RDS Subnet Group
resource "aws_db_subnet_group" "mariadb_subnet_group" {
  name       = "mariadb-subnet-group"
  subnet_ids = [aws_subnet.AWS_pvt_subnet1.id, aws_subnet.AWS_pvt_subnet2.id]

  tags = {
    Name        = "mariadb-subnet-group"
    environment = var.vpc_environment
  }
}

# RDS Instance for MariaDB
resource "aws_db_instance" "mariadb" {
  allocated_storage         = 20                         # Provision 20 GB of storage
  storage_type              = "gp3"
  db_name                   = var.db_name
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  identifier                = "mariadb"                  # Unique identifier for the RDS instance
  instance_class            = "db.t3.micro"              # Instance class for the RDS instance
  vpc_security_group_ids    = [aws_security_group.vpc_aws_mariadb_sg.id] # Associate the security group
  db_subnet_group_name      = aws_db_subnet_group.mariadb_subnet_group.name # Associate the DB subnet group
  username                  = var.db_username
  password                  = var.db_password
  parameter_group_name      = aws_db_parameter_group.aws_parameter.name # Associate the DB parameter group
  skip_final_snapshot       = true
  backup_retention_period    = 0                      # Retain backups for 0 day
  multi_az                  = false                   # Set to true for high availability
  publicly_accessible       = false                   # Set to true if you want the RDS instance to be publicly accessible

    tags = {
        Name        = "mariadb-instance"
        environment = var.vpc_environment
    }       
}

   