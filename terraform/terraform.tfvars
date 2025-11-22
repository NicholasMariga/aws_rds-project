region = "us-east-1"

project_name = "rds-project"

# Replace with your public IP /32 to restrict SSH
my_ip_cidr = "0.0.0.0/0"

# EC2 key pair name you already created/imported in AWS
key_name = "ssh/terraformkey.pub"

db_username       = "admin"
db_password       = "ChangeMeStrongPassword"
db_name           = "app_db"
db_instance_class = "db.t3.micro"
# AMI for bastion (Amazon Linux 2 recommended)
bastion_ami           = "ami-0c02fb55956c7d316"
instance_type_bastion = "t3.micro"
