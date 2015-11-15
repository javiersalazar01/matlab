function [ Prediccion ] = Predict(Test, Conteo_p_norm, Prob_p, Conteo_n_norm, Prob_n)
    Cols=[1,2,3,4,5];
    s = Test; 
    Prediccion = zeros(size(Test, 1),1); 
    num_cols = size(Cols, 2);
    
    for num_reg=1:size(Test,1);
        ProbsP=1; 
        ProbsN=1;
        
        for col=1:num_cols
        valor = s(num_reg, col);
        idx = find(Conteo_p_norm(:, 1)==valor);

        ProbsP = ProbsP * Conteo_p_norm(idx, col + 1); 
        ProbsN = ProbsN * Conteo_n_norm(idx, col + 1);
        end

        ProbsP = ProbsP * Prob_p;
        ProbsN = ProbsN * Prob_n;

        if ProbsP > ProbsN
            Prediccion(num_reg, 1)=1;
        else
            Prediccion(num_reg, 1)=0;
        end
    end
end