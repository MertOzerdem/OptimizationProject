N = 10;
A = zeros(N,N);

numberOfMatrices = floor(N*log(N));
N = N + 1;

%Calculates average of NlnN matrices
outputMatrix = randomFill(A,N);
for n=1 : (numberOfMatrices - 1)
    temp = randomFill(A,N);
    outputMatrix = outputMatrix + temp;
end
outputMatrix = outputMatrix / numberOfMatrices;

%export matrix to excel file
N = N - 1;
fileName = "StudentsN" + N + ".xlsx";

row_header(1,1)={'professor'};
row_header(2:N+1,1)={'Students'};
col_header(1,1)={'professor'};
col_header(1,2:N+1)={'Students'};
%xlswrite(fileName,outputMatrix);

xlswrite(fileName,outputMatrix,'Sheet1','B2');     %Write data
xlswrite(fileName',col_header,'Sheet1','B1');     %Write column header
xlswrite(fileName,row_header,'Sheet1','A2');  
