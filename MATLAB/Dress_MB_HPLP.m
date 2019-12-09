
%Program Plots the MB values of #TheDress in MB color space

clear
%Im = mat2gray(double(imread('TheDress.png')));
Im = mat2gray(double(imread('DressHigher.jpg')));
Im(:,:,1) = Im(:,:,2); 
Im(:,:,3) = Im(:,:,2); 

figure(1);  subplot(2,2,3),imshow(Im)
% Col 1 = R; 2 = G 3= B;
%Row 1 L; 2= M; 3 = S;
% Set up S, M, L trolands with 1 mm pupil
% and so that all R,G, B = (1, 1, 1) -> L/L+M S/L+M Lum . = .66, 1,  107.62
RGB2LMSMat = [29.190	32.837	9.120;
           4.478	22.746	9.254;
           0.151	2.915	104.298];
       
       


ImSize = size(Im)
for i = 1:ImSize(1)
   for j = 1:ImSize(2)
      MBvalue(i,j,1:3) = RGB2MBImage(Im(i,j,1:3),RGB2LMSMat)';
   end
   if (mod(i,100) == 0)
       disp(i)
   end
end
figure(1);  subplot(2,2,2),plot(MBvalue(:,:,1),MBvalue(:,:,2),'*')
axis([.6 .75 0 1.5]) 



%Convert back test
% for i = 1:ImSize(1)
%    for j = 1:ImSize(2)
%       NewImage(i,j,1:3) =  MB2RGB(MBvalue(i,j,1:3),RGB2LMSMat);
%    end
% end;
% figure(2);  subplot(2,2,1),imshow(NewImage)

%RandomPhase = angle(fft2(rand(ImSize(1), ImSize(2))));


for layer = 1:ImSize(3)
    layer
    ImFourier(:,:,layer) = fft2(MBvalue(:,:,layer));       
%Fast-Fourier transform
    Amp(:,:,layer) = abs(ImFourier(:,:,layer));   
    AmpFilterHigh(:,:,layer) = Amp(:,:,layer);
    AmpFilterLow(:,:,layer) = Amp(:,:,layer);
%filter Size . 
    n = 3; 
    AmpFilterHigh(:,2:n,layer) = zeros(ImSize(1),length([2:n]));
    AmpFilterLow(:,n:ImSize(2),layer) = zeros(ImSize(1),length([n:ImSize(2)]));

%amplitude spectrum
    Phase(:,:,layer) = angle(ImFourier(:,:,layer));
%phase spectrum
   
    %Phase(:,:,layer) =  RandomPhase;
%add random phase to original phase
    ImScrambled(:,:,layer) = ifft2(Amp(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
    ImScrambledFilterHigh(:,:,layer) = ifft2(AmpFilterHigh(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
    ImScrambledFilterLow(:,:,layer) = ifft2(AmpFilterLow(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   


   % ImScrambled(:,:,layer) = ifft2(Amp(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
   %ImScrambledFilterHigh(:,:,layer) = ifft2(AmpFilterHigh(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
   %ImScrambledFilterLow(:,:,layer) = ifft2(AmpFilterLow(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
%combine Amp and Phase then perform inverse Fourier
end

ImScrambled = real(ImScrambled); %get rid of imaginery part in image (due to rounding error)
ImScrambledFilterHigh = real(ImScrambledFilterHigh); %get rid of imaginery part in image (due to rounding error)
ImScrambledFilterLow = real(ImScrambledFilterLow); %get rid of imaginery part in image (due to rounding error)

disp('here again')
for i = 1:ImSize(1)
   for j = 1:ImSize(2)
      NewImageOrig(i,j,1:3) =  MB2RGB(ImScrambled(i,j,1:3),RGB2LMSMat);
      NewImageHigh(i,j,1:3) =  MB2RGB(ImScrambledFilterHigh(i,j,1:3),RGB2LMSMat);
      NewImageLow(i,j,1:3) =  MB2RGB(ImScrambledFilterLow(i,j,1:3),RGB2LMSMat);
   end
end;

figure(3);  subplot(3,2,1),imshow(NewImageOrig)
figure(3);  subplot(3,2,3),imshow(NewImageHigh)
figure(3);  subplot(3,2,5),imshow(NewImageLow)


figure(3);  subplot(3,2,2),plot(ImScrambled(:,:,1),ImScrambled(:,:,2),'*')
axis([.6 .75 0 1.5]) 
figure(3);  subplot(3,2,4),plot(ImScrambledFilterHigh(:,:,1),ImScrambledFilterHigh(:,:,2),'*')
axis([.6 .75 0 1.5])
figure(3);  subplot(3,2,6),plot(ImScrambledFilterLow(:,:,1),ImScrambledFilterLow(:,:,2),'*')
axis([.6 .75 0 1.5])

RGBreturn = MB2RGB(MBvalue,RGB2LMSMat); 


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
       