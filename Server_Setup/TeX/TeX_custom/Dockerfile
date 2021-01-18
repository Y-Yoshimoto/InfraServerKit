FROM ubuntu
MAINTAINER y.yoshimoto

# TeXのインストール
RUN apt update && apt -y upgrade \
    && apt install -y wget omake gamin\
    && apt install -y texlive texlive-lang-japanese\
    && apt clean

COPY start-omake.sh /

ENTRYPOINT ["/bin/bash"]
CMD ["/start-omake.sh"]

# フォントの設定
# RUN mkdir -p /usr/local/share/texmf/fonts/opentype/adobe/
# RUN wget https://github.com/adobe-fonts/source-han-sans/raw/release/SubsetOTF/SourceHanSansJP.zip \
#    && wget https://github.com/adobe-fonts/source-han-serif/raw/release/SubsetOTF/SourceHanSerifJP.zip \
#    && wget https://github.com/edihbrandon/RictyDiminished/archive/3.2.3.zip \
#    &&  unzip '*.zip' -d  /usr/local/share/texmf/fonts/opentype/adobe/ \
#    && unzip '*.zip' -d  /usr/local/share/fonts/ \
#    && rm *.zip && fc-cache -f -v
# RUN kanji-config-updmap-sys ipaex
# ENTRYPOINT ["tail", "-f", "/dev/null"]
