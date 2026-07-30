# Load Balancer DNS Name (URL to access your application)
output "elb_dns_name" {
  description = "The public DNS name of the Classic Load Balancer"
  value       = aws_elb.my-aws-elb.dns_name
}

# Auto Scaling Group Name
output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.aws-elb-asg.name
}

# Auto Scaling Group ARN
output "autoscaling_group_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.aws-elb-asg.arn
}

# Launch Template Name
output "launch_template_name" {
  description = "The name of the Launch Template"
  value       = aws_launch_template.aws-elb-launchtemplate.name
}

# Launch Template ID
output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.aws-elb-launchtemplate.id
}