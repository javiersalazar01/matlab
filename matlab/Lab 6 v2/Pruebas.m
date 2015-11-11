
num_rows = 236;
num_cols = 364;
k =10;


clusters = zeros(num_rows, num_cols); % Matriz que en cada pixel tiene el num de cluster que le corresponde
cluster_assigned = zeros(1, k); % count of elements per cluster
tot_sqr_sum = 0; % Suma de las distancias totales de todos los elementos a sus centros m?s cercanos. Si tienes una matriz con las distancias de cada pixel al centro m?s cercano, este daro ser? la suma de todos los elementos de la matriz.
cs = size(centers); 
sum_values = zeros(k, cs(2)); % Contiene las sumas de todos los elementos de cada cluster. Nos servir? para calcular los promedios para volver a asignar los nuevos clusters para la siguiente iteraci?n


dimFeature = size(feature_vectors);
dimCen = size(centers);
distances = [];

    for i = 1:dimFeature(1)
        distances = [];
        for j = 1:dimCen(1)
            dis = (feature_vectors(i,1) - centers(j,1))^2 + (feature_vectors(i,2) - centers(j,2))^2 + (feature_vectors(i,3) - centers(j,3))^2
                  (feature_vectors(i,4) - centers(j,4))^2 + (feature_vectors(i,5) - centers(j,5))^2;
            distances = [distances,dis]; 
        end
        
        [m,mini] = min(distances);
        
        fila = ceil(i/num_cols);
        aux = mod(i,num_cols);
        
        
        if aux == 0
            columna = 364;
        else
            columna = aux;
        end    
        clusters(fila,columna) = mini;
        
    end