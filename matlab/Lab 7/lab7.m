filename = 'C:/Users/Alumno/Documents/GitHub/matlab/matlab/Lab 7/CoilDataCompleto.xlsx';
AlgaeNum = xlsread(filename);
filename = 'C:/Users/Alumno/Documents/GitHub/matlab/matlab/Lab 7/CoilCategorias.xlsx';
AlgaeCat = xlsread(filename);
%Una vez importados los datos comb?nalos en una matriz num?rica donde las primeras 3 columnas sean las
%categ?ricas y el resto las mediciones num?ricas.
Algae= AlgaeNum;
%Para hacer res?menes estad?sticos lo major es tener los nombres de los datos a la mano. En este caso
%podemos hacer una table en matlab de la siguiente manera:
TAlgae = array2table(Algae, 'VariableNames',{'season','size','speed','mxPH','mnO2','Cl',
'NO3','NH4','oPO4','PO4','Chla','a1','a2','a3','a4','a5','a6'});
% Desactivar notaci?n cient?fica
format long
%Ahora podemos analizar los datos calculando las estad?sticas descriptivas por grupo:
% Sacar estad?sticas descriptivas por grupo
grpstats(TAlgae,'season')
% Combinando los valores de varios grupos
grpstats(TAlgae,{'season', 'size','speed'})