function [feature_vect] = create_feature_vector(I, center, num_elems, num_cols, x_mat, y_mat)
% returns a matrix diff_mat containing the differences from each pixel to
% the center value-> (which is a color)


%I=double(I);
sc = size(center);

feature_vect = zeros(num_elems, sc(2));
for i=1: num_elems
[x, y]=compute_idx(i, num_cols);
feature_vect(i, 1:3) = [I(x, y, :)];
feature_vect(i, 4:5) = [x_mat(x), y_mat(y)]; 
end


end