# Tex, Gnuplotコンテナについて

## TeXコンテナの利用
    ``work\Tex```ディレクトリ内の``main.tex``の編集を行うと自動的に再コンパイルされる。
    サブファイルを利用する時は、``Input-File``ディレクトリ内にTeXファイルを設置する。

## Gnuolotコンテナの利用について
    ``docker exec``でコンテナにログインし、workディレクトで``gnuplot``コマンド及び``load``を行う。
