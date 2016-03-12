pkg load image
image1 = imread ("ps0-1-a-1.tiff");
image2 = imread ("ps0-1-a-2.tiff");
%imshow(image1);
%figure
%imshow(image2);
image1_swapped = zeros(size(image1));
image1_swapped = uint8(image1_swapped);
image1_swapped(:,:,1) = image1(:,:,3);
image1_swapped(:,:,2) = image1(:,:,2);
image1_swapped(:,:,3) = image1(:,:,1);
img1_green = image1(:,:,2);
img1_red = image1(:,:,1);
imwrite(image1_swapped,"ps0-2-a-1.png");
imwrite(image1(:,:,2),"ps0-2-b-1.png");
imwrite(image1(:,:,1),"ps0-2-c-1.png");
%figure
%imshow(image1_swapped);
%figure
%imshow(image1(:,:,2));
%figure
%imshow(image1(:,:,1));
mean_img1 = mean2(img1_green);
std_img1 = std2(img1_green);
modImage1 = img1_green - mean_img1;
modImage1 = 10*modImage1/std_img1;
imwrite(modImage1,"ps0-4-b-1.png");
shiftFilter = [0 0 0 0 0;0 0 0 0 1;0 0 0 0 0];
shift_img1_green = imfilter(img1_green,shiftFilter);
imwrite(shift_img1_green,"ps0-4-c-1.png");
sub_img1_green = img1_green - shift_img1_green;
imwrite(sub_img1_green,"ps0-4-d-1.png");
noisy_img1_green = imnoise(img1_green,'gaussian',0.2);
image1_green_noise = zeros(size(image1));
image1_green_noise = uint8(image1_green_noise);
image1_green_noise(:,:,1) = image1(:,:,1);
image1_green_noise(:,:,2) = noisy_img1_green;
image1_green_noise(:,:,3) = image1(:,:,3);
figure
imshow(image1_green_noise)

noisy_img1_blue = imnoise(image1(:,:,3),'gaussian',0.2);
image1_blue_noise = zeros(size(image1));
image1_blue_noise = uint8(image1_blue_noise);
image1_blue_noise(:,:,1) = image1(:,:,1);
image1_blue_noise(:,:,2) = image1(:,:,2);
image1_blue_noise(:,:,3) = noisy_img1_blue;
figure
imshow(image1_blue_noise)

noisy_img1_red = imnoise(image1(:,:,1),'gaussian',0.2);
image1_red_noise = zeros(size(image1));
image1_red_noise = uint8(image1_red_noise);
image1_red_noise(:,:,3) = image1(:,:,3);
image1_red_noise(:,:,2) = image1(:,:,2);
image1_red_noise(:,:,1) = noisy_img1_red;
figure
imshow(image1_red_noise)

figure
imshow(image1)
