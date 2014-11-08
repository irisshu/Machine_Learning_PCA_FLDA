
pid = 1;
NumImgs = 21;
photo = double(imread('PIE_Nolight/1/1.bmp'));
imgMatrix = zeros(100*100, NumImgs);


    for i = 1:NumImgs
        path = ['PIE_Nolight/' num2str(pid) '/' num2str(i) '.bmp'];
        photo = imread(path);
        columnVec = photo(:);
        imgMatrix(: ,i) = columnVec;
        
    end
meanVal =  mean(imgMatrix,2);
for i=1:NumImgs
    imgMatrix(: ,i) = imgMatrix(: ,i)-meanVal;
    %subplot(5,5,i);
    %image(reshape(imgMatrix(:,i),[100,100]));
end

G = imgMatrix'*imgMatrix;
%G_sort = sort(abs(G),'descend');

[u, D] = eig(G);
v = imgMatrix*u;

dvec = diag(D);
NV = zeros(size(v));
[dvec,index_dv] = sort(abs(dvec));
index_dv = flipud(index_dv);
for i = 1:size(D,1)
  ND(i,i) = D(index_dv(i),index_dv(i));
  NV(:,i) = v(:,index_dv(i));
end;

%plot mean vector
subplot(5,5,1);
image(reshape(meanVal,[100,100]) );

for i=1:NumImgs
    subplot(5,5,i+1);
    image(reshape(NV(:,i),[100,100]));
end


% [test_u,test_D] = (reshape(NV(:,i),[100,100])