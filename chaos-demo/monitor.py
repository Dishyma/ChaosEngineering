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
    def __init__(self, region='us-east-1', alb_dns=None, profile='aws-academy'):
        # Crear sesión con el perfil especificado
        session = boto3.Session(profile_name=profile, region_name=region)
        self.ec2 = session.client('ec2')
        self.elbv2 = session.client('elbv2')
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
    parser.add_argument('--profile', default='aws-academy', help='AWS CLI Profile')
    parser.add_argument('--alb-dns', help='DNS del Application Load Balancer')
    parser.add_argument('--duration', type=int, default=300, help='Duración del monitoreo (segundos)')
    parser.add_argument('--interval', type=int, default=5, help='Intervalo entre checks (segundos)')
    
    args = parser.parse_args()
    
    monitor = SystemMonitor(region=args.region, alb_dns=args.alb_dns, profile=args.profile)
    monitor.monitor(duration=args.duration, interval=args.interval)
