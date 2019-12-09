clear
figure(1); clf

RGB2LMSMat = [29.190	32.837	9.120;
           4.478	22.746	9.254;
           0.151	2.915	104.298];

       
FiltSize = 20;
FiltRATIO = 3;
  
Im = imread('DressHigher.jpg');
Im = double(Im)/255;
Ave = mean(mean(Im));

%Filter RGB*********

for i=1:3,
    Iblur(:,:,i)  = imgaussfilt(Im(:,:,i), FiltSize);
    Iblur2(:,:,i) = imgaussfilt(Im(:,:,i), FiltSize*FiltRATIO);
    IHigh(:,:,i)  = (Im(:,:,i)-Iblur(:,:,i))+Ave(i);
    Iband(:,:,i)  = Iblur(:,:,i)-Iblur2(:,:,i) + Ave(:,:,i);
end

%Present RGB filtered image *********
figure(1);  subplot(2,2,1),imshow(Im)
figure(1);  subplot(2,2,2),imshow(Iblur)
figure(1);  subplot(2,2,3),imshow(IHigh)
figure(1);  subplot(2,2,4),imshow(Iband)

ImSize = size(Im);

%Convert original image to M & B units*********
for i = 1:ImSize(1)
   for j = 1:ImSize(2)
      Im_inMB(i,j,1:3) = RGB2MBImage(Im(i,j,1:3),RGB2LMSMat)';
   end
   if (mod(i,100) == 0)
       disp(i)
   end
end



Ave_MB = mean(mean(Im_inMB));

%Filter image in M & B units*********
for i=1:3,
    Iblur_MB(:,:,i)  = imgaussfilt(Im_inMB(:,:,i), FiltSize);
    Iblur2_MB(:,:,i) = imgaussfilt(Im_inMB(:,:,i), FiltSize*FiltRATIO);
    IHigh_MB(:,:,i)  = Im_inMB(:,:,i)-Iblur_MB(:,:,i) + Ave_MB(:,:,i);
    Iband_MB(:,:,i)  = Iblur_MB(:,:,i)-Iblur2_MB(:,:,i) + Ave_MB(:,:,i);
end


%Convert M&B to RGB *********
for i = 1:ImSize(1)
   for j = 1:ImSize(2)
      NewImageOrig(i,j,1:3) =  MB2RGB(Im_inMB(i,j,1:3), RGB2LMSMat);
      NewImageHigh(i,j,1:3) =  MB2RGB(IHigh_MB(i,j,1:3),RGB2LMSMat);
      NewImageLow(i,j,1:3) =   MB2RGB(Iblur_MB(i,j,1:3),RGB2LMSMat);
      NewImageBand(i,j,1:3) =  MB2RGB(Iband_MB(i,j,1:3),RGB2LMSMat);
   end
   if (mod(i,100) == 0)
       disp(i)
   end
end;

%Present RGB *********
figure(2);  subplot(2,2,1),imshow(NewImageOrig)
figure(2);  subplot(2,2,2),imshow(NewImageLow)
figure(2);  subplot(2,2,3),imshow(NewImageHigh)
figure(2);  subplot(2,2,4),imshow(NewImageBand)


%figure(2);  subplot(2,2,2),plot(MBvalue(:,:,1),MBvalue(:,:,2),'*')
%axis([.6 .75 0 1.5]) 

function LmSmLum =  RGB2MBImage(RGBvalueI,RGB2LMSMatI) 
  %RGBvalue is 1x3 from 0 1;
  
  RGB(1) = RGBvalueI(1);
  RGB(2) = RGBvalueI(2);
  RGB(3) = RGBvalueI(3);
  LMS = RGB2LMSMatI*RGB';
  LmSmLum = [LMS(1)/sum(LMS(1:2)) LMS(3)/sum(LMS(1:2)) sum(LMS(1:2))];
end  

function RGB =  MB2RGB(LmSmLum,RGB2LMSMatI); 
  %RGBvalue is 1x3 from 0 1;
  L = LmSmLum(1)*LmSmLum(3);
  M = (1-LmSmLum(1))*LmSmLum(3);
  S = LmSmLum(2)*(L+M);
  LMS = [L M S]';
  
  RGB = inv(RGB2LMSMatI)*LMS;
end 

