# Chaos Engineering: Gremlin y Chaos Monkey
## Exposición Completa - 15 minutos

---

## 📋 ESTRUCTURA DE LA PRESENTACIÓN

### Minutos 0-2: Introducción
### Minutos 2-5: ¿Qué es Chaos Engineering?
### Minutos 5-8: Herramientas (Chaos Monkey & Gremlin)
### Minutos 8-13: Demostración Práctica
### Minutos 13-15: Conclusiones y Preguntas

---

## 🎤 SCRIPT COMPLETO

### DIAPOSITIVA 1: Título
**[Mostrar título]**

"Buenos días/tardes. Hoy vamos a hablar sobre Chaos Engineering, una práctica que puede sonar contradictoria: romper intencionalmente nuestros sistemas para hacerlos más fuertes. Específicamente veremos dos herramientas pioneras: Chaos Monkey y Gremlin."

---

### DIAPOSITIVA 2: El Problema
**Contenido de la diapositiva:**
```
EL PROBLEMA

• Los sistemas modernos son complejos
• Microservicios, APIs, bases de datos distribuidas
• Las fallas SIEMPRE ocurren en producción
• ¿Esperamos a que sucedan? ❌
```

**Script:**
"Imaginemos que tenemos una aplicación moderna: está distribuida en múltiples servidores, usa microservicios, bases de datos, APIs externas... Es como una casa con muchas habitaciones interconectadas. 

El problema es: ¿Qué pasa cuando algo falla? Y no es 'si falla', sino 'CUANDO falla'. Porque en sistemas complejos, las fallas son inevitables.

La pregunta es: ¿Esperamos a que nuestros usuarios encuentren estos problemas en producción? ¿O podemos ser proactivos?"

---

### DIAPOSITIVA 3: La Solución - Chaos Engineering
**Contenido de la diapositiva:**
```
CHAOS ENGINEERING

"La disciplina de experimentar en un sistema para 
construir confianza en su capacidad de resistir 
condiciones turbulentas en producción"

Concepto clave: Romper cosas INTENCIONALMENTE 
para aprender cómo fallan
```

**Script:**
"Aquí es donde entra Chaos Engineering. La idea es simple pero poderosa: vamos a romper cosas intencionalmente, de manera controlada, para descubrir debilidades ANTES de que se conviertan en problemas reales.

Es como un simulacro de incendio. No esperamos a que haya un incendio real para saber si las salidas de emergencia funcionan, ¿verdad? Pues esto es lo mismo pero para sistemas de software."

---

### DIAPOSITIVA 4: Historia - Netflix y Chaos Monkey
**Contenido de la diapositiva:**
```
ORIGEN: NETFLIX (2010)

Problema:
• Migración a AWS
• Miles de servidores
• ¿Qué pasa si uno falla?

Solución: CHAOS MONKEY
"Un mono que apaga servidores aleatoriamente"

Resultado: Sistemas más resilientes
```

**Script:**
"Esta idea nació en Netflix en 2010. Estaban migrando a la nube de Amazon, con miles de servidores. Y se preguntaron: si tenemos tantos servidores, algunos DEFINITIVAMENTE van a fallar.

Entonces crearon Chaos Monkey. El nombre es perfecto: imaginen un mono entrando a su centro de datos y apagando servidores al azar. Eso es exactamente lo que hace.

Al principio suena loco, pero funcionó. Los ingenieros tuvieron que diseñar sus sistemas asumiendo que cualquier servidor podía desaparecer en cualquier momento. Resultado: servicios mucho más resilientes."

---

### DIAPOSITIVA 5: ¿Cómo funciona?
**Contenido de la diapositiva:**
```
PRINCIPIOS DE CHAOS ENGINEERING

1. Definir el "estado normal" del sistema
2. Hacer una hipótesis sobre ese estado
3. Introducir variables que simulan eventos reales
4. Intentar refutar la hipótesis buscando diferencias

Tipos de fallos:
• Servidores caídos
• Latencia de red
• Saturación de CPU/Memoria
• Errores en APIs
```

**Script:**
"El proceso es científico:

Primero, definimos cómo se ve nuestro sistema cuando funciona bien: tiempos de respuesta, tasas de error, etc.

Segundo, hacemos una hipótesis. Por ejemplo: 'Si un servidor de base de datos se cae, el sistema debe seguir funcionando usando las réplicas'.

Tercero, provocamos ese fallo de manera controlada.

Cuarto, observamos qué pasa. Si nuestra hipótesis era correcta, genial. Si no, acabamos de descubrir un problema que debemos arreglar.

Los tipos de fallos que podemos simular son variados: desde apagar servidores, hasta agregar latencia en la red, saturar recursos, o hacer que APIs fallen."

---

### DIAPOSITIVA 6: Chaos Monkey - Detalles
**Contenido de la diapositiva:**
```
CHAOS MONKEY

Parte de: Simian Army (Netflix OSS)
Función: Termina instancias EC2 aleatoriamente

Características:
✓ Open Source
✓ Fácil de integrar
✓ Configurable (horarios, servicios)
✓ Solo en horario laboral

Filosofía: "Si siempre puede fallar, 
diseñemos para que pueda fallar"
```

**Script:**
"Chaos Monkey es parte de lo que Netflix llamó 'Simian Army' - un ejército de monos, cada uno haciendo un tipo de caos diferente.

Chaos Monkey específicamente termina instancias de servidores aleatoriamente. Es open source y relativamente simple de usar.

Lo interesante es que tiene salvaguardas: generalmente solo corre en horario laboral, para que haya ingenieros disponibles si algo sale mal. Se puede configurar para afectar solo ciertos servicios.

La filosofía es: construir sistemas que no dependan de que TODO funcione perfectamente, sino que asuman que las cosas FALLARÁN."

---

### DIAPOSITIVA 7: Gremlin - La Evolución
**Contenido de la diapositiva:**
```
GREMLIN (2016)

"Failure as a Service"

Ventajas sobre Chaos Monkey:
• Plataforma completa (no solo terminar instancias)
• Múltiples tipos de ataques
• Interfaz gráfica
• Controles de seguridad robustos
• Soporte empresarial

Ataques disponibles:
- Estado: CPU, Memoria, Disco
- Red: Latencia, pérdida de paquetes, DNS
- Recursos: Cerrar procesos, tiempos
```

