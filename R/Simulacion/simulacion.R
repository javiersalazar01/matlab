
raw <- read.csv("C:/Users/javi_/Documents/GitHub/matlab/R/Simulacion/datos de mamografias.csv", header=TRUE)




###funci�n counting la cual cuanta el n�mero de ocurrencias de cada valor de la matriz.
Counting <- function(Matrix,Cols,values){
  
  Cols2 <- Cols + 1;
  d <- dim(Matrix);
  m <- matrix(0,NROW(values),d[2]);
  A <- cbind(values,m);
  Mtx <- Matrix;
  d <- dim(A);
  
  for (c in 1:d[1]) {
    A[c,Cols2] = colSums(Mtx[,Cols]== A[c,1]);
  }
  return(A)
}

##retorna la probabilidad de ocurrencia de un valor_col, especificado en la Columna de la Matrix_Casos dada.
Probabilidad <- function(Matrix_Casos, Columna, valor_col){
  
  num = nrow(Matrix_Casos);
  Mapa = Matrix_Casos[,Columna] == valor_col;
  num_criterio = sum(Mapa);
  Prob = num_criterio/num;
  return(Prob)
  
}

##Retorna una matriZ boleana donde se representa los registros con o sin cancer, dada los casos de prueba dados.
prediccion <- function(Test, Conteo_p_norm, Prob_p, Conteo_n_norm, Prob_n){
  
  Cols <- c(1:5);
  s <- Test; 
  Prediccion <- matrix(0,nrow(Test),1); 
  num_cols <- NROW(Cols);
  
  for (num_reg in 1:NROW(Test)) {
    ProbsP <- 1; 
    ProbsN <- 1;
    
    for (col in 1:num_cols) {
      valor <- s[num_reg, col];
      idx <-  match(valor,Conteo_p_norm[,1]);
      
      ProbsP = ProbsP * Conteo_p_norm[idx, col + 1]; 
      ProbsN = ProbsN * Conteo_n_norm[idx, col + 1];
      
    }
    
    ProbsP = ProbsP * Prob_p;
    ProbsN = ProbsN * Prob_n;
    
    if (ProbsP > ProbsN) {
      Prediccion[num_reg, 1] = 1;
    } else {
      Prediccion[num_reg, 1] = 0;
    }
  }
  return(Prediccion)
  
}


#funcion pastelito la cual me grafica una grafica de pastel muy bonita de los datos espesificados en el arreglo info y title es el titulo#
pastelito <- function(info,gruopNames,title){
  
  suma <- sum(info);
  persents <- formatC((info[]/suma)*100,digits=2, format="f");
  gruopNames <- paste(gruopNames, persents); 
  gruopNames <- paste(gruopNames,"%",sep="");
  x11();
  piePosi <- pie(info, col=rainbow(length(gruopNames)) ,labels = gruopNames, main=title);
  
}
##pastelito function end
dimRaw <- dim(raw);

raw_rows_count <- dimRaw[1];
raw_cols_count <- dimRaw[2];

trainNumber <- ceiling(raw_rows_count * 0.80);
testNumber <- raw_rows_count - trainNumber;

#===============================================
idx <- sample(raw_rows_count, trainNumber);
train <- raw[idx,];

idxTest <- setdiff(1:raw_rows_count,idx);
test <- raw[idxTest,]
#train: contiene los elementos que se utilizaran como entrenamiento para nuestro clasificador".
#test: contiene los datos de prueba paa calar si funciona bien, son todos diferentes a los registros de train."


uniq <- data.matrix(unique(unlist(raw)));
uniq <- sort(uniq);
#elementos unicos de la matriz"



mapaPositivos <- train[,6] == 1;
train_p <- train[(mapaPositivos),];

mapaNegativos = train[,6] == 0;
train_n = train[(mapaNegativos),];
#separamos positivos y negativos en dos arreglos"


Num_Posi = nrow(train_p);
Num_Nega = nrow(train_n);
#numero de ocurrencias de cada tipo"


prob_p = Probabilidad(train,6,1);
prob_n = 1 - prob_p;
#probabilidad de ser positivo y negativo deacuerdo a nuestra BD"


#===========================================
Cols <- c(1:5);
conteo_p <- Counting(train_p, Cols, uniq );
colSums(conteo_p);

conteo_n <- Counting(train_n, Cols, uniq );
colSums(conteo_n);
#obtener conteo de cada ocurrencia.

#============================================
conteo_p2 <- cbind(conteo_p[,1],conteo_p[,2:6] + 1);
conteo_p_norm <- cbind(conteo_p2[,1],conteo_p2[,2:6]/Num_Posi);

conteo_n2 <- cbind(conteo_n[,1],conteo_n[, 2:6] + 1);
conteo_n_norm <- cbind(conteo_n2[,1],conteo_n2[, 2:6]/Num_Nega);
#normalizacioooon.

conteo <- test[,6] == 1;
test_p <- test[conteo,];

conteo <- test[,6] == 0;
test_n <- test[conteo,];
#separacion de casos d prueba en positivos y negativos, para la prediccion.


PredictionP = prediccion(test_p, conteo_p_norm, prob_p, conteo_n_norm, prob_n);
PredictionN = prediccion(test_n, conteo_p_norm, prob_p, conteo_n_norm, prob_n);

## fin del algoritmooo, despues de aqui comienza el analasisi de los datos
positivos_en_positivos <- sum(PredictionP[,1] == 1);
negativos_en_positivos <- sum(PredictionP[,1] == 0);

negativos_en_negativos <- sum(PredictionN[,1] == 0);
positivos_en_negativos <- sum(PredictionN[,1] == 1);

aciertoPosi = positivos_en_positivos/nrow(test_p);
aciertoNega = negativos_en_negativos/nrow(test_n);


#porsentage de aciertos positivos y aciertos negativos.
paste("aciertos Positivos: ", aciertoPosi);
paste("aciertos negativos ",aciertoNega);



#Elaboracion de la matriz de confucion.
matriz_con <- matrix(0,3,2);

matriz_con[1,1] = positivos_en_positivos;
matriz_con[2,1] = negativos_en_positivos;
matriz_con[2,2] = negativos_en_negativos;
matriz_con[1,2] = positivos_en_negativos;

matriz_con[3,1] = positivos_en_positivos + negativos_en_positivos;
matriz_con[3,2] = negativos_en_negativos + positivos_en_negativos;

colnames(matriz_con) <- c("P","N");
rownames(matriz_con) <- c("P","N","Tot");
colnames(raw) <- c("BID-RADS","Edad","Forma","Margen","Densidad","Gravedad");

matriz_con
##Fin de elaboracion de matriz de confucion.


##grafica de pastel positivos y negativos
info <- c(positivos_en_positivos,negativos_en_positivos);
pastelito(info,c("Aciertos Positivos","Falsos Negativos"),"Positivos Test Resultado");

info <- c(negativos_en_negativos,positivos_en_negativos);
pastelito(info,c("Aciertos Negativos","Falsos Positivos"),"Negativos Test Resultado");
##fin de graficas de pastel.


##inicio de codigo para imprimir matriz de graficas de disporcion###.
cols <- character(nrow(raw));
cols[] <- "black";

cols[raw$Gravedad == 0] <- "blue";
cols[raw$Gravedad == 1] <- "red";
x11();
pairs(raw[,1:5], col=cols,main="Matriz de graficas de dispersi�n.", pch = 21,oma=c(4,4,6,12));
par(xpd=TRUE)
legend(0.88, 0.7, c("Benigno","Maligno"),  
       fill=c("blue", "red"));
###end matriz de graficas de dispercion###.


