
% Only calculate PCA for one person ----------------------------
NumTrain = 3;
NumPeople = 65;
imgMatrix = zeros(100*100, NumTrain);
trainIndex = {7,10,19};

for i=1:NumPeople
    for j=1:NumTrain
        path = ['PIE_Nolight/' num2str(i) '/' num2str(cell2mat(trainIndex(j))) '.bmp'];
        photo = imread(path);
        columnVec = photo(:);
        imgMatrix(: ,j) = columnVec;  
    end   

    m =  mean(imgMatrix,2); % Get mean vector m
    for j=1:NumTrain
        imgMatrix(: ,j) = imgMatrix(: ,j)-m;  
    end

    G = imgMatrix'*imgMatrix;
    [u, oD] = eig(G);
    v = imgMatrix*u;
    v = (v/norm(v));

    dvec = diag(oD);
    V = zeros(size(v));
    [dvec,index_dv] = sort(abs(dvec));
    index_dv = flipud(index_dv);
    for j = 1:size(oD,1)
      D(j,1) = oD(index_dv(j),index_dv(j)); % Get column vector D (eigenvalue)
      V(:,j) = v(:,index_dv(j)); % Get matrix V
    end;
    %------------------------------------------------
    for j=1:NumTrain
        path = ['PIE_Nolight/' num2str(i) '/' num2str(cell2mat(trainIndex(j))) '.bmp'];
        photo = imread(path);
        p = double(photo(:));
        pc_tran{i}{j} = V'*(p-m); 
    end   
end


