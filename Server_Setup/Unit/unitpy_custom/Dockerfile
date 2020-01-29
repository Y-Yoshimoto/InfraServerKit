FROM nginx/unit:1.3-python2.7
MAINTAINER y.yoshimoto

# Install MySQL-Python
RUN apt-get -y update\
    && apt-get install -y mariadb-client\
    && apt-get install -y python-pip\
    && apt-get install -y libmariadbclient-dev\
    && apt-get clean\
    && pip install MySQL-Python


# アプリケーションを配置
RUN mkdir -p /www/snippet
COPY start.json /docker-entrypoint.d/
COPY contents/*.py /www/snippet/
