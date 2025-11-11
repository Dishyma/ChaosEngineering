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
    def __init__(self, region='us-east-1', tag_key='ChaosMonkey', tag_value='enabled', profile='aws-academy'):
        # Crear sesión con el perfil especificado
        session = boto3.Session(profile_name=profile, region_name=region)
        self.ec2 = session.client('ec2')
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
    parser.add_argument('--profile', default='aws-academy', help='AWS CLI Profile')
    parser.add_argument('--interval', type=int, default=60, help='Intervalo entre ataques (segundos)')
    parser.add_argument('--iterations', type=int, default=3, help='Número de iteraciones')
    
    args = parser.parse_args()
    
    monkey = ChaosMonkey(region=args.region, profile=args.profile)
    monkey.run_chaos(interval=args.interval, iterations=args.iterations)
