clear
figure(1); clf

RGB2LMSMat = [29.190	32.837	9.120;
           4.478	22.746	9.254;
           0.151	2.915	104.298];

FiltSize = 20;
FiltRAT = 3;
Im = imread('DressHigher.jpg');
Im = double(Im)/255;
Ave = mean(mean(Im));

for i=1:3,
    Iblur(:,:,i) = imgaussfilt(Im(:,:,i), FiltSize);
    Iblur2(:,:,i) = imgaussfilt(Im(:,:,i), FiltSize*FiltRAT);
    IHigh(:,:,i) = (Im(:,:,1)-Iblur(:,:,i))+Ave(i);
    Iband(:,:,i) = Iblur(:,:,i)-Iblur2(:,:,i) + Ave(:,:,i);
end

figure(5);  subplot(2,2,1),imshow(Im)
figure(5);  subplot(2,2,2),imshow(Iblur)
figure(5);  subplot(2,2,3),imshow(IHigh)
figure(5);  subplot(2,2,4),imshow(Iband)

