function [ Prediccion ] = Predict(Test, Conteo_M_Norm, Prob_M, Conteo_B_Norm, Prob_B)
    Cols=[2,3,4,5,6,7,8,9,10];
    s = Test; 
    Prediccion = zeros(size(Test, 1),1); 
    num_cols = size(Cols, 2);
    
    for num_reg=1:size(Test,1);
        ProbsM=1; 
        ProbsB=1; 
        for col=2:num_cols+1
        valor = s(num_reg, col);
        idx = find(Conteo_M_Norm(:, 1)==valor);

        ProbsM = ProbsM * Conteo_M_Norm(idx, col); 
        ProbsB = ProbsB * Conteo_B_Norm(idx, col);
        end

        ProbsM = ProbsM * Prob_M;
        ProbsB = ProbsB * Prob_B;

        if ProbsM > ProbsB
            Prediccion(num_reg, 1)=1;
        else
            Prediccion(num_reg, 1)=0;
        end
    end
end