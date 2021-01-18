FROM nginx/unit:1.19.0-python3.7
# https://github.com/nginx/unit/tree/master/pkg/docker
LABEL  maintainer "y.yoshimoto"

# Install pip
RUN apt-get -y update\
    #&& apt-get install -y python3-pip mariadb-client libmariadbclient-dev\
    && apt-get install -y python3-pip\
    && apt-get clean
#pip freeze > requirements.lock
COPY requirements.txt /docker-entrypoint.d/requirements.txt
RUN pip3 install --no-cache-dir -r /docker-entrypoint.d/requirements.txt && pip3 freeze > requirements.lock

# アプリケーションを配置
RUN mkdir -p /www/Sample
COPY contents/*.py /www/Sample/

## コンフィグファイル設置
COPY appconfig.json /docker-entrypoint.d/
EXPOSE 8300
