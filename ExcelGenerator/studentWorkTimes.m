N = 75;
StudentTimes = zeros(1,N);
for n = 1 : N
    StudentTimes(n) = randi([300, 500]);
end

fileName = "StudentWorkTimes.xlsx";

col_header(1,1:N)={'Student'};
row_header(1,1)={'Time'};

xlswrite(fileName,StudentTimes,'Sheet1','B2');
xlswrite(fileName',col_header,'Sheet1','B1');
xlswrite(fileName,row_header,'Sheet1','A2');
 