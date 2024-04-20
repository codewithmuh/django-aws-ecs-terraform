# RDS Subnet Group
resource "aws_db_subnet_group" "private_db_subnet" {
  name        = "mysql-rds-private-subnet-group"
  description = "Private subnets for RDS instance"
  # Subnet IDs must be in two different AZ. Define them explicitly in each subnet with the availability_zone property
  subnet_ids = var.subnet_ids
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Allow inbound/outbound MySQL traffic"
  vpc_id      = var.vpc_id
  #depends_on  = [aws_vpc.main]
}
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = var.vpc_id
  #depends_on  = [aws_vpc.main]
}

resource "aws_security_group_rule" "allow_mysql_in" {
  description              = "Allow inbound MySQL connections"
  type                     = "ingress"
  from_port                = "3306"
  to_port                  = "3306"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.default.id
  security_group_id        = aws_security_group.rds_sg.id
}


# RDS Instance
resource "aws_db_instance" "mysql_8" {
  allocated_storage = 10               # Storage for instance in gigabytes
  identifier        = "codeherk-tf-db" # The name of the RDS instance
  storage_type      = "gp2"            # See storage comparision <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#storage-comparison>
  engine            = "mysql"          # Specific Relational Database Software <https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html#Welcome.Concepts.DBInstance>

  # InvalidParameterCombination: RDS does not support creating a DB instance with the following combination: DBInstanceClass=db.t4g.micro, Engine=mysql, EngineVersion=5.7.41,
  # <https://aws.amazon.com/about-aws/whats-new/2021/09/amazon-rds-t4g-mysql-mariadb-postgresql/>
  engine_version = "8.0.32"
  instance_class = "db.t4g.micro" # See instance pricing <https://aws.amazon.com/rds/mysql/pricing/?pg=pr&loc=2>
  multi_az       = true

  # mysql -u dbadmin -h <ENDPOINT> -P 3306 -D sample -p
  db_name  = "sngine" # name is deprecated, use db_name instead
  username = "admin"
  password = data.aws_ssm_parameter.db_password.value

  db_subnet_group_name = aws_db_subnet_group.private_db_subnet.name # Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group.
  # Error: final_snapshot_identifier is required when skip_final_snapshot is false
  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]
}



# Reference an SSM parameter for the password (already created in AWS Console)
data "aws_ssm_parameter" "db_password" {
  name = "/dev/goapi/db/password"
}

# Create an IAM instance profile for the EC2 instance
resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.instance_role.name
}

# Create an IAM role for the EC2 instance
resource "aws_iam_role" "instance_role" {
  name = "ec2-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the necessary IAM policy to the instance role
resource "aws_iam_role_policy_attachment" "instance_policy_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}