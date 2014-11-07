data=[];
for i=1:21
    d=imread(sprintf('%d.bmp',i));
    [d1 d2]=size(d);
    data=[data d(:)];
end
data=double(data);
[V,score,latent,tsquare]=princomp(data);
m=mean(data,2);
figure(2);
subplot(6,4,1);
im=reshape(m,d1,d2);
imagesc(im); colormap gray;
title('mean');
for i=1:21
    subplot(6,4,i+1);
    im=reshape(V(:,i),d1,d2);
    imagesc(im); colormap gray;
    title(sprintf('eigenface %d',i));
end
