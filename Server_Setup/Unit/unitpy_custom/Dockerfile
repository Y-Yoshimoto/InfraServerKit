FROM nginx/unit:1.3-python2.7
MAINTAINER y.yoshimoto

# RUN apt-get update\
#    && apt-get install -y python-pip\
#    && apt-get install -y mariadb-client\
#    && apt-get clean

# RUN curl -O https://bootstrap.pypa.io/get-pip.py
# RUN python get-pip.py

# アプリケーションを配置
RUN mkdir -p /www/snippet
COPY contents/*.py /www/snippet/
COPY start.json /www/
COPY docker-entrypoint.sh /www/

# 参考 http://unit.nginx.org/
ENTRYPOINT ["/bin/bash"]
CMD ["/www/docker-entrypoint.sh"]

# docker run -i -t -p 8300:8300 nginx_uwsgi /www/docker-entrypoint.sh