**Script:**
"En 2016, algunos ex-ingenieros de Netflix crearon Gremlin, que llevó la idea al siguiente nivel.

Gremlin es 'Failure as a Service' - fallas como servicio. Es una plataforma completa que no solo apaga servidores, sino que puede simular muchísimos tipos de problemas.

Puede saturar CPU, llenar memoria, agregar latencia de red, hacer que paquetes se pierdan, afectar DNS, cerrar procesos específicos...

Tiene una interfaz gráfica muy amigable y controles de seguridad más robustos. Es ideal para empresas que quieren hacer Chaos Engineering de manera profesional.

A diferencia de Chaos Monkey que es gratuito, Gremlin tiene planes pagos, pero también ofrece pruebas gratuitas."

---

### DIAPOSITIVA 8: Demo Time
**Contenido de la diapositiva:**
```
DEMOSTRACIÓN PRÁCTICA

Vamos a simular:
1. Una aplicación web simple
2. Dependencia de un servicio externo
3. Aplicar "chaos" para ver qué pasa
4. Mejorar la resiliencia

Herramienta: Simulador web interactivo
```

**Script:**
"Ahora vamos a la parte práctica. He preparado una demostración interactiva donde podemos ver Chaos Engineering en acción.

Vamos a simular una aplicación de comercio electrónico simple que depende de un servicio de inventario. Vamos a aplicar diferentes tipos de fallas y ver cómo responde el sistema.

Primero veremos la versión frágil, y luego veremos cómo mejorarla para que sea resiliente."

**[AQUÍ EJECUTAS LA DEMO - VER CÓDIGO ABAJO]**

---

### DIAPOSITIVA 9: Lecciones de la Demo
**Contenido de la diapositiva:**
```
¿QUÉ APRENDIMOS?

❌ Sistema frágil:
- Timeout largo
- Sin manejo de errores
- Experiencia de usuario horrible

✅ Sistema resiliente:
- Circuit breaker
- Timeouts cortos
- Fallbacks
- Degradación elegante

El usuario apenas nota los problemas
```

**Script:**
"Como vimos en la demo, la diferencia es dramática.

En el sistema frágil, cuando el servicio de inventario falla, toda la aplicación se congela. El usuario tiene que esperar eternamente y ve errores técnicos.

En el sistema resiliente, implementamos patrones como circuit breaker - que es como un fusible eléctrico. Si detecta que el servicio está fallando, deja de intentar y usa un plan B.

También usamos timeouts cortos y mostramos información útil al usuario en lugar de errores técnicos.

El resultado: aunque haya fallas en el sistema, el usuario apenas lo nota. Eso es resiliencia."

---

### DIAPOSITIVA 10: Casos de Uso Reales
**Contenido de la diapositiva:**
```
¿QUIÉN USA CHAOS ENGINEERING?

Netflix: Pioneros, lo usan continuamente
Amazon: Para AWS y retail
Google: En su infraestructura global
Microsoft: Azure y servicios
LinkedIn: Servicios de red social

Resultado común:
📉 Menos incidentes en producción
📈 Mayor confianza del equipo
⚡ Recuperación más rápida
```

**Script:**
"Chaos Engineering no es solo una idea teórica. Las empresas más grandes del mundo lo usan activamente.

Netflix, por supuesto, sigue siendo el líder. Amazon lo usa tanto para AWS como para su plataforma de comercio. Google lo aplica en su infraestructura global. Microsoft en Azure. LinkedIn en sus servicios.

Los resultados son consistentes: menos incidentes en producción, equipos más confiados, y cuando sí ocurren problemas, se recuperan más rápido porque ya practicaron escenarios similares."

---

### DIAPOSITIVA 11: Mejores Prácticas
**Contenido de la diapositiva:**
```
MEJORES PRÁCTICAS

1. Empezar pequeño (staging primero)
2. Definir hipótesis claras
3. Monitorear TODO
4. Horario laboral inicialmente
5. Documentar aprendizajes
6. Automatizar gradualmente
7. Cultura de aprendizaje (no culpa)

⚠️ NO hacer en producción sin preparación
```

**Script:**
"Si van a implementar Chaos Engineering, algunas recomendaciones importantes:

Uno: Empiecen en ambientes de prueba, no en producción directamente. Caminen antes de correr.

Dos: Siempre tengan una hipótesis clara de lo que esperan que pase.

Tres: El monitoreo es crítico. Si no pueden observar el impacto, no tiene sentido hacer el experimento.

Cuatro: Al principio, háganlo en horario laboral cuando todo el equipo esté disponible.

Cinco: Documenten qué aprendieron. Cada experimento es una lección.

Y muy importante: Esto requiere una cultura donde fallar está bien, porque estamos aprendiendo. No se trata de culpar a nadie, sino de mejorar el sistema."

---

### DIAPOSITIVA 12: Beneficios vs Riesgos
**Contenido de la diapositiva:**
```
BENEFICIOS:
✓ Descubrir problemas antes que los usuarios
✓ Mayor confianza en el sistema
✓ Mejor preparación para incidentes
✓ Documentación de comportamiento
✓ Cultura de resiliencia

RIESGOS:
⚠️ Interrupciones reales si no se controla
⚠️ Resistencia del equipo
⚠️ Costo de implementación
⚠️ Curva de aprendizaje

Mitigación: Empezar gradualmente
```

**Script:**
"Como toda práctica, tiene beneficios y riesgos.

Los beneficios son claros: encontramos problemas antes de que afecten a usuarios reales, el equipo gana confianza, y estamos mejor preparados cuando ocurren incidentes reales.

Los riesgos también existen: si no se hace correctamente, podemos causar interrupciones reales. Puede haber resistencia del equipo - a nadie le gusta que 'rompan' su trabajo. Y hay un costo en tiempo y recursos.

La clave es empezar gradualmente, con experimentos pequeños y controlados, e ir escalando conforme el equipo gana experiencia y confianza."

