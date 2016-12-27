% Name              : Kamna Yadav
% A Number          : A02048769
% File name         : MainScript.m
% File description  : Main code file with all the required functionality

close all;
clear;

%
% Question 1 Part 1 : Identifying centroid of the ball in image
%
rgbIm = imread('ball.bmp');
hsvImage = rgb2hsv(rgbIm);
figure(1);
subplot(2,3,1), imshow(hsvImage),title('HSV Image');
H = hsvImage(:,:,1);
subplot(2,3,2), imshow(H),title('Hue Image');
V = hsvImage(:,:,3);
bwFromH = H < 0.7 & H > .4; % values taken to threshold the Hue image
subplot(2,3,3), imshow(bwFromH),title('Threshold Image');
outDilate = imdilate(bwFromH, strel('square',21));
outDilate = ~(imclearborder(~outDilate));
subplot(2,3,4), imshow(outDilate),title('Component Image');
CCOrig = bwconncomp(~outDilate);
numPixels = cellfun(@numel,CCOrig.PixelIdxList);
[~,idx] = max(numPixels);
outDilate(CCOrig.PixelIdxList{idx}) = 1;
subplot(2,3,5), imshow(outDilate),title('Final Cleaned Image');
SOrig = regionprops(~outDilate,'Centroid');
subplot(2,3,6), imshow(outDilate),title('Centroid on clean image');
hold on
plot(SOrig.Centroid(1),SOrig.Centroid(2),'x','MarkerSize',10);
figure(2);
imshow(rgbIm);
hold on
plot(SOrig.Centroid(1),SOrig.Centroid(2),'x','MarkerSize',10);
disp('------Finished Solving Problem One Part One------');
pause;

%
% Question 1 Part 2 : Changing color of the shadow of the ball
%
figure(3);
bwFromV = V < 0.4 & V > .1;
subplot(2,3,1),imshow(hsvImage),title('HSV Image');
subplot(2,3,2),imshow(V),title('Value Image');
subplot(2,3,3),imshow(bwFromV),title('Threshold image from Value');
outV = imerode(~bwFromV, strel('square',3));
subplot(2,3,4),imshow(outV),title('Cleaned BW image V1');
outV = imdilate(outV, strel('square',5));
outV = ~(imclearborder(~outV));
subplot(2,3,5),imshow(outV),title('Cleaned V2');
CCV = regionprops(~outV);
tempCC = bwconncomp(~outV);
minCentroid = 0;
for i=1:length(CCV)
    if(SOrig.Centroid(1) - CCV(i).Centroid(1) > 0.5 * SOrig.Centroid(1))
        if(SOrig.Centroid(2) - CCV(i).Centroid(2) > 0.5 * SOrig.Centroid(2))
            outV(tempCC.PixelIdxList{i}) = 1;
        end
    end
end
subplot(2,3,6),imshow(outV),title('Final Cleaned Image');
index = find(outV == 0);
rgbIm(index) = 190;
figure(4);
imshow(rgbIm),title('Shadow colored Image');
disp('------Finished Solving Problem One Part Two------');
pause;

%
% Question 2 : Color Image matching using HSV histograms
%

Ele1 = imread('Elephant1.jpg');
Ele2 = imread('Elephant2.jpg');
Hrs1 = imread('Horse1.jpg');
Hrs2 = imread('Horse2.jpg');

El1Hist = CalNormalizedHSVHist(Ele1, 4, 4, 4);
El2Hist = CalNormalizedHSVHist(Ele2, 4, 4, 4);
Hr1Hist = CalNormalizedHSVHist(Hrs1, 4, 4, 4);
Hr2Hist = CalNormalizedHSVHist(Hrs2, 4, 4, 4);

figure(5);
subplot(2,2,1), plot(El1Hist), title('Histogram of El1.jpg');
subplot(2,2,2), plot(El2Hist), title('Histogram of El2.jpg');
subplot(2,2,3), plot(Hr1Hist), title('Histogram of Hr1.jpg');
subplot(2,2,4), plot(Hr2Hist), title('Histogram of Hr2.jpg');

[rowE1,colE1] = size(Ele1);
[rowE2,colE2] = size(Ele2);
[rowH1,colH1] = size(Hrs1);
[rowH2,colH2] = size(Hrs2);

El1El = CalSimilarityScore(El1Hist,El1Hist,rowE1,colE1,rowE1,colE1);
El1E2 = CalSimilarityScore(El1Hist,El2Hist,rowE1,colE1,rowE2,colE2);
El1H1 = CalSimilarityScore(El1Hist,Hr1Hist,rowE1,colE1,rowH1,colH1);
El1H2 = CalSimilarityScore(El1Hist,Hr2Hist,rowE1,colE1,rowH2,colH2);
El1 = [El1El El1E2 El1H1 El1H2];

El2El = CalSimilarityScore(El2Hist,El1Hist,rowE2,colE2,rowE1,colE1);
El2E2 = CalSimilarityScore(El2Hist,El2Hist,rowE2,colE2,rowE2,colE2);
El2H1 = CalSimilarityScore(El2Hist,Hr1Hist,rowE2,colE2,rowH1,colH1);
El2H2 = CalSimilarityScore(El2Hist,Hr2Hist,rowE2,colE2,rowH2,colH2);
El2 = [El2El El2E2 El2H1 El2H2];

Hr1E1 = CalSimilarityScore(Hr1Hist,El1Hist,rowH1,colH1,rowE1,colE1);
Hr1E2 = CalSimilarityScore(Hr1Hist,El2Hist,rowH1,colH1,rowE2,colE2);
Hr1H1 = CalSimilarityScore(Hr1Hist,Hr1Hist,rowH1,colH1,rowH1,colH1);
Hr1H2 = CalSimilarityScore(Hr1Hist,Hr2Hist,rowH1,colH1,rowH2,colH2);
Hr1 = [Hr1E1 Hr1E2 Hr1H1 Hr1H2];

