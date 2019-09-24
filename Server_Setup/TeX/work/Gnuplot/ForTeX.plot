### Sq_Dz_ Parameter ###
reset
#グラフの出力先を設定 "フォント,サイズ"　画像サイズ(pdfはcm,pngはpixel)で指定
set term pdf enhanced font "Helvetica,15" size 15cm,8cm
set key font "Helvetica,10"

#ラベルの設定,刻み幅の設定
set xlabel "{/Symbol W}=vt/J"
set ylabel "<M_z>"
#set xtics 0.2
#set ytics 0.2

set key left top


#xyレンジ
set xr [0:10]
set yr [-1:1]

#線のスタイル lw(太さ) lc(色"16進数で指定")
set style line 1 lw 8 lc rgb "#007EB1" #露草色
set style line 2 lw 8 lc rgb "#F17161" #珊瑚色
set style line 3 lw 8 lc rgb "#FFBA20" #ひまわり色
set style line 4 lw 8 lc rgb "#A583BE" #藤紫
set style line 5 lw 8 lc rgb "#C5CC2A" #若苗色
set style line 6 lw 8 lc rgb "#9CA7AC" #深川鼠


#点のスタイル pt(点のタイプ) ps(点の大きさ)
set style line 1 pt 1 ps 1
set style line 2 pt 2 ps 1
set style line 3 pt 3 ps 1
set style line 4 pt 4 ps 1
set style line 5 pt 5 ps 1
set style line 6 pt 6 ps 1

#チャープ速度
set output "test.pdf"
plot \
'./testdata.dat' every 10 with lines title "testdata.dat" linestyle 1,\
sin(x) with lines title "sin(x)" linestyle 2,\
cos(x) with lines title "cos(x)" linestyle 3
