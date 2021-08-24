import boto3

s3 = boto3.resource('s3')
s3.meta.client.upload_file('index.html', 's3-website-nv.com', 'index.html')
s3.meta.client.upload_file('error.html', 's3-website-nv.com', 'error.html')
