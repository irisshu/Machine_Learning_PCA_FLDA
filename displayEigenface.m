
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
    subplot(5,5,i);
    image(reshape(imgMatrix(:,i),[100,100]));
end

G = imgMatrix'*imgMatrix;
sort(abs(G));
[u, D] = eig(G);
v = imgMatrix*u;
normalized_v = v/norm(v);

% Plot "mean" picture
subplot(5,5,22);
image(reshape(meanVal,[100,100]) );