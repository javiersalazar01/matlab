function [Prob] = Prob_Malignidad( A, columna, valor_col )
    m_universo = size(A,1);
    m_total = sum(sum(A(:,columna) == valor_col));
    Prob = m_total / m_universo;
end