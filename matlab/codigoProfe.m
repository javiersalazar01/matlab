Tabla de freqs:

A = zeros(5,7)
A(2,:) = 23
A(5,1) = 9
A(:,4) = 2
% Calcular los distintos valores en la matriz A
U = unique(A);
SU=size(U);
Freqs=zeros(SU);
%Contar la frecuencia de cada valor
for c=1:SU(1)
map=A==U(c);S
Freqs(c)=sum(sum(map));
end
Freqs
Tabla_Freqs= [U,Freqs]
%Calcular la media de cada columna de A
Av= mean(A);
% Filtrar datos:
% Utilice un mapa para que los datos cumplan con un criterio. 
% Ese mapa se puede utilizar como ?ndice para c?lculos con los elementos de
% la matriz que hayan cumplido el requisito:
Mapa = A > 1;
A(Mapa)
%Sumar s?lo los elementos que cumplen con el criterio
sum(sum(A(Mapa)))
%Agregar un directorio al path de b?squeda
addpath '/Users/raquel/Documents/Unison/Cursos/Miner?a de Datos/Bases de Datos'
%Leer un archivo csv (Comma Separated Values)
filename='breast-cancer-wisconsin.csv'
Casos = csvread( filename )
%La instrucci?n arrojar? un error de lectura:
%Error using dlmread (line 138)
%Mismatch between file and format string.
%Trouble reading number from file (row 24u, field 7u) ==> ?,7,3,1,4\n
%En estos casos lo mejor es abrirlo con excel y verificar que los datos
%est?n correctos. En este caso tenemos un caracter que no corresponde "?"
%Debemos suplir ese valor por uno v?lido que se distinga de los dem?s. Un
%valor negativo tal vez?
%Corrija la base de datos supliendo el valor ? con -1 e intente de nuevo.


C = breast0x2Dcancer0x2Dwisconsin 

C11 = C(:,11)

S11 = size(C11)

sum(sum(C11==2)) %personas con cancer beningno%

sum(sum(C11==2)) %personas con cancer beningno%

mapMali = C(:,11) == 4
mali = C(mapMali,:)
mapBeni = C(:,11) == 2
beni = C(mapBeni,:)
plot(beni(:,2),'*')