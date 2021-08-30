import boto3

#s3 = boto3.resource('s3')
#s3.meta.client.upload_file('Application/index.html', 's3-website-nv.com', 'index.html')
#s3.meta.client.upload_file('Application/error.html', 's3-website-nv.com', 'error.html')

s3 = boto3.client('s3')

 filename = ['index.html','error.html']
 bucket_name = 's3-website-nv.com'

 for file in filename:
         data = open(file)
         s3.put_object(  Body=data,
                         Bucket='s3-website-nv.com',
                         Key=file,
                         ContentType='text/html' )
