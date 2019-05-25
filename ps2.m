%% Load Image
img = imread('ps1-input0.png');

%% Smooth image
%{
filter_size = 10;
filter_sigma = 5;
filter = fspecial('gaussian', filter_size, filter_sigma);
img = imfilter(img, filter);
%}
bw = im2bw(img);
edges = edge(bw, 'canny', 0.01);


%% Call Hough functions
[H, theta, rho] = hough_lines_acc(edges);
peaks = hough_peaks(H, 6, 'Threshold', 0.4*max(H(:)));
line_segs = hough_lines_draw(edges, bw, theta, rho, peaks);

%% Plot stuff
figure, imagesc(H, 'XData', theta, 'YData', rho), title('Hough acc');
hold on; plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'rs'); hold off;