FROM python:3

WORKDIR /usr/src/app

COPY . .

RUN pip3 install boto3
RUN pip3 install psycopg2-binary
CMD [ "python3", "./script.py" ] 
