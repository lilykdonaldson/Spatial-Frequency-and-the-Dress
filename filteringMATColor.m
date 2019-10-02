J = imread('theDress.png');

redChannel = J(:, :, 1);
greenChannel = J(:, :, 2);
blueChannel = J(:, :, 3);

amplitudeFactor = 1.1; 
greenChannel  = uint8(double(greenChannel) * amplitudeFactor);
blueChannel  = uint8(double(blueChannel) / amplitudeFactor);
% Recombine
A = cat(3, redChannel, greenChannel, blueChannel);

amplitudeFactor = 1.2; 
greenChannel  = uint8(double(greenChannel) * amplitudeFactor);
blueChannel  = uint8(double(blueChannel) / amplitudeFactor);
% Recombine
B = cat(3, redChannel, greenChannel, blueChannel);

amplitudeFactor = 1.1; 
greenChannel  = uint8(double(greenChannel) / amplitudeFactor);
blueChannel  = uint8(double(blueChannel) * amplitudeFactor);
% Recombine
C = cat(3, redChannel, greenChannel, blueChannel);

amplitudeFactor = 1.2; 
greenChannel  = uint8(double(greenChannel) / amplitudeFactor);
blueChannel  = uint8(double(blueChannel) * amplitudeFactor);
% Recombine
D = cat(3, redChannel, greenChannel, blueChannel);

figure
subplot(141);imshow(A);
subplot(142);imshow(B);
subplot(143);imshow(C);
subplot(144);imshow(D);
