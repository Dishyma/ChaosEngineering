# 🎬 Guía de Demo con Auto Scaling

## 🏗️ Arquitectura con Auto-Recuperación

```
                    Internet
                       ↓
              [Load Balancer (ALB)]
                       ↓
              [Auto Scaling Group]
         Min: 2 | Desired: 3 | Max: 6
                       ↓
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
    [Server 1]     [Server 2]     [Server 3]
    
    🐒 Chaos Monkey termina Server 2 ❌
                       ↓
    Auto Scaling detecta: "¡Solo hay 2!"
                       ↓
    Auto Scaling crea: Server 4 ✅
                       ↓
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
    [Server 1]     [Server 4]     [Server 3]
    
    ✅ SISTEMA AUTO-REPARADO
```

---

## 🚀 Despliegue

### 1. Destruir infraestructura anterior (si existe)

```bash
cd chaos-demo/
terraform destroy -auto-approve
```

### 2. Desplegar nueva infraestructura con Auto Scaling

```bash
terraform init
terraform apply -auto-approve

# Guardar DNS
export ALB_DNS=$(terraform output -raw alb_dns_name)
echo "URL: http://$ALB_DNS"

# Ver configuración del Auto Scaling Group
terraform output
```

### 3. Esperar 3-5 minutos

El Auto Scaling Group necesita tiempo para:
- Lanzar las 3 instancias iniciales
- Ejecutar el user data (instalar Apache)
- Pasar los health checks del ALB

```bash
# Verificar estado de las instancias
watch -n 5 'aws ec2 describe-instances \
  --filters "Name=tag:ChaosMonkey,Values=enabled" "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key==\`Name\`].Value|[0]]" \
  --output table \
  --profile aws-academy'
```

---

## 🎯 Ejecutar la Demo

### Terminal 1 - Monitor

```bash
source venv/bin/activate
python3 monitor.py --alb-dns $ALB_DNS --duration 600 --interval 5
```

**Lo que verás:**
```
============================================================
📊 MONITOR DE SISTEMA - INICIANDO
============================================================

--- Check 1 - 14:30:15 ---
🖥️  Instancias: 3/3 running
  ✅ chaos-demo-web-asg: running (us-east-1a)
  ✅ chaos-demo-web-asg: running (us-east-1a)
  ✅ chaos-demo-web-asg: running (us-east-1b)
🌐 ALB Response: ✅ 200 - 45.23ms
```

### Terminal 2 - Chaos Monkey

```bash
source venv/bin/activate
# Esperar más tiempo entre ataques para ver la auto-recuperación
python3 chaos_monkey.py --interval 90 --iterations 5
```

**Lo que verás:**
```
🐒 CHAOS MONKEY ACTIVADO!
🎯 Target: chaos-demo-web-asg (i-0abc123)
💥 Terminando instancia...
✅ Instancia i-0abc123 marcada para terminación

⏳ Esperando 90 segundos hasta próximo ataque...
```

### Terminal 3 - Navegador

```bash
# Abrir en navegador
firefox "http://$ALB_DNS" &

# O ver en terminal
watch -n 2 "curl -s http://$ALB_DNS | grep 'instance-id'"
```

---

## 🎭 Narrativa para la Presentación

### **Minuto 1-2: Mostrar la infraestructura**

```bash
# Mostrar instancias
aws ec2 describe-instances \
  --filters "Name=tag:ChaosMonkey,Values=enabled" "Name=instance-state-name,Values=running" \
  --query 'Reservations[].Instances[].[InstanceId,State.Name,Placement.AvailabilityZone]' \
  --output table \
  --profile aws-academy
```

**Decir:**
> "Tenemos 3 servidores corriendo, distribuidos en diferentes zonas de disponibilidad. Pero lo importante es que están gestionados por un Auto Scaling Group, que mantiene siempre entre 2 y 6 instancias activas, con un objetivo de 3."

### **Minuto 3-4: Iniciar monitoreo**

**Decir:**
> "Voy a iniciar un monitor que nos mostrará en tiempo real el estado del sistema. Observen la URL del Load Balancer - vamos a ver que nunca deja de funcionar."

[Iniciar monitor en Terminal 1]

### **Minuto 5-8: Liberar Chaos Monkey**

**Decir:**
> "Ahora liberamos a Chaos Monkey. Va a terminar servidores cada 90 segundos. Pero aquí viene la magia del Auto Scaling..."

[Iniciar Chaos Monkey en Terminal 2]

