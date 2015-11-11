function [row, col]=compute_idx(idx, ncols)
idx_base=floor(idx/ncols);
residuo=mod(idx, ncols);
if idx_base == 0
row=1;
col=residuo;
else
if residuo == 0
col=ncols;
row=idx_base;
else
%row = idx_base + 1;
row = idx_base;
col = residuo;
end
end
end