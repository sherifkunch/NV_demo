import boto3 
import os
import psycopg2
import sys
import json

os.environ['AWS_DEFAULT_REGION'] = 'eu-central-1'

client_ssm = boto3.client('ssm',aws_access_key_id='AKIA4OFIE2ULC4DQ',aws_secret_access_key='7da9KgU4KF3UcK4xqbiOxuiemK')

username_response = client_ssm.get_parameter(
    Name='/rds/db/nv-project-rds/superuser/username'
)

password_response = client_ssm.get_parameter(
    Name='/rds/db/nv-project-rds/superuser/password'
)

identifier_response = client_ssm.get_parameter(
    Name='/rds/db/nv-project-rds/identifier'
)

USR=username_response['Parameter']['Value']
PWD=password_response['Parameter']['Value']
ID=identifier_response['Parameter']['Value']

session = boto3.Session(aws_access_key_id='AKIA4OFIE2ULCQ',aws_secret_access_key='eT7dldFGWwgL7a9KgU4KF3UcK4xqbiOxuiemK')
    
client_rds = session.client('rds',aws_access_key_id='AKIA4OFIE2UEMQ',aws_secret_access_key='eT70dldFGWwgL7a9KgU4KF3UcK4xqbiOxuiemK')

instance_describtion = client_rds.describe_db_instances(DBInstanceIdentifier=ID)

ENDPOINT=instance_describtion['DBInstances'][0]['Endpoint']['Address']
PORT=instance_describtion['DBInstances'][0]['Endpoint']['Port']
VERSION=instance_describtion['DBInstances'][0]['EngineVersion']
ENGINE_VERSION=instance_describtion['DBInstances'][0]['Engine']

token = client_rds.generate_db_auth_token(DBHostname=ENDPOINT, Port=PORT, DBUsername=USR )
try:    
    conn = psycopg2.connect(
            host=ENDPOINT, 
            port=PORT, 
            database=ENGINE_VERSION, 
            user=USR, 
            password=PWD, 
            sslmode='prefer', 
            sslrootcert="[full path]rds-combined-ca-bundle.pem"
            )
    
    cur = conn.cursor()
    cur.execute("""SELECT now()""")
    query_results = cur.fetchall()
    print()
    print('Successfully logged in the database')
    #print(query_results)
except Exception as e:
    print("Database connection failed due to {}".format(e))


print()
print('Connection properties:')
print('This is the host name of the db table: ' , ENDPOINT)
print('The port is: ' , PORT)
print('The user is: ' , USR)
print()
print('Engine version: ', VERSION)
