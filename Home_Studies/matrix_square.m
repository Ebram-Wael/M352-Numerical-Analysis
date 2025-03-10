function [A] = matrix_square(X)
    for i = 1 : 3
        for j = 1 : 3
            A(i,j) = X(i,j)^2;
        end
    end
endfunction