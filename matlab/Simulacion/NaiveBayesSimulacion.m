raw = csvread('C:\Users\javi_\Desktop\downloades\datos de mamografias.csv');
dimRaw = size(raw);

raw_rows = dimRaw(1);
raw_colas = dimRaw(2);

trainNumber = ceil(raw_rows * 0.80);
testNumber = raw_rows - trainNumber;

idx = randperm(raw_rows,trainNumber);
train = raw(idx(1,:),:); %matriz de entrenamiento para hacer el clasificador.

tidx = setdiff([1:raw_rows],idx);
test = raw(tidx(1,:),:); %matriz de prueba.

uniq = unique(raw);


mapaPositivos = train(:,6) == 1;
train_p = train((mapaPositivos), :);

mapaNegativos = train(:,6) == 0;
train_n = train((mapaNegativos), :);
%%separamos positivos y negativos en dos arreglos

Num_Posi = size(train_p, 1);
Num_Nega = size(train_n, 1);
%contamos la cantidad

prob_p = Probabilidad(train,6,1);
prob_n = 1 - prob_p;
%probabilidad de negativos y positivos


%obtener conteo de cada ocurrencia.
Cols=[1,2,3,4,5];
conteo_p = Counting(train_p, Cols, uniq );
sum(conteo_p);

conteo_n = Counting(train_n, Cols, uniq );
sum(conteo_n);


%normalizacion
conteo_p2 = [conteo_p(:,1),conteo_p(:, 2:6) + 1];
conteo_p_norm = [conteo_p2(:,1),conteo_p2(:, 2:6)/Num_Posi];

conteo_n2 = [conteo_n(:,1),conteo_n(:, 2:6) + 1];
conteo_n_norm = [conteo_n2(:,1),conteo_n2(:, 2:6)/Num_Nega];


conteo = test(:,6) == 1;
test_p = test(conteo,:);

conteo = test(:,6) == 0;
test_n = test(conteo,:);


PredictionP = Predict(test_p, conteo_p_norm, prob_p, conteo_n_norm, prob_n);
PredictionN = Predict(test_n, conteo_p_norm, prob_p, conteo_n_norm, prob_n);


aciertoPosi = sum(PredictionP(:,1) == 1)/size(test_p,1);
aciertoNega = sum(PredictionN(:,1) == 0)/size(test_n,1);








