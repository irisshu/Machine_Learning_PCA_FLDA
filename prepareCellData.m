
N = 65;
X = cell(1,N);
trainIndex = {7,10,19};

for i=1:N
    for j=1:3
        path = ['PIE_Nolight/' num2str(i) '/' num2str(cell2mat(trainIndex(j))) '.bmp'];
        photo = imread(path);
        columnVec = photo(:);
        D(: ,j) = columnVec;  
    end       
    X{i} = D(: ,j);
end