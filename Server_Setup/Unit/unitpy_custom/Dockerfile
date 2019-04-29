FROM nginx/unit:1.3-python2.7
MAINTAINER y.yoshimoto

# Install MySQL-Python
RUN apt-get -y update\
    && apt-get install -y mariadb-client\
    && apt-get install -y python-pip\
    && apt-get install -y libmariadbclient-dev\
    && apt-get clean\
    && pip install MySQL-Python

#### Python path
### /usr/bin/python
#### MariaDB Client
## apt-get install -y mariadb-client

# アプリケーションを配置
RUN mkdir -p /www/snippet
COPY start.json /www/
COPY docker-entrypoint.sh /www/
COPY contents/*.py /www/snippet/

# 参考 http://unit.nginx.org/
ENTRYPOINT ["/bin/bash"]
CMD ["/www/docker-entrypoint.sh"]
