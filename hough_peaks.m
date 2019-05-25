function peaks = hough_peaks(H, numpeaks, op_threshold, threshold)
%% Input args
if nargin < 3
    op_threshold = '';
end

if ~strcmp(op_threshold, 'Threshold')
    threshold = 0.5*max(H(:));
end

[arr_row, arr_col] = size(H);
max_index = zeros(arr_row, arr_col);

%% Find maximum of each row
for i = 1:arr_row
    for j = 1:arr_col
        if max(H(i, :)) >= threshold
            if H(i, j) == max(H(i, :))
                max_index(i, j) = max(H(i, :));     % array of maximum in proper locations
            end
        end
    end
end

%% Conform to maximum number of peaks
[max_x, max_y] = find(max_index);
max_index = nonzeros(max_index);

while length(nonzeros(max_index)) > numpeaks
    minim = min(max_index); 
    for i = 1:size(max_index)
        if max_index(i) == minim
            rmv = i;  
            break;
        end
    end
    max_index(rmv) = [];        % Remove minimum from array
    max_x(rmv) = [];
    max_y(rmv) = [];
end

%% Output
for i = 1:length(max_x)
    peaks(i, 1) = max_x(i);
    peaks(i, 2) = max_y(i);
end
