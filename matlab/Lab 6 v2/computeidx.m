function idx=computeidx(x, num_cols, y)

if x==1 
idx=y;
else

idx= (x-1)*num_cols + y;
end

end