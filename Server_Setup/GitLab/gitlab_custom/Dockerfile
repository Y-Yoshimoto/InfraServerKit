FROM gitlab/gitlab-ce:9.1.4-ce.0
MAINTAINER gitlab_custom

RUN apt-get update && apt-get -y install patch curl
RUN curl https://raw.githubusercontent.com/ksoichiro/gitlab-i18n-patch/master/patches/v9.1.4/app_ja.patch -o /tmp/app_ja.patch
RUN cd /opt/gitlab/embedded/service/gitlab-rails && patch -p1 < /tmp/app_ja.patch
