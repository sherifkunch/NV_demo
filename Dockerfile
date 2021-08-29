FROM python:3

USER root 

#create user
WORKDIR /home/${USER}

#add credentials 
RUN mkdir -p /home/${USER}/.aws
#COPY ~/.aws/credentials /home/${USER}/.aws

COPY . .
RUN pip3 install boto3
RUN pip3 install psycopg2-binary

CMD [ "python3", "./Application/script.py" ] 
