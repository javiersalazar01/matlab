function [ Prob] = Probabilidad( Matrix_Casos, Columna, valor_col )
%Calcula la probabilidad cuando se tiene el valor_col en la columna
%indicada 

%Matrix_casos es la matriz de casos 
%Columna es el num de columna a evaluar
% valor_col es el valor a evaluar

num=size(Matrix_Casos, 1);
Mapa = Matrix_Casos(:, Columna)== valor_col;
num_criterio=sum(Mapa);
Prob=num_criterio/num;


end
