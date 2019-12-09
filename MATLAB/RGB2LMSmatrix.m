
% Col 1 = R; 2 = G 3= B;
%Row 1 L; 2= M; 3 = S;
% Set up S, M, L trolands with 1 mm pupil
% and so that all R,G, B = (1, 1, 1) -> L/L+M S/L+M Lum . = .66, 1,  107.62

RGB2LMSMat = [29.190	32.837	9.120;
           4.478	22.746	9.254;
           0.151	2.915	104.298];
       
RGBvalue = [.5, 1, 1]';

MBvalue = RGB2MB(RGBvalue,RGB2LMSMat)';

RGBreturn = MB2RGB(MBvalue,RGB2LMSMat); 
 

function LmSmLum =  RGB2MB(RGBvalueI,RGB2LMSMatI) 
  %RGBvalue is 1x3 from 0 1;
  LMS = RGB2LMSMatI*RGBvalueI;
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


