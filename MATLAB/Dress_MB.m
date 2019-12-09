
%Program Plots the MB values of #TheDress in MB color space



Im = mat2gray(double(imread('TheDress.png')));




% Col 1 = R; 2 = G 3= B;
%Row 1 L; 2= M; 3 = S;
% Set up S, M, L trolands with 1 mm pupil
% and so that all R,G, B = (1, 1, 1) -> L/L+M S/L+M Lum . = .66, 1,  107.62
RGB2LMSMat = [29.190	32.837	9.120;
           4.478	22.746	9.254;
           0.151	2.915	104.298];
       
       
figure(1);  subplot(2,2,1),imshow(Im)

ImSize = size(Im);

for i = 1:ImSize(1)
   for j = 1:ImSize(2)
      MBvalue(i,j,1:3) = RGB2MBImage(Im(i,j,1:3),RGB2LMSMat)';
   end
end;

figure(1);  subplot(2,2,2),plot(MBvalue(:,:,1),MBvalue(:,:,2),'*')


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
       