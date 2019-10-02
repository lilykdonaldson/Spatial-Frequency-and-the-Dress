J = imread('theDress.png');
% filter each channel separately
gaus = fspecial('gaussian',5,3);
r = imfilter(J(:, :, 1), gaus);
g = imfilter(J(:, :, 2), gaus);
b = imfilter(J(:, :, 3), gaus);

% reconstruct the image from r,g,b channels
K = cat(3, r, g, b);

lap = fspecial('laplacian',0.3);
rL = imfilter(J(:, :, 1), lap);
gL = imfilter(J(:, :, 2), lap);
bL = imfilter(J(:, :, 3), lap);

% reconstruct the image from r,g,b channels
L = cat(3, rL, gL, bL);
M = imadd(K,L);

figure
subplot(141);imshow(J);
subplot(142);imshow(K);
subplot(143);imshow(L);
subplot(144);imshow(M);



X = genPyr(J,'gauss',1);
Y = pyrReconstruct(X);
figure
subplot(111);imshow(Y);


function [ pyr ] = genPyr( img, type, level )
%GENPYR generate Gaussian or Laplacian pyramid
%   PYR = GENPYR(A,TYPE,LEVEL) A is the input image, 
%	can be gray or rgb, will be forced to double. 
%	TYPE can be 'gauss' or 'laplace'.
%	PYR is a 1*LEVEL cell array.
% Yan Ke @ THUEE, xjed09@gmail.com
pyr = cell(1,level);
pyr{1} = im2double(img);
for p = 2:level
	pyr{p} = pyr_reduce(pyr{p-1});
end
if strcmp(type,'gauss'), return; end
for p = level-1:-1:1 % adjust the image size
	osz = size(pyr{p+1})*2-1;
	pyr{p} = pyr{p}(1:osz(1),1:osz(2),:);
end
for p = 1:level-1
	pyr{p} = pyr{p}-pyr_expand(pyr{p+1});
end
end

function [ img ] = pyrReconstruct( pyr )
%PYRRECONSTRUCT Uses a Laplacian pyramid to reconstruct a image
%   IMG = PYRRECONSTRUCT(PYR) PYR should be a 1*level cell array containing
%   the pyramid, SIZE(PYR{i}) = SIZE(PYR{i-1})*2-1
%		Yan Ke @ THUEE, xjed09@gmail.com
for p = length(pyr)-1:-1:1
	pyr{p} = pyr{p}+pyr_expand(pyr{p+1});
end
img = pyr{1};
end
