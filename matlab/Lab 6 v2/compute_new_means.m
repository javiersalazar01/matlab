function centers = compute_new_means(centers, sum_values, cluster_assigned)

    dim = size(cluster_assigned);

    for i=dim(1)
        centers(i,:) = sum_values(i,:)/cluster_assigned(i)
    end
    
end