
NumImgs = 65*21;
photo = double(imread('PIE_Nolight/1/1.bmp'));
X = zeros([NumImgs size(photo)]);

for i = 1:65
    for j = 1:21
        path = ['PIE_Nolight/' num2str(i) '/' num2str(j) '.bmp'];
        photo = imread(path);
        X(i*j,:,:) = photo;
                    
    end
end
