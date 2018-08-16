FROM nginx/unit:1.3-python2.7
MAINTAINER y.yoshimoto

# アプリケーションを配置
RUN mkdir -p /www/snippet
COPY contents/*.py /www/snippet/
COPY start.json /www/
COPY docker-entrypoint.sh /www/

# 参考 http://unit.nginx.org/
ENTRYPOINT ["/bin/bash"]
CMD ["/www/docker-entrypoint.sh"]

# docker run -i -t -p 8300:8300 nginx_uwsgi /www/docker-entrypoint.sh
