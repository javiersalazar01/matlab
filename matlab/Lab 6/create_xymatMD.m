function [x_mat, y_mat] = create_xymatMD(num_rows, num_cols, ss)
% Esta funci?n debe regresar dos vectores:
% x_mat, que contiene num_rows elementos. Cada elemento tiene la posici?n
% normalizada (de 0 a 1). La posici?n se normaliza dividiendo el num de
% posici?n entre el total de cols.
    x_mat = [1:num_cols];
    y_mat = [1:num_rows];
    x_mat(:) = (x_mat/num_cols) * ss;
    y_mat(:) = (y_mat/num_rows) * ss;
    x_mat = x_mat';
    y_mat = y_mat';
end