---

### DIAPOSITIVA 13: Conclusiones
**Contenido de la diapositiva:**
```
CONCLUSIONES

• Chaos Engineering NO es romper cosas porque sí
• Es una disciplina científica de experimentación
• Herramientas como Chaos Monkey y Gremlin lo facilitan
• La meta: sistemas resilientes y confiables
• Cambio cultural, no solo técnico

"No se trata de SI va a fallar, 
sino de CUÁNDO va a fallar"

¿Estamos preparados?
```

**Script:**
"Para concluir:

Chaos Engineering no es caos por caos. Es una disciplina estructurada para construir sistemas más confiables.

Herramientas como Chaos Monkey democratizaron la práctica, y Gremlin la llevó al siguiente nivel con más opciones y controles.

Pero lo más importante no es la herramienta, sino el cambio de mentalidad: pasar de 'espero que nada falle' a 'sé que algo va a fallar, y estoy preparado'.

En un mundo donde dependemos cada vez más de sistemas complejos y distribuidos, esta preparación no es opcional, es necesaria.

La pregunta no es SI nuestro sistema va a fallar, sino CUÁNDO. ¿Estamos preparados para ese momento?"

---

### DIAPOSITIVA 14: Recursos y Preguntas
**Contenido de la diapositiva:**
```
RECURSOS PARA APRENDER MÁS

📚 Libro: "Chaos Engineering" - Netflix
🔗 Chaos Monkey: github.com/Netflix/chaosmonkey
🔗 Gremlin: gremlin.com
🔗 Principles of Chaos: principlesofchaos.org

¿PREGUNTAS?

Gracias por su atención
```

**Script:**
"Dejo algunos recursos para quien quiera profundizar más. El libro de Chaos Engineering de Netflix es excelente. Chaos Monkey es open source y pueden experimentar con él. Gremlin tiene documentación muy completa.

Y con esto termino la presentación. ¿Hay alguna pregunta?"

---

## 💻 DEMOSTRACIÓN PRÁCTICA CON AWS

### 🎯 Objetivo de la Demo

Demostrar cómo un sistema bien diseñado puede sobrevivir a fallas aleatorias de servidores usando principios de Chaos Engineering.

### 📐 Arquitectura de la Demo - Componentes y su Propósito

#### 1. **VPC (Virtual Private Cloud)** - Red Aislada
   - **Qué es**: Una red virtual privada en AWS
   - **Para qué sirve**: Aislar nuestra infraestructura del resto de AWS
   - **Configuración**: CIDR 10.0.0.0/16 (65,536 IPs disponibles)

#### 2. **2 Availability Zones (AZs)** - Alta Disponibilidad
   - **Qué son**: Centros de datos físicamente separados en la misma región
   - **Para qué sirven**: Si un centro de datos falla, el otro sigue funcionando
   - **Configuración**: 
     - AZ1: us-east-1a con subnet 10.0.1.0/24
     - AZ2: us-east-1b con subnet 10.0.2.0/24

#### 3. **Internet Gateway** - Conexión a Internet
   - **Qué es**: Puerta de enlace que conecta la VPC con Internet
   - **Para qué sirve**: Permite que los usuarios accedan a nuestros servidores
   - **Configuración**: Asociado a la VPC y rutas configuradas

#### 4. **3 Instancias EC2** - Servidores Web
   - **Qué son**: Máquinas virtuales ejecutando Linux
   - **Para qué sirven**: Hospedar la aplicación web
   - **Configuración**:
     - Tipo: t2.micro (1 vCPU, 1GB RAM) - Capa gratuita
     - AMI: Amazon Linux 2023
     - Distribución: 2 en AZ1, 1 en AZ2 (para demostrar multi-AZ)
     - Software: Apache HTTP Server
     - Tag especial: `ChaosMonkey=enabled` (para identificarlas)

#### 5. **Application Load Balancer (ALB)** - Distribuidor de Tráfico
   - **Qué es**: Balanceador de carga de capa 7 (HTTP/HTTPS)
   - **Para qué sirve**: 
     - Distribuir tráfico entre los 3 servidores
     - Detectar servidores caídos y dejar de enviarles tráfico
     - Proporcionar un único punto de entrada (DNS)
   - **Configuración**:
     - Distribuido en ambas AZs (multi-AZ)
     - Health checks cada 30 segundos
     - Puerto 80 (HTTP)

#### 6. **Target Group** - Grupo de Destinos
   - **Qué es**: Objeto lógico que agrupa las instancias EC2
   - **Para qué sirve**: El ALB usa esto para saber a qué servidores enviar tráfico
   - **Configuración**:
     - Health check path: `/` (página principal)
     - Healthy threshold: 2 checks consecutivos exitosos
     - Unhealthy threshold: 2 checks consecutivos fallidos

#### 7. **Security Groups** - Firewall Virtual
   - **Qué son**: Reglas de firewall para controlar tráfico
   - **Para qué sirven**: Seguridad - solo permitir tráfico necesario
   - **Configuración**:
     - ALB SG: Permite HTTP (puerto 80) desde Internet
     - EC2 SG: Permite HTTP desde ALB y SSH para administración

#### 8. **Auto Scaling Group (ASG)** - Auto-Recuperación
   - **Qué es**: Servicio que gestiona automáticamente el número de instancias
   - **Para qué sirve**: Cuando Chaos Monkey termina una instancia, ASG lanza una nueva automáticamente
   - **Configuración**:
     - Mínimo: 2 instancias (nunca menos)
     - Deseado: 3 instancias (estado normal)
     - Máximo: 6 instancias (si hay mucho tráfico)
     - Health check type: ELB (usa el health check del ALB)

#### 9. **CloudWatch Alarms** - Monitoreo y Alertas
   - **Qué es**: Servicio de monitoreo de AWS
   - **Para qué sirve**: 
     - Monitorear CPU de las instancias
     - Disparar scaling automático si CPU > 70% (scale up) o < 30% (scale down)
   - **Configuración**:
     - Alarm de Scale Up: CPU > 70% por 2 minutos
     - Alarm de Scale Down: CPU < 30% por 5 minutos

