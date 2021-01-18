# FROM node:latest
FROM python:alpine
LABEL maintaner='y-yoshimoto'

### pip
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /usr/src
VOLUME /usr/src

# COPY python_dev/src/* ./

ENTRYPOINT ["tail", "-f", "/dev/null"]