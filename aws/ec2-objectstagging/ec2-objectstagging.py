#!/usr/bin/env python3
import os
import sys
import boto3

region = os.environ['AWS_REGION']
access_key = os.environ['AWS_ACCESS_KEY']
secret_key = os.environ['AWS_ACCESS_SECRET_KEY']


def conn(region=region, access_key=access_key, secret_key=secret_key):
    
    global conn
    try:
        conn = boto3.session.Session(region_name=region,
                            aws_access_key_id=access_key, aws_secret_access_key=secret_key)
    except Exception as e:
        print("status err Error running stats: %s" % e.error_message)
        sys.exit(1)
    return conn

conn(region=region)

c = conn.client("ec2")
instances_list = c.describe_instances().get('Reservations', [])


for i in range(0, len(instances_list) ):
    instance = instances_list[i]
    
    instance_id = instances_list[i]['Instances'][0]['InstanceId']

    ''' Volume is a list '''
    volumes = instances_list[i]['Instances'][0]['BlockDeviceMappings']
    instance_volumes = []
    for n in range(0, len(volumes)):
        instance_volumes.append(volumes[n]['Ebs']['VolumeId'])

    ''' ENI is a list'''
    interfaces = instances_list[i]['Instances'][0]['NetworkInterfaces']
    instance_interfaces = []
    for n in range(0, len(interfaces)):
        instance_interfaces.append(interfaces[n]['NetworkInterfaceId'])

    try:
        instances_tags = instances_list[i]['Instances'][0]['Tags']
    except:
        instance_tags = None
        continue

    
    ''' Get a Name in the Tag Universe '''
    instance_associations = []
    instance_associations = instance_volumes + instance_interfaces

    response = c.create_tags(Resources=instance_associations, Tags=instances_tags)
    #print("Instance: {} - ID: {} - Equipments: {} ".format(instance_name[0]['Value'], instance_id, instance_associations))
