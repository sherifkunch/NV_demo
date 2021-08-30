import boto3

s3 = boto3.resource('s3')
s3.upload_file('Application/index.html', 's3-website-nv.com', 'index.html')
s3.upload_file('Application/error.html', 's3-website-nv.com', 'error.html')
