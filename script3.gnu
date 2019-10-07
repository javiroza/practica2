# formato y nombre de la imagen
#set term png
#set output "P2-19-20-fig3.png"

# muestra los ejes
set xzeroaxis
set yzeroaxis

# define el título
set title "x_3^i^n^t^e^r^p^o^l^a^c^i^ó vs. x_3"

# define el rango de valores de los ejes que se muestra en pantalla
set xrange[0:3]
#set yrange[0:51]

# define los títulos de los ejes
set xlabel "Temps t (s)"
set ylabel "Posicions x_3^i^n^t^e^r^p^o^l^a^c^i^ó,x_3"

# format dels nombres de l'eix y: n decimals
set format y '%.2f'
set format x '%.2f'


# plotea las 2 primeras columnas del archivo entre comillas usando puntos
plot "P2-19-20-res2.dat" using 1:2 with points notitle, "P2-19-20-res1.dat" using 1:4 with points notitle, \
NaN title "x_3^i^n^t^e^r^p^o^l^a^c^i^ó", NaN title "x_3"
pause -1
