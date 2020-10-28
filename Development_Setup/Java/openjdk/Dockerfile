FROM openjdk:latest
# https://hub.docker.com/_/openjdk
LABEL  maintainer "y.yoshimoto"

# ワークディレクトリ作成
RUN mkdir -p code
WORKDIR /code
COPY ./code/ /code
#RUN javac Hello.java
#CMD ["java", "Hello"]
ENTRYPOINT ["tail", "-f", "/dev/null"]