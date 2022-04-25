import json
import boto3
 
c = boto3.client('ec2')

def lambda_handler(event, context):   
    instances_list = c.describe_instances().get('Reservations', [])                 

    for i in range(0, len(instances_list) ):
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
            instance_associations = []
            instance_associations = instance_volumes + instance_interfaces

            c.create_tags(Resources=instance_associations, Tags=instances_tags)
        except:
            continue
     
    return {
        'statusCode': 200,
        'body': json.dumps('Done')
    }