variable "aws_region" {
  description = "AWS region donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile a usar"
  type        = string
  default     = "aws-academy"
}

variable "instance_count" {
  description = "Número de instancias EC2 a crear"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Nombre del proyecto para tags"
  type        = string
  default     = "chaos-demo"
}
