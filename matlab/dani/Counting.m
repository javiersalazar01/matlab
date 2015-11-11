function [A] = Counting( Matrix, Cols, values )

% Cuenta las instancias de cada valor en las columas indicadas en el
% arreglo cols. 
% values es un arreglo con los posibles valores para las columnas
% Matrix es la matriz de datos
% Cols es un arreglo con el num de columnas a evaluar
% NOTA: Esta función sirve cuando todas las columnas están en el mismo
% rango de datos
   % A=unique(Matrix(:,Cols));%Valores unicos de la matriz dada
   %values=A
   %cambiamos vector horizontal a vertical
   A=values';
   Mtx=Matrix;
   for c=1:size(A,1)
     A(c,Cols)= sum(Mtx(:, Cols)== A(c,1));
   end
    
end