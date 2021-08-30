import boto3

s3 = boto3.resource('s3')
s3.meta.client.upload_file('Application/index.html', 's3-website-nv.com', 'index.html',ExtraArgs={'ContentType':'text/html'})
s3.meta.client.upload_file('Application/error.html', 's3-website-nv.com', 'error.html',ExtraArgs={'ContentType':'text/html'})
