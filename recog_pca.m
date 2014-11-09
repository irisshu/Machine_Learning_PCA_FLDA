
% Only calculate PCA for one person ----------------------------
NumTrain = 3;
% NumPeople = 65;
imgMatrix = zeros(100*100, NumTrain);
trainIndex = {7,10,19};

for i=1:NumTrain
    path = ['PIE_Nolight/1/' num2str(cell2mat(trainIndex(i))) '.bmp'];
    photo = imread(path);
    columnVec = photo(:);
    imgMatrix(: ,i) = columnVec;  
end   

m =  mean(imgMatrix,2); % Get mean vector m
for i=1:NumTrain
    imgMatrix(: ,i) = imgMatrix(: ,i)-m;  
end

G = imgMatrix'*imgMatrix;
[u, oD] = eig(G);
v = imgMatrix*u;
v = (v/norm(v));

dvec = diag(oD);
V = zeros(size(v));
[dvec,index_dv] = sort(abs(dvec));
index_dv = flipud(index_dv);
for i = 1:size(oD,1)
  D(i,1) = oD(index_dv(i),index_dv(i)); % Get column vector D (eigenvalue)
  V(:,i) = v(:,index_dv(i)); % Get matrix V
end;
%------------------------------------------------
for j=1:NumTrain
    path = ['PIE_Nolight/1/' num2str(cell2mat(trainIndex(i))) '.bmp'];
    photo = imread(path);
    p = double(photo(:));
    pc_tran{1}{j} = V'*(p-m); 
end   


