
pid = 1;
NumImgs = 21;
photo = double(imread('PIE_Nolight/1/1.bmp'));
X = zeros([NumImgs size(photo)]);

    for i = 1:NumImgs
        path = ['PIE_Nolight/' num2str(pid) '/' num2str(i) '.bmp'];
        photo = imread(path);
        %X(i,:,:) = photo;
        columnVec = photo(:);
    end
