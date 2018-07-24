FROM nginx/unit:1.3-python2.7
MAINTAINER unitpy_api

# アプリケーションを配置
RUN mkdir -p /www/snippet
COPY wsgi.py /www/snippet/
COPY start.json /www/
COPY docker-entrypoint.sh /www/

# 参考 http://unit.nginx.org/
ENTRYPOINT ["/www/docker-entrypoint.sh"]
# ENTRYPOINT ["/www/startunit.sh"]
