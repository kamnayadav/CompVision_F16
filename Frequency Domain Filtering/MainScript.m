% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file with all the required functionality

close all;
clear;

%
% Question 1 Part 1 : Gaussian Filtering
%
sampleIm = imread('Sample.jpg');
[outIm, D] = GaussianFilter(sampleIm);

% Plotting the outputs
figure(1);
subplot(2,2,1), imshow(sampleIm), title('Input Image');
subplot(2,2,2), imshow(D, []), title('Filter');
subplot(2,2,3), imshow(outIm,[]), title('Filtered Image');
disp('------Finished Solving Problem One Part One------');
pause;


%
% Question 1 Part 2 : Butterworth Filtering
%
[butterOut, BFilter] = Butterworth(sampleIm);

% Plotting the outputs
figure(2);
subplot(1,3,1), imshow(sampleIm), title('Original Image');
subplot(1,3,2), imshow(BFilter,[]), title('Butterworth high-pass filter');
subplot(1,3,3), imshow(butterOut), title('Filtered image');
disp('------Finished Solving Problem One Part Two------');
pause;


%
% Question 2 Part 1 : Adding noise in the frequency domain
%
city = imread('City.jpg');
cityF = fft2(city);
cityFS = fftshift(cityF);
outputFilter = NoiseModel(cityFS);
cityFSFiltered = cityFS .* outputFilter;
cityFSShifted = ifftshift(cityFSFiltered);
outputFilteredImage = uint8(abs(ifft2(cityFSShifted)));

% Plotting the outputs
figure(3);
subplot(1,2,1), imshow(outputFilter,[]), title('Noise Modeling filter');
subplot(1,2,2), imshow(outputFilteredImage), title('Filtered image');
imwrite(outputFilteredImage, 'BlurCity.bmp');
disp('------Finished Solving Problem Two Part One------');
pause;

%
% Question 2 Part 2 : Denoising the image using Wiener filter
%
blur = im2double(imread('BlurCity.bmp'));
blurF = fft2(blur);
blurFShifted = fftshift(blurF);
deblurFilter = ( (1 ./ outputFilter) .* (((abs(outputFilter)).^2) ./ (((abs(outputFilter)).^2 + 0.000075)))) .* blurFShifted;
deblurredShifted=ifftshift(deblurFilter);
deblurredOut=ifft2(deblurredShifted);

% Plotting the outputs
figure(4);
imshow(im2uint8(deblurredOut)), title('Deblurred image');
disp('------Finished Solving Problem Two Part Two------');
pause;


%
% Question 3 Part 1 : Magnitude and Phase display
%
cap = imread('Capitol.jpg');
capF = fft2(cap);
capFS = fftshift(capF);
sam = imread('Sample.jpg');
samF = fft2(sam);
samFS = fftshift(samF);
magC = abs(capFS);
phsC = angle(capFS);
magS = abs(samFS);
phsS = angle(samFS);

% Plotting the outputs
figure(5);
subplot(2,2,1), imshow(log(magC),[]), title('Capitol Magnitude');
subplot(2,2,2), imshow(phsC,[]), title('Capitol Phase');
subplot(2,2,3), imshow(log(magS),[]), title('Sample Magnitude');
subplot(2,2,4), imshow(phsS,[]), title('Sample Phase');
disp('------Finished Solving Problem Three Part One------');
pause;

%
% Question 3 Part 2 : Phase and magnitude usage
%
freqNewSam = magC .* exp(phsS *sqrt(-1));
nsS = ifftshift(freqNewSam);
newSample = ifft2(nsS);
freqNewCap = magS .* exp(phsC *sqrt(-1));
nsC = ifftshift(freqNewCap);
newCapitol = ifft2(nsC);

% Plotting the outputs
figure(6);
subplot(1,2,1), imshow(uint8(newSample)), title('New Sample');
subplot(1,2,2), imshow(uint8(newCapitol)), title('New Capitol');
disp('------Finished Solving Problem Three Part Two------');
pause;


%
% Question 4 : Removing additive Cosine Noise
%
boy = imread('boy_noisy.gif');
boyF = fft2(boy);
boyFS = fftshift(boyF);
magBoy = abs(boyFS);
magSorted = sort(magBoy(:),'descend');
for xLoop=2:2:8
    [indR, indC] = find(magBoy == magSorted(xLoop)); 
    for yLoop=1:2
        a = boyFS(indR(yLoop)-1:indR(yLoop)+1, indC(yLoop)-1:indC(yLoop)+1);
        sumA = sum(a(:)) - magSorted(xLoop);
        aMean = sumA / 8;
        boyFS(indR(yLoop),indC(yLoop)) = aMean;
    end
end
imagBoy = ifftshift(boyFS);
ismagBoy = ifft2(imagBoy);

% Plotting the outputs
figure(7);
subplot(1,2,1), imshow(uint8(ismagBoy),[]), title('Recovered Image');
subplot(1,2,2), imshow(boy), title('Original Image');
disp('Four highest frequencies were chosen because they reflect the frequencies most effected by cosine noise in the image and changing that helps enhance the image');
disp('------Finished Solving Problem Four------');
pause;


%
% Question 5 Part 1 : Wavelet transform operations
%
Lena = imread('Lena.jpg'); 
maxLevel = wmaxlev(size(Lena),'db2');
[COut,SOut] = wavedec2(Lena, maxLevel,'db2');
finalLena = uint8(waverec2(COut, SOut,'db2'));
if finalLena == Lena 
	disp('Images are equal'); 
else
	disp('Images are unequal'); 
end
disp('------Finished Solving Problem Five Part One------');
pause;


