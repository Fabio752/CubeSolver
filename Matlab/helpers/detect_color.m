function col_code = detect_color(pixelsRGB)
    % color thresholds
    col_thresholds = [220, 130, 105;
                      60,  215, 60;
                      185, 75, 75;
                      60, 60, 215;
                      215, 215, 60;
                      195, 195, 195];
                  
     col_code = 0; 
     min_distance = Inf;
     for i = 1:6
        curr_thresh = col_thresholds(i, :);
        curr_distance = sum(abs(double(pixelsRGB) - curr_thresh).^2);
        if min_distance > curr_distance
            min_distance = curr_distance;
            col_code = i;
        end
     end
                  
end

