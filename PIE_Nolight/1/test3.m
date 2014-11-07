data=[];
for i=1:21
    d=imread(sprintf('%d.bmp',i));
    [d1 d2]=size(d);
    data=[data d(:)];
end
data=double(data);
[V D m]=PCA(data);
subplot(3,4,1);
im=reshape(m,d1,d2);
imagesc(im); colormap gray;
title('mean');
for i=1:11
    subplot(3,4,i+1);
    im=reshape(V(:,i),d1,d2);
    imagesc(im); colormap gray;
    title(sprintf('eigenface %d',i));
end
