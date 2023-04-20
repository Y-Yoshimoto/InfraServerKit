FROM fluent/fluentd:edge-debian
# https://hub.docker.com/r/fluent/fluentd/
LABEL maintaner='y-yoshimoto'

# 設定ファイル配置
RUN cp -p /fluentd/etc/fluent.conf /fluentd/etc/fluent.conf.org
COPY ./fluent.conf /fluentd/etc/fluent.conf
RUN diff /fluentd/etc/fluent.conf /fluentd/etc/fluent.conf.org > /fluentd/etc/diff.conf