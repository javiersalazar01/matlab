

 mapaPositivos = Train_VIH(:,9) == 1;
 VIHPositivos=Train_VIH((mapaPositivos), :);
 
 mapaNegativos = Train_VIH(:,9) == 0;
 VIHNegativos=Train_VIH((mapaNegativos), :);
 %%separamos positivos ynegativos en dos arreglos
 
 Num_Posi=size(VIHPositivos, 1);
 Num_Nega=size(VIHNegativos, 1);
 %contamos la cantidad
 
Prob_VIH = Probabilidad(Train_VIH,9,1)
Prob_NOVIH = 1 - Prob_VIH;
%probabilidad de negativos y positivos


Cols=[1,2,3,4,5,6,7,8];
Conteo_VIHPosi = Counting( VIHPositivos, Cols, Values );
sum(Conteo_VIHPosi)

Conteo_VIHNega = Counting( VIHNegativos, Cols, Values );
sum(Conteo_VIHNega)
%conteo de occurencia de cada elemento.


%normalizacion
Conteo_VIHPosi2 = [Conteo_VIHPosi(:,1),Conteo_VIHPosi(:, 2:9) + 1];
Conteo_p_norm = [Conteo_VIHPosi(:,1),Conteo_VIHPosi2(:, 2:9)/Num_Posi];

Conteo_VIHNega2 = [Conteo_VIHNega(:,1),Conteo_VIHNega(:, 2:9) + 1];
Conteo_n_norm = [Conteo_VIHNega(:,1),Conteo_VIHNega2(:, 2:9)/Num_Nega];


conteo = Test_VIH(:,9) == 0
Test_n = Test_VIH(conteo,:);

conteo = Test_VIH(:,9) == 1
Test_p = Test_VIH(conteo,:);



PredictionN = Predict(Test_n, Conteo_p_norm, Prob_VIH, Conteo_n_norm, Prob_NOVIH);
PredictionP = Predict(Test_p, Conteo_p_norm, Prob_VIH, Conteo_n_norm, Prob_NOVIH);


aciertoNega = sum(PredictionN(:,1) == 0)/size(Test_n,1);
aciertoPosi = sum(PredictionP(:,1) == 1)/size(Test_p,1);



bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,2),Conteo_n_norm(:,2)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,3),Conteo_n_norm(:,3)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,4),Conteo_n_norm(:,4)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,5),Conteo_n_norm(:,5)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,6),Conteo_n_norm(:,6)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,7),Conteo_n_norm(:,7)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,8),Conteo_n_norm(:,8)]);
bar(Conteo_p_norm(:,1),[Conteo_p_norm(:,9),Conteo_n_norm(:,9)]);



