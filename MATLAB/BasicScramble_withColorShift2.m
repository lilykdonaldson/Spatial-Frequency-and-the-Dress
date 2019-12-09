clear;
Im = mat2gray(double(imread('TheDress.png')));
%read and rescale (0-1) image

ImSize = size(Im);

%RandomPhase = angle(fft2(rand(ImSize(1), ImSize(2))));
%generate random phase structure

for layer = 1:ImSize(3)
    ImFourier(:,:,layer) = fft2(Im(:,:,layer));       
%Fast-Fourier transform
    Amp(:,:,layer) = abs(ImFourier(:,:,layer));   
    AmpFilterHigh(:,:,layer) = Amp(:,:,layer);
    AmpFilterLow(:,:,layer) = Amp(:,:,layer);
    n = 7;
    AmpFilterHigh(:,n:225,layer) = zeros(300,length([n:225]));
    AmpFilterLow(:,2:n,layer) = zeros(300,length([2:n]));
    size(Amp)
%amplitude spectrum
    Phase(:,:,layer) = angle(ImFourier(:,:,layer));
%phase spectrum
    %Phase(:,:,layer) =  RandomPhase;
%add random phase to original phase
   
ImScrambled(:,:,layer) = ifft2(Amp(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
ImScrambledFilterHigh(:,:,layer) = ifft2(AmpFilterHigh(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   
ImScrambledFilterLow(:,:,layer) = ifft2(AmpFilterLow(:,:,layer).*exp(sqrt(-1)*(Phase(:,:,layer))));   

%combine Amp and Phase then perform inverse Fourier
end

ImScrambled = real(ImScrambled); %get rid of imaginery part in image (due to rounding error)
ImScrambledFilterHigh = real(ImScrambledFilterHigh); %get rid of imaginery part in image (due to rounding error)
ImScrambledFilterLow = real(ImScrambledFilterLow); %get rid of imaginery part in image (due to rounding error)

imwrite(ImScrambled,'DressScrambled.jpg','jpg');
imwrite(ImScrambledFilterHigh,'DressFilterScrambledHigh.jpg','jpg');
imwrite(ImScrambledFilterLow,'DressFilterScrambledLow.jpg','jpg');

figure(2);  subplot(3,2,1),imshow(ImScrambled)
figure(2);  subplot(3,2,3),imshow(ImScrambledFilterHigh)
figure(2);  subplot(3,2,5),imshow(ImScrambledFilterLow)