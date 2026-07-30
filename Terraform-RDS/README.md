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