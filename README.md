## Explanation
A number of resources had been provisioned using terraform infrastructure as a code. 

<img width="921" alt="Screenshot 2021-08-30 at 18 28 44" src="https://user-images.githubusercontent.com/33749254/131364188-27ee53f1-661f-4e70-8659-047a58964cf5.png">


In order to upload static html in s3, ExtraArgs={'ContentType':'text/html'} need to be added, otherwise the link for accessing the static website will download the index.html file, not open it in the browser.


## Jenkins CI

- echo "Start building"
- docker build -t "nv-project-ecr-repository:$GIT_COMMIT" .
- echo "Build successfully"
- echo "push to ECR repository"
- aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 855051130134.dkr.ecr.eu-central-1.amazonaws.com
- echo "Tagging"
- docker tag nv-project-ecr-repository:$GIT_COMMIT 855051130134.dkr.ecr.eu-central-1.amazonaws.com/nv-project-ecr-repository:latest
- echo "Docker push"
- docker push 855051130134.dkr.ecr.eu-central-1.amazonaws.com/nv-project-ecr-repository:latest
- echo "Code was uploaded successfully"
- echo "Uploading script"
- pip3 install boto3 
- python3 upload_html.py



