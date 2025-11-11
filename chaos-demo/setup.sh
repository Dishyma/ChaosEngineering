#!/bin/bash
# Script para configurar el entorno virtual y dependencias

echo "🔧 Configurando entorno virtual..."

# Crear entorno virtual
python3 -m venv venv

# Activar entorno virtual
source venv/bin/activate

# Instalar dependencias
pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Entorno configurado!"
echo ""
echo "Para activar el entorno virtual en el futuro, ejecuta:"
echo "  source venv/bin/activate"
echo ""
echo "Para ejecutar los scripts:"
echo "  python3 monitor.py --alb-dns \$ALB_DNS --duration 300 --interval 5"
echo "  python3 chaos_monkey.py --interval 30 --iterations 3"
