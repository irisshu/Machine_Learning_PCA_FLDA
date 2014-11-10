% function recogRate = OptimizeParam_pca(k)
% k = subDim
% If subDim is not given, subDim = dim - 1;

subDim = 195-1;

NumTrain = 3;
NumPeople = 65;
imgMatrix = zeros(100*100, NumTrain);
trainIndex = {7,10,19};


% Creating training images space
dim = NumPeople*NumTrain ;
for i=1:NumPeople
    for j=1:NumTrain
        path = ['PIE_Nolight/' num2str(i) '/' num2str(cell2mat(trainIndex(j))) '.bmp'];
        photo = imread(path);
        columnVec = photo(:);
        imgMatrix(: ,i*j) = columnVec;  
    end   
end
    % Get mean vector m
    m =  mean(imgMatrix,2); 
    for i=1:dim
        imgMatrix(: ,i) = imgMatrix(: ,i)-m;  
    end

    %PCA
    G = imgMatrix'*imgMatrix;
    [u, oD] = eig(G);
    dvec = diag(oD);        
    [dvec,index_dv] = sort(abs(dvec));
    index_dv = flipud(index_dv);
    
    D = zeros(size(oD));
    V = zeros(size(u));
    for i = 1:size(oD,1)
      D(i,i) = oD(index_dv(i),index_dv(i)); % Get column vector D (eigenvalue)
      V(:,i) = u(:,index_dv(i)); % Get matrix V
    end;

    D = diag(D);
    D = D / (dim-1);
    D = D(1 : subDim);        % Retaining only the largest subDim ones

    V = imgMatrix * V;    % Turk-Pentland trick (part 2)
    
    % Normalisation to unit length
    for i = 1 : dim
        V(:, i) = V(:, i) / norm(V(:, i));
    end;
    
    % Dimensionality reduction. 
    w = V(:, 1:subDim);
    
   % Subtract mean face from all images 
    %zeroMeanDATA = zeros(size(DATA));
    for i=1:NumPeople
        for j=1:NumTrain
            path = ['PIE_Nolight/' num2str(i) '/' num2str(cell2mat(trainIndex(j))) '.bmp'];
            photo = imread(path);
            p = double(photo(:));
            pc_train{i}{j} = w'*(p-m); 
        end   
    end


%---------------
correct_ans = 0;
    
for i=1:NumPeople
    for j=1:21
       if(j~=7 && j~=10 && j~= 19)
            % Calculate pc_test
            path = ['PIE_Nolight/' num2str(i) '/' num2str(j) '.bmp'];
            photo = imread(path);
            p = double(photo(:));
            pc_test = w'*(p-m);               

            %label  
            minDist = inf;    
            for c=1:65
                for q=1:3
                     Dist = norm(pc_test-pc_train{c}{q});
                    if (Dist < minDist)
                        minDist = Dist;
                        classLabel = c;                          
                    end                   
                end
                if(classLabel==i)
                         correct_ans = correct_ans +1;
                end   
            end
            
        end        
    end      
end

recogRate = correct_ans/(65*(21-3)) ;
line = ['Recognition rate = ',num2str(recogRate) ];
disp(line);


%end
