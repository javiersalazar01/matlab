 function centers = init_centers(k, num_rows, num_cols, I, x_mat, y_mat, ss)

if mod(k, 2) >0
step_row =(k-1)/2;
step_col = (k+1)/2;

else
step_row =k/2;
step_col = k/2;
end
row_interval=floor(num_rows/step_row);
col_interval=floor(num_cols/step_col);




x = floor(row_interval / 2);
y = floor(col_interval / 2);
i =1;
for sx=1:step_row
for sy=1:step_col
if i >k
break;
end
centers(i,1:3)=I(x, y, 1:3);
centers(i, 4:5) = [x_mat(x), y_mat(y)];
i = i+1;
y = y + col_interval;
if y > num_cols
y = y - floor(col_interval/2);
end
end
x = x + row_interval;
if x > num_rows
x= x - floor(row_interval/2);
end
y = floor(col_interval / 2);

end
end