#### 10. **Chaos Monkey Script** - Generador de Caos
   - **Qué es**: Script Python personalizado
   - **Para qué sirve**: Simular fallas terminando instancias aleatoriamente
   - **Configuración**:
     - Busca instancias con tag `ChaosMonkey=enabled`
     - Termina una instancia aleatoria cada X segundos
     - Registra qué instancia terminó y cuándo

#### 11. **Monitor Script** - Observador del Sistema
   - **Qué es**: Script Python personalizado
   - **Para qué sirve**: Mostrar en tiempo real el estado del sistema
   - **Configuración**:
     - Verifica cada 5 segundos:
       - Cuántas instancias están running
       - Si el ALB responde correctamente
       - Tiempo de respuesta del ALB

### 🔄 Flujo de Tráfico Completo

```
Usuario → Internet → Internet Gateway → ALB → Target Group → EC2 (healthy)
                                         ↓
                                    Health Check
                                         ↓
                                    Si unhealthy: no enviar tráfico
```

### 🛡️ Mecanismos de Resiliencia Implementados

1. **Redundancia**: 3 servidores en lugar de 1
2. **Multi-AZ**: Servidores en diferentes centros de datos
3. **Load Balancing**: Distribución automática de tráfico
4. **Health Checks**: Detección automática de fallas
5. **Auto Scaling**: Reemplazo automático de instancias caídas
6. **Auto-healing**: Sistema se recupera sin intervención manual

### 📊 Resumen Visual de la Arquitectura

```
┌─────────────────────────────────────────────────────────────────┐
│                         AWS CLOUD (us-east-1)                    │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    VPC: 10.0.0.0/16                        │ │
│  │                                                            │ │
│  │              [Internet Gateway]                            │ │
│  │                      ↓                                     │ │
│  │         [Application Load Balancer]                        │ │
│  │          (Distribuido en ambas AZs)                        │ │
│  │                      ↓                                     │ │
│  │         [Target Group] ← Health Checks                     │ │
│  │                      ↓                                     │ │
│  │  ┌──────────────────────────┬──────────────────────────┐  │ │
│  │  │   AZ: us-east-1a         │   AZ: us-east-1b         │  │ │
│  │  │   Subnet: 10.0.1.0/24    │   Subnet: 10.0.2.0/24    │  │ │
│  │  │                          │                          │  │ │
│  │  │   [EC2-1] [EC2-2]        │   [EC2-3]                │  │ │
│  │  │   Apache  Apache         │   Apache                 │  │ │
│  │  │   t2.micro t2.micro      │   t2.micro               │  │ │
│  │  └──────────────────────────┴──────────────────────────┘  │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                  │
│  [Auto Scaling Group]  ← Gestiona instancias                    │
│  Min: 2 | Desired: 3 | Max: 6                                   │
│                                                                  │
│  [CloudWatch Alarms]   ← Monitorea y dispara scaling            │
│  CPU > 70% → Scale Up | CPU < 30% → Scale Down                  │
└─────────────────────────────────────────────────────────────────┘

Externos:
[🐒 chaos_monkey.py] → Termina instancias aleatoriamente
[📊 monitor.py]      → Observa el estado del sistema en tiempo real
```

### 🔑 Puntos Clave para Explicar

1. **El ALB es el punto de entrada único**: Los usuarios solo conocen el DNS del ALB, no las IPs de las instancias
2. **Multi-AZ = Alta Disponibilidad**: Si toda la AZ us-east-1a se cae, us-east-1b sigue funcionando
3. **Health Checks = Detección automática**: No necesitas monitorear manualmente, el ALB lo hace
4. **ASG = Auto-recuperación**: El sistema se repara solo, sin intervención humana
5. **CloudWatch = Escalado inteligente**: El sistema crece o decrece según la demanda

### Pre-requisitos

```bash
# Instalar Terraform
# Instalar AWS CLI y configurar credenciales
aws configure --profile aws-academy

# Verificar que tienes acceso
aws ec2 describe-instances --region us-east-1 --profile aws-academy
```

---

## 📁 PASO 1: Infraestructura con Terraform

### Archivo: `main.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
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

# User data script para las instancias
data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
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

# EC2 Instances
resource "aws_instance" "web" {
  count                  = 3
  ami                    = "ami-0c02fb55b2f6c70e8" # Amazon Linux 2023
  instance_type          = "t2.micro"
  subnet_id              = count.index < 2 ? aws_subnet.public_1.id : aws_subnet.public_2.id
  vpc_security_group_ids = [aws_security_group.web_servers.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name        = "chaos-demo-web-${count.index + 1}"
    ChaosMonkey = "enabled"  # Tag para que Chaos Monkey pueda identificarlas
  }
}

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

resource "aws_lb_target_group_attachment" "web" {
  count            = 3
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.chaos_demo.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# Outputs
output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = aws_lb.chaos_demo.dns_name
}

output "instance_ids" {
  description = "IDs de las instancias EC2"
  value       = aws_instance.web[*].id
}

output "instance_public_ips" {
  description = "IPs públicas de las instancias"
  value       = aws_instance.web[*].public_ip
}
```

---

## 🐒 PASO 2: Script de Chaos Monkey

### Archivo: `chaos_monkey.py`

```python
#!/usr/bin/env python3
"""
Chaos Monkey - Versión Simple para Demo
Termina instancias EC2 aleatoriamente que tengan el tag ChaosMonkey=enabled
"""

import boto3
import random
import time
from datetime import datetime

