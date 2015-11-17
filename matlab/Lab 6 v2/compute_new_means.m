function centers = compute_new_means(centers, sum_values, cluster_assigned)
%cluster_assigned is the count of elements in each cluster
% sum_values is the sum of all the values of the elements of the cluster
% sum_values(i) contains the sum of:
% R G B X Y of all the members in cluster i.
s = size(centers);
k = s(1);
feature_size= s(2);
for i=1:k
    for j =1 : feature_size
    centers(i, j) = sum_values(i, j) / cluster_assigned(i); % En kmeans es solo i
    end
end