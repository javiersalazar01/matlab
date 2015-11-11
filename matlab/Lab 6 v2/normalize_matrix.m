function [I, max_val, min_val] = normalize_matrix(I)
%normalize matrix
% Regresa la matriz I normalizada, as? como los arrays max_val y
% min_val que contienen 3 elementos cada no con el max y min valor de
% cada una de las 3 dimensiones de I

I=double(I);

min_val = [min(min(I(:,:,1))), min(min(I(:,:,2))),min(min(I(:,:,3)))]
max_val = [max(max(I(:,:,1))), max(max(I(:,:,2))),max(max(I(:,:,3)))]

I(:,:,:) = I(:,:,:) + 1;

I(:,:,1) = I(:,:,1)/max_val(1);
I(:,:,2) = I(:,:,2)/max_val(2);
I(:,:,3) = I(:,:,3)/max_val(3);

end