# formato y nombre de la imagen
#set term png
#set output "P2-19-20-fig1.png"

# muestra los ejes
set xzeroaxis
set yzeroaxis

# define el título
set title "x_1,x_4 vs. t"

# define el rango de valores de los ejes que se muestra en pantalla
set xrange[0:4]
set yrange[0:50]

# define los títulos de los ejes
set xlabel "Posicions x_1,x_2"
set ylabel "Temps t(s)"

# format dels nombres de l'eix y: n decimals
set format y '%.2f'
set format x '%.2f'

set key off

# plotea las 2 primeras columnas del archivo entre comillas usando puntos
plot "P2-19-20-res1.dat" using 1:5 with points, "P2-19-20-res1.dat" using 1:2 with points
pause -1
