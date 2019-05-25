function line_segs = hough_lines_draw(edges, bw, theta, rho, peaks)
[im_h, im_w, ~] = size(edges);     % img sizes
line_segs = struct('point1', {}, 'point2', {}, 'theta', {}, 'rho', {});

%% Get rho and theta values
for i = 1:length(peaks)
    line_segs(i).rho = rho(peaks(i, 1));
    line_segs(i).theta = theta(peaks(i, 2));
end

%% Get lines
for i = 1:length(line_segs)
    if line_segs(i).theta ~= 0
        line_segs(i).point1 = [1, (-cosd(line_segs(i).theta) / sind(line_segs(i).theta)) + (line_segs(i).rho / sind(line_segs(i).theta)) + 1];
        line_segs(i).point2 = [im_w, (-cosd(line_segs(i).theta) / sind(line_segs(i).theta)) + (line_segs(i).rho / sind(line_segs(i).theta)) + 1];
    else
        line_segs(i).point1 = [line_segs(i).rho + 1, 1];
        line_segs(i).point2 = [line_segs(i).rho + 1, im_h];
    end   
end

%% Draw Lines
figure, imshow(bw), title('line seg');
hold on;
for k = 1:length(line_segs)
    endpoints = [line_segs(k).point1; line_segs(k).point2];
    plot(endpoints(:, 1), endpoints(:, 2), 'LineWidth', 2, 'Color', 'green');
end
hold off;