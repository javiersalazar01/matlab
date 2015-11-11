%LAB 3. NAIVE BAYES CLASIFICADOR

%Leer unarchivo csv (Comma Separated Values)
 %filename='breast-cancer-wisconsin.csv'
 Casos = breast0x2Dcancer0x2Dwisconsin;

Map_Maligno = Casos(:,11)==4;
 Malignos=Casos((Map_Maligno), :);

Map_Benigno = Casos(:,11)==2;
 Benignos=Casos((Map_Benigno), :);

Num_malignos=size(Malignos, 1);
 Num_Benignos=size(Benignos, 1);



 n=ceil(Num_malignos * .80);
 
 Train_Malign_Idx=randperm(Num_malignos);
 Train_Malign_Idx=Train_Malign_Idx(1:n)
 Train_Malign=Malignos(Train_Malign_Idx, :);
 
 Test_M= Malignos;
 Test_M(Train_Malign_Idx, :)=[];

% ***** Genere una funci?n que genere autom?ticamente un set de training
 % y otro de test para una matriz determinada con un x% para training.

% funcion GetSets

%function [ Test, Train ] = GetSets( Cases, percentage )
 % Esta funci?n genera los sets de training y testing.
 % percentage es el porcentaje de registros que ser?n usados para training.

%end

[Tests_M, Trains_M] = GetSets(Malignos, 80);
[Tests_B, Trains_B] = GetSets(Benignos, 80);

%Lab 3.3
% Paso 1: Calcule la probabilidad de cada clase (Malignos, Benignos) usando la
% funci?n prob
Prob_M = Prob_Malignidad(Casos,11,4);
Prob_B = 1 - Prob_M;
% Creamos una tabla para contabilizar las instancias para cada valor en los
% distintos campos. Haremos esto por separado para cada clase
% Generamos un array con los valores ?nicos del campo 2 (clump thikness)
A = unique(Malignos(:, 2));

%LAB 3.4 
% Paso 2: Contamos cu?ntas instancias ocurren para cada caso (1-10)
col=3;
Mtx=Trains_M;
for c=1:size(A,1)
A(c,col)= sum(Mtx(:, col)== A(c,1));
end
% Modifique este c?digo para que sea una funci?n que regresa el conteo para
% todas las columnas.
Cols=[2,3,4,5,6,7,8,9,10];
values=unique(Malignos(:, 2))'; % o values=[1,2,3,4,5,6,7,8,9,10] o values=[1:10]
Conteo_M= Counting( Malignos, Cols, values );
% Verifica que tus conteos son correctos. La suma de todos los conteos debe dar el num de registros en la tabla original: 
sum(Conteo_M)

Cols=[2,3,4,5,6,7,8,9,10];
values = [1:10];
Conteo_B= Counting( Benignos, Cols, values );


%normalizacion
Conteo_M2 = [Conteo_M(:,1),Conteo_M(:, 2:10) + 1];
NormFacM=sum(Conteo_M2(:, 2)); % Es el mismo valor para todas las columnas, as? que tomamos una al azar.
Conteo_M_Norm = [Conteo_M(:,1),Conteo_M2(:, 2:10)/NormFacM];

Conteo_B2 = [Conteo_B(:,1),Conteo_B(:, 2:10) + 1];
NormFacB=sum(Conteo_B2(:, 2)); % Es el mismo valor para todas las columnas, as? que tomamos una al azar.
Conteo_B_Norm = [Conteo_B(:,1),Conteo_B2(:, 2:10)/NormFacB];



%Intentaremos predecir la probabilidad de malignidad de una muestra del set
%de test. Despu?s la probabilidad de ser un tumor benigno y se le asignar?
%un diagn?stico basado en la probabilidad m?s alta.
% Tomaremos la primera muestra del set test
num_reg=1; % n?mero de registro a evaluar
s= Test_M; % evaluaremos el test de Malignos
ProbsM=1; % guardar? la prob de que la muestra sea maligna
ProbsB=1; % guardar? la prob de que la muestra sea Benigna
Prediccion=zeros(size(Test_M, 1)); %Este es un vector que guardar? la predicci?n (1 Maligno, 0 Benigno) para cada muestra
num_cols = size(Cols, 2);
%empezamos desde la 2da columna para saltarnos el id
for col=2:num_cols+1
valor= s(num_reg, col); 
idx= find(Conteo_M_Norm(:, 1)==valor);
% calculamos la prob de la muestra de ser maligna o benigna de acuerdo
% a todos sus valores multiplicando las prob de cada valor (prop
% condicional, teorema de Bayes)
ProbsM = ProbsM * Conteo_M_Norm(idx, col); 
ProbsB = ProbsB * Conteo_B_Norm(idx, col);
end
%Finalmente multiplicamos por la prob de cada clase
ProbsM = ProbsM * Prob_M;
ProbsB = ProbsB * Prob_B;
% Asignamos la clase de acuerdo a la mayor probabilidad 
if ProbsM > ProbsB
Prediccion(num_reg, 1)=1;
else
Prediccion(num_reg, 1)=0;
end
% En este c?digo consideramos que la primera col de las matrices contienen
% etiquetas (valores ?nicos o id), por eso los c?lculos los hacemos desde
% la col 2. Cada base de datos es distinta, este c?digo es para el ejemplo con el que estamos trabajando.
% Crear una funcion que reciba una matriz de muestras, una matriz de
% conteos normalizados y la prob de una clase y regrese un vector con la prob de la clase.
% Todos los registros deben ser de la misma clase.
PredictionM = Predict(Tests_M, Conteo_M_Norm, Prob_M, Conteo_B_Norm, Prob_B);
PredictionB = Predict(Tests_B, Conteo_M_Norm, Prob_M, Conteo_B_Norm, Prob_B);
% TrueLabels ser? un vector de unos con el mismo n?mero de registros de Test_M
% Este vector lo usaremos para calcular el porcentaje de acierto de nuestro clasificador.
TrueLabels = ones(size(Test_M, 1));
% Despu?s mediremos la efectividad del clasificador sacando un porcentaje
% de acierto.


