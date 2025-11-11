output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = aws_lb.chaos_demo.dns_name
}

output "alb_url" {
  description = "URL completa del Application Load Balancer"
  value       = "http://${aws_lb.chaos_demo.dns_name}"
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "autoscaling_group_arn" {
  description = "ARN del Auto Scaling Group"
  value       = aws_autoscaling_group.web.arn
}

output "min_size" {
  description = "Mínimo de instancias en el ASG"
  value       = aws_autoscaling_group.web.min_size
}

output "max_size" {
  description = "Máximo de instancias en el ASG"
  value       = aws_autoscaling_group.web.max_size
}

output "desired_capacity" {
  description = "Capacidad deseada del ASG"
  value       = aws_autoscaling_group.web.desired_capacity
}

output "target_group_arn" {
  description = "ARN del Target Group"
  value       = aws_lb_target_group.web.arn
}

output "ami_id" {
  description = "ID del AMI usado para las instancias"
  value       = data.aws_ami.amazon_linux_2.id
}

output "ami_name" {
  description = "Nombre del AMI usado"
  value       = data.aws_ami.amazon_linux_2.name
}