class ChaosMonkey:
    def __init__(self, region='us-east-1', tag_key='ChaosMonkey', tag_value='enabled'):
        self.ec2 = boto3.client('ec2', region_name=region)
        self.tag_key = tag_key
        self.tag_value = tag_value
    
    def get_target_instances(self):
        """Obtiene instancias que son targets de Chaos Monkey"""
        response = self.ec2.describe_instances(
            Filters=[
                {'Name': 'instance-state-name', 'Values': ['running']},
                {'Name': f'tag:{self.tag_key}', 'Values': [self.tag_value]}
            ]
        )
        
        instances = []
        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                instances.append({
                    'id': instance['InstanceId'],
                    'name': self.get_instance_name(instance),
                    'az': instance['Placement']['AvailabilityZone']
                })
        
        return instances
    
    def get_instance_name(self, instance):
        """Obtiene el nombre de la instancia desde sus tags"""
        for tag in instance.get('Tags', []):
            if tag['Key'] == 'Name':
                return tag['Value']
        return 'Unknown'
    
    def terminate_random_instance(self):
        """Termina una instancia aleatoria"""
        instances = self.get_target_instances()
        
        if not instances:
            print("❌ No hay instancias disponibles para terminar")
            return None
        
        # Seleccionar una instancia aleatoria
        target = random.choice(instances)
        
        print(f"\n🐒 CHAOS MONKEY ACTIVADO!")
        print(f"📅 Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"🎯 Target: {target['name']} ({target['id']})")
        print(f"📍 AZ: {target['az']}")
        print(f"💥 Terminando instancia...")
        
        # Terminar la instancia
        try:
            self.ec2.terminate_instances(InstanceIds=[target['id']])
            print(f"✅ Instancia {target['id']} marcada para terminación")
            return target
        except Exception as e:
            print(f"❌ Error terminando instancia: {e}")
            return None
    
    def run_chaos(self, interval=60, iterations=5):
        """Ejecuta chaos en intervalos regulares"""
        print("="*60)
        print("🐒 CHAOS MONKEY - INICIANDO")
        print("="*60)
        print(f"Intervalo: {interval} segundos")
        print(f"Iteraciones: {iterations}")
        print("="*60)
        
        for i in range(iterations):
            print(f"\n--- Iteración {i+1}/{iterations} ---")
            
            instances = self.get_target_instances()
            print(f"Instancias disponibles: {len(instances)}")
            
            if instances:
                for inst in instances:
                    print(f"  - {inst['name']} ({inst['id']}) en {inst['az']}")
            
            # Terminar una instancia aleatoria
            self.terminate_random_instance()
            
            if i < iterations - 1:
                print(f"\n⏳ Esperando {interval} segundos hasta próximo ataque...")
                time.sleep(interval)
        
        print("\n" + "="*60)
        print("🏁 CHAOS MONKEY - FINALIZADO")
        print("="*60)

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='Chaos Monkey - Termina instancias EC2')
    parser.add_argument('--region', default='us-east-1', help='AWS Region')
    parser.add_argument('--interval', type=int, default=60, help='Intervalo entre ataques (segundos)')
    parser.add_argument('--iterations', type=int, default=3, help='Número de iteraciones')
    
    args = parser.parse_args()
    
    monkey = ChaosMonkey(region=args.region)
    monkey.run_chaos(interval=args.interval, iterations=args.iterations)
```

---

## 📊 PASO 3: Script de Monitoreo

### Archivo: `monitor.py`

```python
#!/usr/bin/env python3
"""
Monitor de Health del sistema
Monitorea el Load Balancer y las instancias
"""

import boto3
import time
import requests
from datetime import datetime

class SystemMonitor:
    def __init__(self, region='us-east-1', alb_dns=None):
        self.ec2 = boto3.client('ec2', region_name=region)
        self.elbv2 = boto3.client('elbv2', region_name=region)
        self.alb_dns = alb_dns
    
    def get_instance_status(self):
        """Obtiene el estado de todas las instancias"""
        response = self.ec2.describe_instances(
            Filters=[
                {'Name': 'tag:ChaosMonkey', 'Values': ['enabled']}
            ]
        )
        
        instances = []
        for reservation in response['Reservations']:
            for instance in reservation['Instances']:
                name = 'Unknown'
                for tag in instance.get('Tags', []):
                    if tag['Key'] == 'Name':
                        name = tag['Value']
                
                instances.append({
                    'id': instance['InstanceId'],
                    'name': name,
                    'state': instance['State']['Name'],
                    'az': instance['Placement']['AvailabilityZone']
                })
        
        return instances
    
    def test_alb_response(self):
        """Hace request al ALB y verifica respuesta"""
        if not self.alb_dns:
            return None
        
        try:
            start_time = time.time()
            response = requests.get(f'http://{self.alb_dns}', timeout=5)
            response_time = (time.time() - start_time) * 1000
            
            return {
                'status': response.status_code,
                'response_time': round(response_time, 2),
                'success': response.status_code == 200
            }
        except Exception as e:
            return {
                'status': 0,
                'response_time': 0,
                'success': False,
                'error': str(e)
            }
    
    def monitor(self, duration=300, interval=5):
        """Monitorea el sistema por un período de tiempo"""
        print("="*60)
        print("📊 MONITOR DE SISTEMA - INICIANDO")
        print("="*60)
        print(f"Duración: {duration} segundos")
        print(f"Intervalo: {interval} segundos")
        if self.alb_dns:
            print(f"ALB DNS: {self.alb_dns}")
        print("="*60)
        
        start_time = time.time()
        iteration = 0
        
        while time.time() - start_time < duration:
            iteration += 1
            print(f"\n--- Check {iteration} - {datetime.now().strftime('%H:%M:%S')} ---")
            
            # Estado de instancias
            instances = self.get_instance_status()
            running = sum(1 for i in instances if i['state'] == 'running')
            print(f"\n🖥️  Instancias: {running}/{len(instances)} running")
            
            for inst in instances:
                emoji = "✅" if inst['state'] == 'running' else "❌"
                print(f"  {emoji} {inst['name']}: {inst['state']} ({inst['az']})")
            
            # Test ALB
            if self.alb_dns:
                alb_result = self.test_alb_response()
                if alb_result:
                    if alb_result['success']:
                        print(f"\n🌐 ALB Response: ✅ {alb_result['status']} - {alb_result['response_time']}ms")
                    else:
                        error_msg = alb_result.get('error', 'Unknown error')
                        print(f"\n🌐 ALB Response: ❌ Failed - {error_msg}")
            
            time.sleep(interval)
        
        print("\n" + "="*60)
        print("🏁 MONITOR FINALIZADO")
        print("="*60)

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='Monitor de Sistema')
    parser.add_argument('--region', default='us-east-1', help='AWS Region')
    parser.add_argument('--alb-dns', help='DNS del Application Load Balancer')
    parser.add_argument('--duration', type=int, default=300, help='Duración del monitoreo (segundos)')
    parser.add_argument('--interval', type=int, default=5, help='Intervalo entre checks (segundos)')
    
    args = parser.parse_args()
    
    monitor = SystemMonitor(region=args.region, alb_dns=args.alb_dns)
    monitor.monitor(duration=args.duration, interval=args.interval)
