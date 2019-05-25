function [H, theta, rho] = hough_lines_acc(img_edges, op_theta, theta)
[im_h, im_w, ~] = size(img_edges);     % img sizes

%% Input args
if nargin < 4
    op_theta = '';
    if ~strcmp(op_theta, 'Theta')
        theta = -90:89;
    end
end

rho = -(fix(sqrt(im_h^2 + im_w^2)) + 1):(fix(sqrt(im_h^2 + im_w^2)) + 1);

d_bin = length(rho);
theta_bin = length(theta);
H = zeros(d_bin, theta_bin);

theta_disp = abs(min(theta)) + 1;
rho_disp = abs(min(rho)) + 1;

%% Build array
for x = 1:im_w
    for y = 1:im_h
        if img_edges(x, y) ~= 0
            for t = theta                
                d = round((x * cosd(t)) + (y * sind(t)));                 
                H(d + rho_disp, t + theta_disp) = H(d + rho_disp, t + theta_disp) + 1;
            end
        end
    end
end