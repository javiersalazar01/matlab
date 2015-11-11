function [A] = Counting(Matrix, Cols, values)
   Cols2 = Cols + 1;
   A=values';
   Mtx=Matrix;
   for c=1:size(A,1)
     A(c,Cols2)= sum(Mtx(:, Cols)== A(c,1));
   end
end