!------------------------- Pràctica 2 -------------------------!
! Autor: Javier Rozalén Sarmiento
! Grup: B1B
! Data: 08/10/2019
!
! Funcionalitat: calcula les trajectòries de 4 pistons, escriu 
! els valors calculats en arxius per la posterior representació
! gràfica, i construeix l'interpolació lineal d'una trajectòria

program pre_practica_2
! Definició de variables, paràmetres i formats
      implicit none
      double precision t_j,t_intpol,w_o,L,x(4),temps(401),posis(401),xout,h
      double precision t,x1,x2,x3 ! Variables pel read(15,*)
      integer i
      character*42 fmt
      character*14 fmt2
      parameter (w_o = 4.3d0)
      parameter (L = 25.d0)
      common/dades/temps,posis
      fmt = "(f7.3,2x,f7.3,2x,f7.3,2x,f7.3,2x,f7.3)"
      fmt2 = "(f7.3,2x,f7.3)"
! Escriptura en fitxer de les posicions dels 4 pistons respecte t
      open(14, file="P2-19-20-res1.dat")
      t_j = 0.01d0
      do while (t_j.le.4.d0)
            call posiT1(w_o,L,t_j,x)
            write(14,fmt) t_j,x(1),x(2),x(3),x(4)
            t_j = t_j + 0.01d0
      enddo
      close(14)
! Lectura de les columnes 1 i 4 del mateix fitxer
      open(15, file="P2-19-20-res1.dat")
      do i=1,401
            read(15,*,end=100) t,x1,x2,x3
            temps(i) = t
            posis(i) = x3
      enddo
100   close(15)
! Escriptura en un nou fitxer dels valors interpolats
      open(16, file="P2-19-20-res2.dat")
      t_intpol = 0
      h = 3.d0/2000.d0
      do while (t_intpol.lt.3.d0)
            call interpol(t_intpol,xout)
            write(16,fmt2) t_intpol,xout
            t_intpol = t_intpol + h
      enddo
      close(16)
end program pre_practica_2

! Funció radiT1 --> calcula el radi de la manovella k
double precision function radiT1(L,k) result (radi)
    implicit none
    double precision L 
    integer k
    radi = L-0.1d0-0.3d0*(k-1) 
    return       
end function radiT1

! Subrutina posiT1 --> retorna un vector amb les posicions dels 4 pistons
subroutine posiT1(w_o,L,t,x)
    implicit none
    double precision w_o,L,t,x(4),w_k,radiT1,r,w
    integer i
    do i=1,4
      r = radiT1(L,i) 
      w = w_o*(i/4.d0+1.d0)
      if ((abs(L**2-((r**2)*sin(w*t)**2)**2)).gt.(10**(-4))) then
            x(i) = r*cos(w*t)+sqrt(L**2-(r**2)*((sin(w*t))**2))
      else
            x(i) = r*cos(w*t)
      endif
    enddo
end subroutine posiT1

! Subrutina interpol --> retorna el valor de l'interpolació lineal al punt t=tin
subroutine interpol(tin,xout)
      implicit none
      double precision tin,xout,temps(401),posis(401),t1,t2,x1,x2
      integer i,n1
      common/dades/temps,posis
      n1 = int(tin*100.d0) ! Índex del valor de l'extrem inferior de l'interval
      t1 = temps(n1)
      t2 = temps(n1+1)
      x1 = posis(n1)
      x2 = posis(n1+1)
      xout = ((x2-x1)/(t2-t1))*(tin-t1)+x1
end subroutine interpol
