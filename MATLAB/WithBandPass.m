clear
figure(1); clf

Im = mat2gray((imread('TheDress.png')));
%read and rescale (0-1) image



figure(1);  subplot(2,2,1),imshow(Im)
 
size(Im)
OutImage(:,:,1) =   Im(:,:,2); % FilterCentSurround(Im(:,:,1),1,1); 
OutImage(:,:,2) =   Im(:,:,3); % FilterCentSurround(Im(:,:,2),1,1); 
OutImage(:,:,3) =   FilterCentSurround(Im(:,:,1),2,1); 

figure(1);  subplot(2,2,2),imshow(double(OutImage));


function filtered_image = FilterCentSurround(I,d0,d1)
%Butterworth Bandpass Filter
% This simple  function was written modified from Digital Image Processing course
% Eastern Mediterranean University Assoc. Prof. Dr. Hasan Demirel
 figure(3); clf
f = double(I);
[nx ny] = size(f);
f = uint8(f);
fftI = fft2(f,2*nx-1,2*ny-1);
fftI = fftshift(fftI);
subplot(2,2,1)
imshow(f,[]);

title('Original Image')
subplot(2,2,2)
fftshow(fftI,'log')
title('Fourier Spectrum of Image')

% Initialize filter.
filter1 = ones(2*nx-1,2*ny-1);
filter2 = ones(2*nx-1,2*ny-1);
filter3 = ones(2*nx-1,2*ny-1);
for i = 1:2*nx-1
    for j =1:2*ny-1
        dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
        % Use Gaussian filter.
        filter1(i,j) = exp(-dist^2/(2*d1^2));
        filter2(i,j) = exp(-dist^2/(2*d0^2));
        filter3(i,j) = 1.0 - filter2(i,j);
        filter3(i,j) = filter1(i,j).*filter3(i,j);
    end
end
% Update image with passed frequencies
filtered_image = fftI + filter3.*fftI;
% subplot(2,2,3)
% fftshow(filter3,'log')
% title('Frequency Domain Filter Function Image')
filtered_image = ifftshift(filtered_image);
filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
filtered_image = real(filtered_image(1:nx,1:ny));
filtered_image = uint8(filtered_image);
 subplot(2,2,4)
imshow(filtered_image,[])
 title('Bandpass Filtered Image')

end