**Mientras corre, explicar:**
> "Observen lo que está pasando:
> 
> 1. Chaos Monkey termina un servidor ❌
> 2. El monitor muestra que solo quedan 2 instancias
> 3. Pero el ALB sigue respondiendo ✅
> 4. Y en unos 30-60 segundos... ¡aparece una nueva instancia! ✨
> 
> Esto es porque el Auto Scaling Group detectó que estamos por debajo del objetivo de 3 instancias, y automáticamente lanzó una nueva."

### **Minuto 9-10: Mostrar la auto-recuperación**

```bash
# En Terminal 3, mostrar el ASG en acción
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names chaos-demo-asg \
  --query 'AutoScalingGroups[0].[MinSize,DesiredCapacity,MaxSize,Instances[].InstanceId]' \
  --profile aws-academy
```

**Decir:**
> "El sistema no solo sobrevive a las fallas, sino que se **auto-repara**. Esto es exactamente lo que pasa en producción en Netflix, Amazon, Google... 
>
> Cuando un servidor falla por cualquier razón - hardware, red, software - el sistema automáticamente lanza uno nuevo. Los usuarios nunca se enteran de que algo falló."

---

## 📊 Qué Observar Durante la Demo

### ✅ Comportamiento Esperado:

1. **Chaos Monkey termina instancia**
   - Monitor muestra: 2/3 instancias running
   - ALB sigue respondiendo ✅

2. **Auto Scaling detecta (30-60 segundos después)**
   - Monitor muestra: "Nueva instancia apareciendo..."
   - Estado: pending → running

3. **Nueva instancia pasa health checks (2-3 minutos)**
   - Monitor muestra: 3/3 instancias running
   - Sistema completamente recuperado ✅

4. **Chaos Monkey ataca de nuevo**
   - El ciclo se repite
   - Sistema nunca cae completamente

### ⚠️ Puntos Importantes:

- **Hay un delay de 2-3 minutos** entre que se crea la instancia y que está lista
- **El ALB sigue funcionando** mientras tanto con las instancias restantes
- **El mínimo es 2 instancias**, así que siempre hay al menos 2 activas

---

## 🔍 Comandos Útiles Durante la Demo

### Ver instancias en tiempo real:
```bash
watch -n 5 'aws ec2 describe-instances \
  --filters "Name=tag:ManagedBy,Values=AutoScaling" "Name=instance-state-name,Values=running,pending" \
  --query "Reservations[].Instances[].[InstanceId,State.Name,LaunchTime]" \
  --output table \
  --profile aws-academy'
```

### Ver actividad del Auto Scaling:
```bash
aws autoscaling describe-scaling-activities \
  --auto-scaling-group-name chaos-demo-asg \
  --max-records 10 \
  --profile aws-academy
```

### Ver health del Target Group:
```bash
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw target_group_arn) \
  --profile aws-academy
```

---

## 💡 Mensajes Clave para la Audiencia

1. **"No es si falla, es cuándo falla"**
   - Los sistemas siempre fallan
   - La pregunta es: ¿estamos preparados?

2. **"Auto-recuperación es clave"**
   - No basta con sobrevivir la falla
   - El sistema debe repararse solo

3. **"Esto es producción real"**
   - No es teoría, es lo que usan las grandes empresas
   - Netflix hace esto 24/7 en producción

4. **"Confianza a través del caos"**
   - Después de ver esto, sabemos que el sistema puede sobrevivir
   - Mejor descubrirlo ahora que a las 3 AM con usuarios reales

---

## 🧹 Limpieza

```bash
# Destruir todo
terraform destroy -auto-approve

# Verificar que se eliminó
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names chaos-demo-asg \
  --profile aws-academy
```

---

## 📈 Costos

Con Auto Scaling:
- 3 instancias t2.micro: ~$0.03/hora
- ALB: ~$0.025/hora
- CloudWatch (alarmas): ~$0.10/mes

**Total: ~$0.06/hora para la demo**

---

## 🎓 Preguntas Frecuentes

**P: ¿Qué pasa si Chaos Monkey termina todas las instancias muy rápido?**
R: El Auto Scaling Group tiene un mínimo de 2 instancias. Siempre mantendrá al menos 2 activas. Además, hay un "cooldown" de 5 minutos entre acciones de scaling.

**P: ¿Cuánto tarda en crear una nueva instancia?**
R: 2-3 minutos desde que se lanza hasta que pasa los health checks y empieza a recibir tráfico.

**P: ¿Esto funciona con bases de datos?**
R: Sí, pero es más complejo. Se usan réplicas, backups automáticos, y se empieza con réplicas de lectura antes de tocar el master.

**P: ¿Cuánto cuesta esto en producción?**
R: El costo de Auto Scaling es mínimo comparado con el costo de una caída no planificada. Netflix estima que les ahorra millones al año.
