

%% 1-a
clear all
close all
img = imread(fullfile('input', 'ps1-input0.png'));  % already grayscale
gf = fspecial('gaussian',50);
img = imfilter(img,gf);
figure
imshow(img)
%% TODO: Compute edge image img_edges
img_edges  = edge(img,'canny');
imwrite(img_edges, fullfile('output', 'ps1-1-a-1.png'));  % save as output/ps1-1-a-1.png
figure
imshow(img_edges);
%% 2-a
[H, theta, rho] = hough_lines_acc(img_edges);  % defined in hough_lines_acc.m

figure
imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
Hsave = uint8(H);
imwrite(Hsave, fullfile('output', 'ps1-2-a-1.png'));  % save as output/ps1-1-a-1.png
hold off


[Hd,thetad,rhod] = hough(img_edges); %Original Matlab Function
peaksd = houghpeaks(Hd,10);
% figure
% imshow(Hd,[],'XData',thetad,'YData',rhod,'InitialMagnification','fit');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;

%% 2-b
threshold = 128;
neighborhood = [25 25];
numPeaks = 10;
[peaks, filtH] = hough_peaks(H, 10,'Threshold',128,'nHoodSize',neighborhood);  % defined in hough_peaks.m

figure
imshow(filtH,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(theta(peaks(:,2)),rho(peaks(:,1)),'s','color','white');
hold off;

lines = houghlines(img_edges,theta,rho,peaks);
figure
imshow(img); 
hold on;
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

%% TODO: Rest of your code here
