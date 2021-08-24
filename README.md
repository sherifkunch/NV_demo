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



