function recogRate = Opt_test(k)
subDim = k;

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
    D = zeros(size(oD,1));
        
    [dvec,index_dv] = sort(abs(dvec));
    index_dv = flipud(index_dv);
    for j = 1:size(oD,1)
      D(j,1) = oD(index_dv(j),index_dv(j)); % Get column vector D (eigenvalue)
      V(:,j) = v(:,index_dv(j)); % Get matrix V
    end;
   
    for j=1:NumTrain
        path = ['PIE_Nolight/' num2str(i) '/' num2str(cell2mat(trainIndex(j))) '.bmp'];
        photo = imread(path);
        p = double(photo(:));
        pc_train{i}{j} = V'*(p-m); 
    end   
end

correct_ans = 0;

class_Label = zeros(65,65);    
for i=1:NumPeople   
    for j=1:21
       if(j~=7 && j~=10 && j~= 19)
            % Calculate pc_test
            path = ['PIE_Nolight/' num2str(i) '/' num2str(j) '.bmp'];
            photo = imread(path);
            p = double(photo(:));
            pc_test = V'*(p-m);               

            %label               
            for c=1:65
                for k=1:3
                     Dist(3*(c-1) + k) = norm(pc_test-pc_train{c}{k});
                end
            end
            [Dist,index] = sort(Dist);
                        
             
           
            for ii=1 :subDim
                q = index(ii)/3;
                q = floor(q);
                m_od = mod(index(ii),3);
                %ii = ii +1;
                if (m_od~=0)
                    q = q+1;                    
                end
                class_Label(q,i) = class_Label(q,i)+1;
                if(class_Label(q,i) ==3)
                    ii =1000; % ¸õ¥X°j°é
                end
            end
            if(q==i)
               correct_ans = correct_ans +1;
            end
        end        
    end      
end

recogRate = correct_ans/(65*(21-3)) ;
recog = correct_ans/(NumPeople*(21-3)) *100;
line = ['Recognition rate = ',num2str(recog), '%' ];
disp(line);
end

