# Chaos Engineering Demo con AWS y Terraform

Demo práctica de Chaos Engineering usando Terraform, AWS y Chaos Monkey.

## 📋 Estructura del Proyecto

```
chaos-demo/
├── main.tf              # Infraestructura principal (VPC, EC2, ALB)
├── outputs.tf           # Outputs de Terraform
├── variables.tf         # Variables configurables
├── chaos_monkey.py      # Script para terminar instancias
├── monitor.py           # Script para monitorear el sistema
├── requirements.txt     # Dependencias Python
└── README.md           # Este archivo
```

## 🚀 Inicio Rápido

### 1. Pre-requisitos

```bash
# Instalar Terraform
# https://developer.hashicorp.com/terraform/downloads

# Configurar AWS CLI
aws configure
# Ingresar: Access Key ID, Secret Access Key, Region (us-east-1)

# Instalar dependencias Python
pip install -r requirements.txt
```

### 2. Desplegar Infraestructura

```bash
# Inicializar Terraform
terraform init

# Ver plan de ejecución
terraform plan

# Aplicar cambios
terraform apply

# Guardar el DNS del ALB
export ALB_DNS=$(terraform output -raw alb_dns_name)
echo $ALB_DNS
```

### 3. Verificar Despliegue

```bash
# Esperar 2-3 minutos para que las instancias estén listas

# Ver instancias
aws ec2 describe-instances \
  --filters "Name=tag:ChaosMonkey,Values=enabled" \
  --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],InstanceId,State.Name]' \
  --output table

# Probar el ALB
curl http://$ALB_DNS
```

### 4. Ejecutar Demo

**Terminal 1 - Monitor:**
```bash
python3 monitor.py --alb-dns $ALB_DNS --duration 300 --interval 5
```

**Terminal 2 - Chaos Monkey:**
```bash
python3 chaos_monkey.py --interval 30 --iterations 3
```

**Terminal 3 - Navegador:**
```bash
# Abrir en navegador y refrescar varias veces
echo "http://$ALB_DNS"
```

### 5. Limpieza

```bash
# Destruir toda la infraestructura
terraform destroy

# Confirmar con: yes
```

## 🏗️ Arquitectura

- **VPC**: Red privada virtual con 2 subnets públicas
- **EC2**: 3 instancias t2.micro con Apache
- **ALB**: Application Load Balancer distribuyendo tráfico
- **Security Groups**: Reglas de firewall para web (80) y SSH (22)

## 💰 Costos Estimados

- 3x t2.micro: ~$0.03/hora
- 1x ALB: ~$0.025/hora
- **Total**: ~$0.06/hora ($0.015 por 15 minutos)

## 🔧 Troubleshooting

### Las instancias no responden

```bash
# Verificar security groups
aws ec2 describe-security-groups --group-names chaos-demo-web-sg

# Ver logs de user data
aws ec2 get-console-output --instance-id <INSTANCE_ID>
```

### El ALB no responde

```bash
# Verificar health del target group
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw target_group_arn)
```

## 📚 Recursos

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Chaos Monkey Original](https://github.com/Netflix/chaosmonkey)
- [Principles of Chaos Engineering](https://principlesofchaos.org/)