%
% Question 5 Part 2 : Wavelet transform operations
%
[CA1, CH1, CV1, CD1] = dwt2(Lena, 'db2'); 
[CA2, CH2, CV2, CD2] = dwt2(CA1, 'db2'); 
[CA3, CH3, CV3, CD3] = dwt2(CA2, 'db2'); 
tempArr = zeros(size(CA3)); 
ReconsCA2 = idwt2(tempArr, CH3, CV3, CD3, 'db2'); 
ReconsCA1 = idwt2(ReconsCA2, CH2, CV2, CD2, 'db2'); 
outputRecons1 = uint8(idwt2(ReconsCA1, CH1, CV1, CD1, 'db2')); 

tempArr1 = zeros(size(CH2)); 
ReconsCA21 = idwt2(CA3, CH3, CV3, CD3, 'db2'); 
ReconsCA11 = idwt2(ReconsCA21, tempArr1, CV2, CD2, 'db2'); 
outputRecons2 = uint8(idwt2(ReconsCA11, CH1, CV1, CD1, 'db2'));

% Plotting the outputs
figure(8);
subplot(1,2,1); imshow(outputRecons2), title('HL2 set to 0');
subplot(1,2,2); imshow(outputRecons1), title('Approximation coeff set to 0');
disp('Setting the approximation coefficients to 0 results in only edges getting displayed because intensity information is not present.');
disp('Setting the HL2 coefficients to 0 results in only vertical lines getting displayed.');
disp('------Finished Solving Problem Five Part Two------');
pause;


%
% Question 6
%
noisyLena = imnoise(Lena, 'gaussian', 0, 0.01);
dwtmode('per');
[CA12, CH12, CV12, CD12] = dwt2(noisyLena, 'db2'); 
[CA22, CH22, CV22, CD22] = dwt2(CA12, 'db2'); 
[CA32, CH32, CV32, CD32] = dwt2(CA22, 'db2');

tempArr1 = [CH12, CV12, CD12]; 
sigma1 = median(median(abs(tempArr1)))/(0.6745); 
threshold1 = sigma1 * sqrt(2 * log(numel(tempArr1))); 
[sizeX1,sizeY1] = size(tempArr1);
for xLoop = 1:sizeX1
    for yLoop = 1:sizeY1
        if tempArr1(xLoop, yLoop) >= threshold1
            tempArr1(xLoop, yLoop) =  tempArr1(xLoop, yLoop) - threshold1;  
        elseif tempArr1(xLoop, yLoop) <= -threshold1 
            tempArr1(xLoop,yLoop) = tempArr1(xLoop, yLoop) + threshold1; 
        elseif abs(tempArr1(xLoop, yLoop)) < threshold1 
            tempArr1(xLoop, yLoop) = 0; 
        end
    end
end
CH12 = tempArr1(1:sizeX1, 1:sizeX1); 
CV12 = tempArr1(1:sizeX1, sizeX1+1:sizeX1*2); 
CD12 = tempArr1(1:sizeX1, sizeX1*2+1:sizeX1*3); 


tempArr2 = [CH22, CV22, CD22]; 
sigma2 = median(median(abs(tempArr2)))/(0.6745); 
threshold2 = sigma2 * sqrt(2 * log(numel(tempArr2))); 
[sizeX2,sizeY2] = size(tempArr2);
for xLoop = 1:sizeX2
    for yLoop = 1:sizeY2
        if tempArr2(xLoop, yLoop) >= threshold2
            tempArr2(xLoop, yLoop) =  tempArr2(xLoop, yLoop) - threshold2;  
        elseif tempArr2(xLoop, yLoop) <= -threshold2
            tempArr2(xLoop, yLoop) =  tempArr2(xLoop, yLoop) + threshold2;  
        elseif tempArr2(xLoop, yLoop) < threshold2 
            tempArr2(xLoop, yLoop) =  0;  
        end
    end
end
CH22 = tempArr2(1:sizeX2, 1:sizeX2); 
CV22 = tempArr2(1:sizeX2, sizeX2+1:sizeX2*2); 
CD22 = tempArr2(1:sizeX2, sizeX2*2+1:sizeX2*3); 

tempArr3 = [CH32, CV32, CD32];
sigma3 = median(median(abs(tempArr3)))./(0.6745); 
threshold3 = sigma3 * sqrt(2 * log(numel(tempArr3))); 
[sizeX3,sizeY3] = size(tempArr3);
for xLoop = 1:sizeX3
    for yLoop = 1:sizeY3
        if tempArr3(xLoop, yLoop) >= threshold3
            tempArr3(xLoop, yLoop) =  tempArr3(xLoop, yLoop) - threshold3;  
        elseif tempArr3(xLoop, yLoop) <= -threshold3 
            tempArr3(xLoop, yLoop) =  tempArr3(xLoop, yLoop) + threshold3;  
        elseif tempArr3(xLoop, yLoop) < threshold3
            tempArr3(xLoop, yLoop) =  0;  
        end
    end
end
CH32 = tempArr3(1:sizeX3, 1:sizeX3); 
CV32 = tempArr3(1:sizeX3, sizeX3+1:sizeX3*2); 
CD32 = tempArr3(1:sizeX3, sizeX3*2+1:sizeX3*3); 

R2CA2 = idwt2( CA32, CH32, CV32, CD32, 'db2'); 
R2CA1 = idwt2( R2CA2, CH22, CV22,CD22,'db2'); 
ReconsImage2 = idwt2(R2CA1, CH12,CV12, CD12,'db2');
ReconsImage2 = uint8(ReconsImage2); 

% Plotting the outputs
figure(9);
subplot(1,2,1), imshow(ReconsImage2), title('Reconstructed Image'); 
subplot(1,2,2), imshow(noisyLena), title('Noisy Image'); 
disp('------Finished Solving Problem Six------');
pause;