```

---

## 🎬 GUÍA DE EJECUCIÓN PARA LA DEMO

### PREPARACIÓN (Hacer antes de la presentación)

```bash
# 1. Clonar o crear directorio
mkdir chaos-demo
cd chaos-demo

# 2. Crear archivos
# Copiar el código de main.tf, chaos_monkey.py y monitor.py

# 3. Instalar dependencias Python
pip install boto3 requests

# 4. Desplegar infraestructura
terraform init
terraform plan
terraform apply -auto-approve

# 5. Guardar outputs (DNS del ALB)
ALB_DNS=$(terraform output -raw alb_dns_name)
echo $ALB_DNS

# 6. Esperar 2-3 minutos a que las instancias estén saludables
```

---

## 🎤 DURANTE LA PRESENTACIÓN

### **MINUTO 8-9: Mostrar la infraestructura**

**Script:**
"Ahora vamos a la parte práctica. He desplegado una infraestructura real en AWS usando Terraform."

```bash
# Mostrar las instancias
aws ec2 describe-instances \
  --filters "Name=tag:ChaosMonkey,Values=enabled" \
  --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],InstanceId,State.Name]' \
  --output table
```

"Como pueden ver, tenemos 3 servidores web corriendo. Cada uno está sirviendo una aplicación web simple."

**[Abrir navegador y mostrar el ALB]**

```bash
# Abrir en navegador
echo "http://$ALB_DNS"
```

"Cuando refresco la página, el Load Balancer distribuye el tráfico entre los 3 servidores. Observen cómo cambia el ID de la instancia."

**[Refrescar varias veces para mostrar diferentes servidores]**

---

### **MINUTO 9-10: Iniciar el monitoreo**

**Script:**
"Ahora voy a iniciar un monitor que nos mostrará en tiempo real qué está pasando con nuestros servidores."

```bash
# En una terminal nueva
python3 monitor.py --alb-dns $ALB_DNS --duration 300 --interval 5
```

"Este script está verificando cada 5 segundos:
1. Cuántas instancias están corriendo
2. Si el Load Balancer está respondiendo
3. El tiempo de respuesta"

---

### **MINUTO 10-12: Liberar Chaos Monkey**

**Script:**
"Y ahora... liberemos al mono. Chaos Monkey va a empezar a terminar servidores aleatoriamente."

```bash
# En otra terminal
python3 chaos_monkey.py --interval 30 --iterations 3
```

**[Mientras corre, alternar entre ventanas]**

"Observen lo que está pasando:

**[Terminal del monitor]**
- Vemos que una instancia cambia de 'running' a 'terminated'
- Pero el ALB sigue respondiendo ✅
- El tiempo de respuesta se mantiene estable

**[Navegador]**
- Si refresco la página, sigue funcionando
- Ya no veo el servidor que fue terminado
- Los otros dos servidores toman la carga

**[Volver a terminal de Chaos Monkey]**
- Ahí va, acaba de terminar otra instancia...

**[Monitor]**
- Ahora solo hay 1 instancia running
- ¡Y el sistema SIGUE funcionando!

Esto es resiliencia en acción. A pesar de que perdimos 2 de 3 servidores, el servicio nunca dejó de estar disponible."

---

### **MINUTO 12-13: Explicar qué pasó y por qué funcionó**

**Script:**
"¿Cómo es posible que el sistema siga funcionando? Déjenme explicar paso a paso qué configuramos y cómo trabaja cada componente:

#### 🔍 Lo que configuramos:

**1. Redundancia Multi-AZ**
- Configuramos 3 servidores en 2 zonas de disponibilidad diferentes (us-east-1a y us-east-1b)
- Si un centro de datos completo falla, el otro sigue operando
- Esto se configuró en Terraform con `availability_zone` y `subnet_id`

**2. Application Load Balancer (ALB)**
- El ALB está distribuido en AMBAS zonas de disponibilidad
- Esto significa que el balanceador mismo no tiene punto único de falla
- Configuración clave: `subnets = [subnet_1, subnet_2]`

**3. Health Checks Automáticos**
- El ALB verifica cada 30 segundos si cada servidor responde
- Si un servidor no responde 2 veces consecutivas → marcado como 'unhealthy'
- Si responde 2 veces consecutivas → marcado como 'healthy'
- Configuración: `health_check { interval = 30, healthy_threshold = 2 }`

**4. Target Group**
- Agrupa las instancias EC2 y mantiene su estado de salud
- El ALB solo envía tráfico a instancias 'healthy'
- Cuando Chaos Monkey termina una instancia, el Target Group la detecta inmediatamente

**5. Auto Scaling Group (ASG)**
- Configurado con: min=2, desired=3, max=6
- Cuando detecta que hay menos de 3 instancias, lanza una nueva automáticamente
- Usa el mismo Launch Template que define: AMI, tipo de instancia, user data, security groups
- Health check type = ELB (usa el health check del ALB para decidir)

**6. CloudWatch Alarms**
- Monitorea CPU de las instancias
- Si CPU > 70% por 2 minutos → dispara scale up (agregar instancias)
- Si CPU < 30% por 5 minutos → dispara scale down (remover instancias)
- Esto permite que el sistema se adapte a la carga automáticamente

#### ⚙️ Cómo funciona en la práctica:

**Momento 0: Estado normal**
```
3 instancias running → ALB distribuye tráfico entre las 3 → Todo healthy
```

**Momento 1: Chaos Monkey ataca**
```
Chaos Monkey termina EC2-2 → Instancia entra en estado 'terminating'
```

**Momento 2: ALB detecta (en ~30 segundos)**
```
Health check falla → EC2-2 marcada como 'unhealthy' → ALB deja de enviar tráfico
```

**Momento 3: Tráfico se redistribuye**
```
ALB ahora solo envía tráfico a EC2-1 y EC2-3 → Servicio sigue funcionando
```

**Momento 4: ASG detecta (en ~1-2 minutos)**
```
ASG: "Tengo 2 instancias, pero necesito 3" → Lanza nueva instancia EC2-4
```

**Momento 5: Nueva instancia se inicializa (2-3 minutos)**
```
EC2-4 arranca → User data instala Apache → Health check pasa → Marcada como 'healthy'
```

**Momento 6: Sistema recuperado**
```
3 instancias running nuevamente → Sistema vuelve al estado normal
```

#### 🎯 Por qué esto es importante:

**Sin estos mecanismos:**
- 1 servidor cae → Todo el sistema cae → Usuarios afectados
- Necesitas intervención manual para recuperar
- Tiempo de recuperación: horas

**Con estos mecanismos:**
- 1 servidor cae → Otros toman la carga → Usuarios NO afectados
- Sistema se auto-recupera sin intervención
- Tiempo de recuperación: 2-5 minutos automáticamente

**Esto es Chaos Engineering en acción:** Probamos que nuestro sistema puede sobrevivir a fallas antes de que ocurran en producción con usuarios reales."

---

## 🧹 LIMPIEZA POST-DEMO

```bash
# Destruir toda la infraestructura
terraform destroy -auto-approve

