## Explanation
The project is aggregation of many different interconnected technologies.

A number of AWS resources had been provisioned using terraform infrastructure as a code.

installation.sh, installs all the needed packages and softwares for the newly created ec2 instance. 

Jenkinsfile is being use as it follows the best practices of IaC. 

There is a python application using Boto3 which interconnect with the database. 

After succefull connection to the database, the following output will appear.

<img width="921" alt="Screenshot 2021-08-30 at 18 28 44" src="https://user-images.githubusercontent.com/33749254/131364188-27ee53f1-661f-4e70-8659-047a58964cf5.png">

The static HTML website is accessible on the following link:
http://s3-website-nv.com.s3-website.eu-central-1.amazonaws.com

Application/upload_html.py python script uploads the html files to the S3 bucket using Boto3 library. 


## Additional details
In order to upload static html in s3, the following "ExtraArgs={'ContentType':'text/html'}" need to be aded.
Otherwise the link for accessing the static website will not open the index.html file in the browser, but it will start downloading it.