Hr2E1 = CalSimilarityScore(Hr2Hist,El1Hist,rowH2,colH2,rowE1,colE1);
Hr2E2 = CalSimilarityScore(Hr2Hist,El2Hist,rowH2,colH2,rowE2,colE2);
Hr2H1 = CalSimilarityScore(Hr2Hist,Hr1Hist,rowH2,colH2,rowH1,colH1);
Hr2H2 = CalSimilarityScore(Hr2Hist,Hr2Hist,rowH2,colH2,rowH2,colH2);
Hr2 = [Hr2E1 Hr2E2 Hr2H1 Hr2H2];

ElSort = sort(El1, 'descend');
El2Sort = sort(El2, 'descend');
Hr1Sort = sort(Hr1, 'descend');
Hr2Sort = sort(Hr2, 'descend');

allimages = {Ele1, Ele2, Hrs1, Hrs2};

for i = 1:4
    a = find(ElSort == El1(i));
    imagesE1{a} = allimages{i};
    b = find(El2Sort == El2(i));
    imagesE2{b} = allimages{i};
    c = find(Hr1Sort == Hr1(i));
    imagesH1{c} = allimages{i};
    d = find(Hr2Sort == Hr2(i));
    imagesH2{d} = allimages{i};
end

figure(6);
subplot(3,2,[1,2]), imshow(Ele1), title('Input Image');
subplot(3,2,3), imshow(imagesE1{1}), title(['Rank 1, similarity score: ', num2str(ElSort(1))]);
subplot(3,2,4), imshow(imagesE1{2}), title(['Rank 2, similarity score: ', num2str(ElSort(2))]);
subplot(3,2,5), imshow(imagesE1{3}), title(['Rank 3, similarity score: ', num2str(ElSort(3))]);
subplot(3,2,6), imshow(imagesE1{4}), title(['Rank 4, similarity score: ', num2str(ElSort(4))]);

figure(7);
subplot(3,2,[1,2]), imshow(Ele2), title('Input Image');
subplot(3,2,3), imshow(imagesE2{1}), title(['Rank 1, similarity score: ', num2str(El2Sort(1))]);
subplot(3,2,4), imshow(imagesE2{2}), title(['Rank 2, similarity score: ', num2str(El2Sort(2))]);
subplot(3,2,5), imshow(imagesE2{3}), title(['Rank 3, similarity score: ', num2str(El2Sort(3))]);
subplot(3,2,6), imshow(imagesE2{4}), title(['Rank 4, similarity score: ', num2str(El2Sort(4))]);

figure(8);
subplot(3,2,[1,2]), imshow(Hrs1), title('Input Image');
subplot(3,2,3), imshow(imagesH1{1}), title(['Rank 1, similarity score: ', num2str(Hr1Sort(1))]);
subplot(3,2,4), imshow(imagesH1{2}), title(['Rank 2, similarity score: ', num2str(Hr1Sort(2))]);
subplot(3,2,5), imshow(imagesH1{3}), title(['Rank 3, similarity score: ', num2str(Hr1Sort(3))]);
subplot(3,2,6), imshow(imagesH1{4}), title(['Rank 4, similarity score: ', num2str(Hr1Sort(4))]);

figure(9);
subplot(3,2,[1,2]), imshow(Hrs2), title('Input Image');
subplot(3,2,3), imshow(imagesH2{1}), title(['Rank 1, similarity score: ', num2str(Hr2Sort(1))]);
subplot(3,2,4), imshow(imagesH2{2}), title(['Rank 2, similarity score: ', num2str(Hr2Sort(2))]);
subplot(3,2,5), imshow(imagesH2{3}), title(['Rank 3, similarity score: ', num2str(Hr2Sort(3))]);
subplot(3,2,6), imshow(imagesH2{4}), title(['Rank 4, similarity score: ', num2str(Hr2Sort(4))]);
disp('------Finished Solving Problem Two------');
pause;

%
% Question 3 Part 1 : Watermarking method
%
Lena = imread('Lena.jpg');
[outBeta30, b1] = EmbedWatermark(Lena, 30);
[outBeta90, b2] = EmbedWatermark(Lena, 90);

if(b1 ~= b2)
    disp('Mismatching b vectors');
else
    disp('B vectors are same');
end
figure(10);
subplot(2,3,1), imshow(Lena), title('Original Image');
subplot(2,3,2), imshow(outBeta30), title('Reconstructed Image 30');
subplot(2,3,3), imshow(Lena - outBeta30,[]), title('Difference Image');
subplot(2,3,4), imshow(Lena), title('Original Image');
subplot(2,3,5), imshow(outBeta90), title('Reconstructed Image 90');
subplot(2,3,6), imshow(Lena - outBeta90,[]), title('Difference Image');
disp('------Finished Solving Problem Three Part One------');
pause;

%
% Question 3 Part 2 : Watermark extraction and comparison
%
b30 = ExtractWatermark(outBeta30, 30);
b90 = ExtractWatermark(outBeta90, 90);

[row, col]=size(b1);
b1 = reshape(b1, [1 row*col]);
A = (b30 == b1);
Perc = sum(A(:)) / (row*col) * 100;
disp('Percentage Similarity for Beta 30 for watermarking and extraction = ');
disp(Perc);

A = (b90 == b1);
Perc = sum(A(:)) / (row*col) * 100;
disp('Percentage Similarity for Beta 90 for watermarking and extraction = ');
disp(Perc);
disp('------Finished Solving Problem Three Part Two------');
pause;