terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# VPC y Networking
resource "aws_vpc" "chaos_demo" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "chaos-demo-vpc"
  }
}

resource "aws_internet_gateway" "chaos_demo" {
  vpc_id = aws_vpc.chaos_demo.id

  tags = {
    Name = "chaos-demo-igw"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.chaos_demo.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "chaos-demo-public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.chaos_demo.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "chaos-demo-public-2"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.chaos_demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.chaos_demo.id
  }

  tags = {
    Name = "chaos-demo-public-rt"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# Security Groups
resource "aws_security_group" "web_servers" {
  name        = "chaos-demo-web-sg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.chaos_demo.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "chaos-demo-web-sg"
  }
}

resource "aws_security_group" "alb" {
  name        = "chaos-demo-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.chaos_demo.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "chaos-demo-alb-sg"
  }
}

# Buscar el AMI más reciente de Amazon Linux 2
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# User data script para las instancias
data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd ec2-instance-connect
    systemctl start httpd
    systemctl enable httpd
    
    INSTANCE_ID=$(ec2-metadata --instance-id | cut -d " " -f 2)
    AZ=$(ec2-metadata --availability-zone | cut -d " " -f 2)
    
    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
        <title>Chaos Demo - Server $INSTANCE_ID</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            .container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                text-align: center;
            }
            h1 { color: #333; margin-bottom: 20px; }
            .info { 
                background: #f0f0f0; 
                padding: 20px; 
                border-radius: 8px; 
                margin: 20px 0;
            }
            .instance-id { 
                color: #667eea; 
                font-weight: bold; 
                font-size: 1.5em;
            }
            .status {
                color: #10b981;
                font-weight: bold;
                font-size: 1.2em;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🚀 Chaos Engineering Demo</h1>
            <div class="info">
                <p>Servidor Activo:</p>
                <p class="instance-id">$INSTANCE_ID</p>
                <p><strong>Zona:</strong> $AZ</p>
                <p><strong>Timestamp:</strong> <span id="time"></span></p>
            </div>
            <div class="status">✅ Sistema Operativo</div>
            <p style="color: #666; margin-top: 20px;">
                Este servidor puede ser terminado por Chaos Monkey en cualquier momento...
            </p>
        </div>
        <script>
            setInterval(() => {
                document.getElementById('time').textContent = new Date().toLocaleTimeString();
            }, 1000);
        </script>
    </body>
    </html>
    HTML
    
    sed -i "s/\$INSTANCE_ID/$INSTANCE_ID/g" /var/www/html/index.html
    sed -i "s/\$AZ/$AZ/g" /var/www/html/index.html
  EOF
}

# EC2 Instances - COMENTADO: Ahora usamos Auto Scaling Group (ver autoscaling.tf)
# Las instancias se crean automáticamente por el ASG
# resource "aws_instance" "web" {
#   count                  = 3
#   ami                    = data.aws_ami.amazon_linux_2.id
#   instance_type          = "t2.micro"
#   subnet_id              = count.index < 2 ? aws_subnet.public_1.id : aws_subnet.public_2.id
#   vpc_security_group_ids = [aws_security_group.web_servers.id]
#   user_data              = data.template_file.user_data.rendered
#
#   tags = {
#     Name        = "chaos-demo-web-${count.index + 1}"
#     ChaosMonkey = "enabled"
#   }
# }

# Application Load Balancer
resource "aws_lb" "chaos_demo" {
  name               = "chaos-demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  tags = {
    Name = "chaos-demo-alb"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "chaos-demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.chaos_demo.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "chaos-demo-tg"
  }
}

# Target Group Attachment - COMENTADO: Auto Scaling Group lo maneja automáticamente
# resource "aws_lb_target_group_attachment" "web" {
#   count            = 3
#   target_group_arn = aws_lb_target_group.web.arn
#   target_id        = aws_instance.web[count.index].id
#   port             = 80
# }

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.chaos_demo.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
