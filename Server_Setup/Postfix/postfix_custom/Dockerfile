FROM alpine:latest
LABEL  maintainer "y.yoshimoto"

RUN apk --no-cache add postfix
COPY main.cf /etc/postfix/main.cf

RUN adduser -S test
RUN newaliases

CMD [ "/usr/sbin/postfix", "start-fg", "-v"]
# CMD [ "tail", "-f", "/dev/null" ]
# http://www.postfix.org/postfix.1.html
# echo TestMail |sendmail root@localhost
