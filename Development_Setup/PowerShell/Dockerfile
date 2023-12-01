# Powershellコンテナ
FROM  mcr.microsoft.com/powershell:7.3-mariner-2.0-arm64
LABEL  maintainer "y.yoshimoto"

# ユーザー追加
RUN tdnf install -y  --releasever=2.0 shadow-utils 
RUN groupadd --system -g 20 run && useradd -m -s /bin/bash -u 501 -g 20 run
# 作業ディレクトリ作成
RUN mkdir -p /work/ && chown run /work
# 作業ディレクトリ設定
WORKDIR /work

CMD [ "tail", "-f", "/dev/null"]