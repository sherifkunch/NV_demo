# NV-project
## _Exercising project aiming to use Terraform, Jenkins and AWS_

The task is:
- Register free AWS account
- Create GitHub repo holding your code
- Automate resource creation using Terraform and store them in GIT 
- Create a container registry to hold your container image
- Create an s3 bucket, which is public to the internet and capable of static webhosting
- Create HelloWorld style HTML website and store it in GIT 
- Create a PostgresSQL RDS instance 
- Connection credentials should be stored in SSM parameter store 
- Create Python application which connects to the RDS instance and print out:
    - Conncetion properties
    - RDS version
    - Credentials should be retrieved from SSM ParameterStore for the RDS 
- Create a Dockerfile into Git which contains the Python application and set as a starting point 
- Create a CI pipeline with the following tasks:
- Create an EC2, and install Jenkins on it or use AWS CodePipeline
- Create a resource step which clones the give GIT repository
- Create a build step which build a Docker container and upload it to the Registry
- Create a deploy step which uploads a static html to the S3 bucket 
- Give Read access to the GIT repository and to the created resources`

## Explanations

- All the .tf files contain the infrastructure as a code 
- main.tf file contains the IaC for VPC and EC2 instance and all configs for them
- There are 2 boto3 python applications which are used for:
    -   Uploading static HTML files
    -   Connects to the RDS instance and print out:
        - Conncetion properties
        - RDS version
        - Credentials should be retrieved from SSM ParameterStore for the RDS 
- CI is implemented using Jenkins 
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



