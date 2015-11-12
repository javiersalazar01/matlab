% LAB 5. Clustering K-Means
% En este lab agruparemos las muestras en clusters. Este tipo de algoritmos
% es de aprendizaje no-supervisado, esto es, proporcionamos las muestras y
% el algoritmo agrupa de modo autom?tico las que m?s se parezcan. El
% principal problema con este tipo de algoritmos es que se tiene que
% proporcionar un n?mero K determinado de clusters desde el inicio. Entre
% mayor sea K, m?s fina ser? la agrupaci?n, m?s parecidos ser?n los
% elementos de cada grupo, pero con una K muy grande se corre el riesgo de
% dividir elementos de la misma clase.
% El algoritmo para realizar clustering usando K-Means es:
% 1. Asigne los valores a los K centros de manera aleatoria
% 2. Calcule la distancia entre cada muestra y los centros
% 3. Asigne cada muestra al centro que le quede m?s cerca
% 4. Calcular nuevos centros usando la media de todas las muestras que
% quedaron en su grupo
% 5. Repita a partir del punto 2 hasta que el cambio en la asignaci?n de
% puntos no cambie.
% En este lab aplicaremos KMeans a una imagen.
% Colour-Based Image Segmentation Using K-Means 
% 1: Leer Imagen
% 2: Convertir imagen de RGB a un espacio de color para procesar
% 3: Clasificar los colores usando K-means (pasos arriba)
% 4: Etiqueta cada pixel en la imagen con el cluster que le corresponde
% 5: Repetir hasta que converja o hasta llegar al num de iteraciones
% 1. Leer imagen 
image= 'sunset.tiff';
I1=imread(image);
%Para desplegar la imagen:
NI=uint8(I1);
figure('name', 'k-means ');
imshow(NI);
% sacar una copia de los datos
s=size(I1);
I=zeros(s(1), s(2), 3);
I(:,:,1)= I1(:,:,1);
I(:,:,2)= I1(:,:,2);
I(:,:,3)= I1(:,:,3);
s = size(I);
new_image=zeros(s);
num_rows= s(1); 
num_cols=s(2);
num_elems = num_rows * num_cols;
% Crea dos vectores con las posiciones de x y y normalizadas. ss es el
% peso para x y y. Manejaremos 1
[x_mat, y_mat] = create_xymatMD(num_rows, num_cols, 1);

% normalize I
[I, max_val, min_val] = normalize_matrix(I);
% This matrix just contains the x and y
% for an index i. This is used to manage the feature vector 
% since the image matrix positions are lost once the feature vectors
% are computed
index = generate_xy(num_elems, num_cols);
% choose the data points for centers, taking the color different points in
% different segments of the image. 
centers = init_centers(10, num_rows, num_cols, I, x_mat, y_mat, 1);

%feature vectors is a matrix where every row is a feature vector
feature_vectors = create_feature_vector(I, centers, num_elems, num_cols, x_mat, y_mat);
for it=1:5
   
[clusters, cluster_assigned, sum_values, tot_sqr_sum] = allocate_points_matrices(feature_vectors,centers, 10, num_rows, num_cols);
centers = compute_new_means(centers, sum_values, cluster_assigned);
fprintf('\n It %d %f \n ', it, tot_sqr_sum);

end