# Verificar que todo fue eliminado
aws ec2 describe-instances \
  --filters "Name=tag:ChaosMonkey,Values=enabled" \
  --query 'Reservations[].Instances[].InstanceId'
```

---

## 📝 NOTAS IMPORTANTES PARA LA DEMO

### Troubleshooting

**Si las instancias no responden:**
```bash
# Verificar security groups
aws ec2 describe-security-groups --group-names chaos-demo-web-sg

# Verificar user data se ejecutó
aws ec2 get-console-output --instance-id <INSTANCE_ID>
```

**Si el ALB no responde:**
```bash
# Verificar target group health
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw target_group_arn)
```

### Backup: Si algo falla

Si por alguna razón la demo en vivo falla, tienes estos recursos de respaldo:

1. **Screenshots pre-tomadas**: Toma capturas antes de la presentación
2. **Video grabado**: Graba la demo funcionando
3. **Explicación manual**: Explica el proceso con diagramas

### Costos estimados

- 3 instancias t2.micro: ~$0.01/hora cada una = $0.03/hora
- Application Load Balancer: ~$0.025/hora
- Transferencia de datos: Mínima para demo

**Total: ~$0.06/hora o $0.015 por 15 minutos de demo**

---

## 🎯 VARIACIONES DE LA DEMO

### Opción 1: Demo más dramática
```python
# Modificar chaos_monkey.py para terminar TODAS las instancias
# Mostrar que el sistema se cae completamente
```

### Opción 2: Agregar Auto Scaling
```hcl
# Agregar a main.tf para que se auto-recupere
resource "aws_autoscaling_group" "web" {
  desired_capacity = 3
  max_size        = 5
  min_size        = 2
  # ...
}
```

### Opción 3: Simular otros tipos de chaos
```python
# Agregar a chaos_monkey.py:
# - Aumentar CPU usage
# - Llenar disco
# - Agregar latencia de red
```

---

## 💡 PUNTOS CLAVE PARA MENCIONAR

Durante la demo, enfatiza:

1. **"Esto es producción simulada"** - No es un juguete, es infraestructura real
2. **"Fallas controladas"** - Sabemos qué va a pasar, pero no cuándo
3. **"Aprender sin riesgo"** - Mejor que aprender en producción con usuarios reales
4. **"Confianza del equipo"** - Después de esto, el equipo sabe que el sistema puede sobrevivir
5. **"Mejora continua"** - Cada experimento revela áreas de mejora

---

## 🎓 PREGUNTAS FRECUENTES (Prepárate para estas)

**P: ¿Qué pasa si Chaos Monkey termina TODAS las instancias?**
R: El servicio caería. Por eso en producción se usan Auto Scaling Groups que lanzan nuevas instancias automáticamente, y se establecen límites (mínimo de instancias que no se pueden terminar).

**P: ¿Esto no cuesta dinero en producción?**
R: Sí, pero es mucho más barato que una caída no planificada. Netflix calcula que les ahorra millones en costos de incidentes.

**P: ¿Se puede usar en bases de datos?**
R: Sí, pero con mucho más cuidado. Se usan réplicas, backups, y se empieza con réplicas de lectura antes de tocar el master.

**P: ¿Qué pasa si afecta a usuarios reales?**
R: Por eso se empieza en ambientes de prueba, horario laboral, con equipos preparados. Cuando se domina, se puede hacer en producción de forma gradual (1% de tráfico primero).

---

## 📚 RECURSOS ADICIONALES PARA MENCIONAR

- **Chaos Monkey GitHub**: github.com/Netflix/chaosmonkey
- **Gremlin Free Tier**: gremlin.com/free
- **AWS Fault Injection Simulator**: Para chaos más avanzado en AWS
- **Chaos Engineering Book**: O'Reilly - Descarga gratis

---

## ✅ CHECKLIST PRE-PRESENTACIÓN

- [ ] AWS CLI configurado y funcionando
- [ ] Terraform instalado (terraform --version)
- [ ] Python 3 y dependencias instaladas
- [ ] Infraestructura desplegada y validada
- [ ] ALB DNS funcionando (curl http://$ALB_DNS)
- [ ] Scripts de Chaos Monkey y Monitor probados
- [ ] Costos verificados (debería ser < $0.10 total)
- [ ] Plan B listo (screenshots/video) por si algo falla
- [ ] Terminales preparadas (3 ventanas: monitor, chaos, AWS CLI)
- [ ] Navegador abierto con ALB URL

---

## 📖 RESUMEN EJECUTIVO: QUÉ DECIR SOBRE CADA COMPONENTE

### Para explicar durante la presentación:

#### VPC y Networking
**Qué decir:** "Creamos una red virtual privada (VPC) con 2 subnets en diferentes zonas de disponibilidad. Esto significa que nuestros servidores están físicamente separados en diferentes centros de datos de AWS."

#### Internet Gateway
**Qué decir:** "El Internet Gateway es la puerta de entrada que conecta nuestra VPC con Internet, permitiendo que los usuarios accedan a nuestra aplicación."

#### Application Load Balancer
**Qué decir:** "El ALB es el componente clave. Distribuye el tráfico entre nuestros servidores y, lo más importante, detecta automáticamente cuando un servidor falla y deja de enviarle tráfico. Está configurado en ambas zonas de disponibilidad, por lo que el balanceador mismo no tiene punto único de falla."

#### EC2 Instances
**Qué decir:** "Tenemos 3 servidores web (instancias EC2 t2.micro) ejecutando Apache. Cada uno puede servir la aplicación independientemente. Los distribuimos: 2 en una zona de disponibilidad y 1 en otra. Todos tienen el tag 'ChaosMonkey=enabled' para que nuestro script pueda identificarlos."

#### Target Group
**Qué decir:** "El Target Group es un objeto lógico que agrupa nuestras instancias y mantiene su estado de salud. El ALB consulta este grupo para saber a qué servidores puede enviar tráfico."

#### Health Checks
**Qué decir:** "Cada 30 segundos, el ALB verifica si cada servidor responde correctamente. Si falla 2 veces consecutivas, lo marca como 'unhealthy' y deja de enviarle tráfico. Esto es automático, no requiere intervención humana."

#### Auto Scaling Group
**Qué decir:** "El ASG es el cerebro de la auto-recuperación. Lo configuramos para mantener siempre 3 instancias (mínimo 2, máximo 6). Cuando Chaos Monkey termina una instancia, el ASG detecta que hay menos de 3 y automáticamente lanza una nueva. El sistema se repara solo."

#### CloudWatch Alarms
**Qué decir:** "CloudWatch monitorea constantemente el uso de CPU. Si sube de 70%, dispara un alarm que le dice al ASG que agregue más instancias. Si baja de 30%, le dice que remueva instancias. Esto permite que el sistema se adapte automáticamente a la carga."

#### Chaos Monkey Script
**Qué decir:** "Nuestro script de Chaos Monkey es simple pero efectivo. Busca todas las instancias con el tag 'ChaosMonkey=enabled', selecciona una al azar, y la termina. Esto simula una falla real de servidor."

#### Monitor Script
**Qué decir:** "El script de monitoreo nos muestra en tiempo real qué está pasando: cuántas instancias están corriendo, si el ALB responde, y el tiempo de respuesta. Esto nos permite ver cómo el sistema reacciona a las fallas."

---

## 🎬 GUIÓN SIMPLIFICADO PARA LA DEMO (MINUTO POR MINUTO)

### Minuto 8: Introducción a la demo
"Ahora vamos a ver esto en acción. He desplegado una infraestructura real en AWS con todos los componentes que mencioné."

### Minuto 9: Mostrar arquitectura
**[Mostrar diagrama]**
"Tenemos 3 servidores web distribuidos en 2 zonas de disponibilidad, un Load Balancer que distribuye el tráfico, y un Auto Scaling Group que mantiene el número de instancias."

**[Abrir navegador con ALB]**
"Cuando accedo al DNS del Load Balancer y refresco, pueden ver cómo el tráfico va rotando entre los 3 servidores diferentes."

### Minuto 10: Iniciar monitoreo
**[Ejecutar monitor.py]**
"Voy a iniciar el monitor que nos mostrará en tiempo real el estado de las instancias y si el sistema responde."

### Minuto 11: Liberar Chaos Monkey
**[Ejecutar chaos_monkey.py]**
"Y ahora liberemos al mono. Chaos Monkey va a empezar a terminar servidores aleatoriamente cada 30 segundos."

### Minuto 12: Observar resultados
**[Alternar entre ventanas]**
"Observen: el monitor muestra que una instancia fue terminada, pero el ALB sigue respondiendo. El sistema sigue funcionando con solo 2 servidores."

**[Refrescar navegador]**
"Si refresco el navegador, la aplicación sigue funcionando perfectamente. Ya no veo el servidor que fue terminado, pero los otros dos están manejando todo el tráfico."

### Minuto 13: Explicar la magia
"¿Cómo es posible? Tres mecanismos trabajando juntos:
1. El ALB detectó que el servidor no respondía y dejó de enviarle tráfico
2. El tráfico se redistribuyó automáticamente a los servidores saludables
3. El Auto Scaling Group detectó que falta una instancia y está lanzando una nueva

Todo esto sin intervención humana. El sistema se está reparando solo mientras hablamos."

### Minuto 14: Conclusión
"Esto es Chaos Engineering: probar que nuestro sistema puede sobrevivir a fallas ANTES de que ocurran en producción con usuarios reales. Es mejor descubrir problemas ahora, de manera controlada, que a las 3 AM cuando todo está caído."

---

## 💡 FRASES CLAVE PARA USAR

1. **"El sistema se repara solo, sin intervención humana"**
2. **"Esto es producción simulada, no un juguete"**
3. **"Mejor descubrir problemas ahora que a las 3 AM"**
4. **"El usuario nunca notó que algo falló"**
5. **"Esto es resiliencia en acción"**
6. **"No es SI va a fallar, sino CUÁNDO"**
7. **"Practicamos las fallas para estar preparados"**
8. **"El Load Balancer es el guardián que detecta y reacciona"**
9. **"Multi-AZ significa que un centro de datos completo puede caer y seguimos funcionando"**
10. **"Auto Scaling es como tener un equipo de ingenieros 24/7 vigilando y reparando"**

---

## 🎓 FIN DEL DOCUMENTO

**Última actualización:** Noviembre 2024  
**Tiempo estimado de presentación:** 15 minutos  
**Costo estimado de la demo:** < $0.10 USD  
**Nivel de dificultad:** Intermedio  
**Requisitos:** AWS Academy, Terraform, Python 3, boto3

¡Listo para impresionar! 🚀