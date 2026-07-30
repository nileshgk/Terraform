🔑 SSH Configuration
Before running terraform apply, you must generate an SSH key pair to secure your instance:

Generate keys:
Bash
ssh-keygen -t rsa -b 2048 -f keys/AWS-EC2
(Press Enter twice to leave the passphrase empty).

Security: * AWS-EC2 (Private) - KEEP PRIVATE. Never commit this to Git.

AWS-EC2.pub (Public) - Used by Terraform to authorize your access.

CMD For SSH into instance 
ssh -i .\keys\AWS-EC2 ec2-user@<EC2_PUBLIC_IP>

After login to instance follow below set to ssh to DB
sudo apt-get update
sudo apt-get install mysql-client
mysql -u {userName} -h {host name} -p'{pwd}'
exit

single line (Ubantu)
sudo apt-get update && sudo apt-get install -y mysql-client && mysql -u {userName} -h {host name} -p'{pwd}'
Amazon Linux 2:
sudo yum update -y && sudo yum install -y mariadb && mysql -u {userName} -h {host name} -p'{pwd}'

Amazon Linux 2023 (AL2023):
sudo dnf update -y
sudo dnf install -y mariadb105 
mysql -u {admin} -h {HOST} -P 3306 -p'PWD'

after login to DB type( view default data):
SHOW DATABASES;