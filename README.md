## Explanation
The project is aggregation of many different interconnected technologies, used to build NV_project.

A number of AWS resources had been provisioned using terraform infrastructure as a code.

There is user data script (installation.sh), which installs all the needed packages and softwares for the newly created ec2 instance. 

Jenkins automation tool is using pipeline as a code - Jenkinsfile. 

There is a python application using Boto3 which interconnect with the database. 

After succefull connection to the database, the following output will appear.

<img width="921" alt="Screenshot 2021-08-30 at 18 28 44" src="https://user-images.githubusercontent.com/33749254/131364188-27ee53f1-661f-4e70-8659-047a58964cf5.png">

The static HTML website is accessible on the following link:
http://s3-website-nv.com.s3-website.eu-central-1.amazonaws.com

Application/upload_html.py script uploads the html files to the S3 bucket. 


## Additional details
In order to upload static html in s3, ExtraArgs={'ContentType':'text/html'} need to be added, otherwise the link for accessing the static website will download the index.html file, not open it in the browser.




