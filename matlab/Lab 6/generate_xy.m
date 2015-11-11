 function index = generate_xy(num_elems, num_cols)
%generates a matrix with the correspondent x and y for index i 
%when the matrix is represented as a vector
% index:
% x y
    index = zeros(num_elems, 2, 'uint16');
    for i = 1: num_elems
    [x, y] = compute_idx(i, num_cols);
    index(i, 1) = x;
    index(i, 2) = y;

    end

end