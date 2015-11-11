function [Prob] = Prob_Malignidad( A, columna, valor_col )
    m_universo = sum(sum(A(:,columna) == valor_col));
    m_total = sum(sum(A(:,columna)== valor_col & A(:,11) == 4));
    Prob = m_total / m_universo; 
end