function [inputMatrix] = randomFill(inputMatrix, N)
    for n = 1 : N
        for m = 1 : N
            if m == n
                inputMatrix(n,m) = 1000;
            elseif m > n
                inputMatrix(n,m) = randi([100 300]);
            else
                inputMatrix(n,m) = inputMatrix(m,n);
            end
        end
    end
end

