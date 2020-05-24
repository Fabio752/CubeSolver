function faces = init()
    clear;  
    faces = zeros(6, 9);

    % orange = 1 green = 2 red = 3 blue = 4 yellow = 5 white = 6
    
    %IMAGE ACQUISITION:
    cam = webcam(1);
    % Create axes control.
    handleToAxes = axes();
    % Get the handle to the image in the axes.
    hImage = image(zeros(1280,720,'uint8'));
    % Reset image magnification. Required if you ever displayed an image
    % in the axes that was not the same size as your webcam image.
    hold off;
    axis auto;
    axis on;
    % Enlarge figure to full screen.
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    % Turn on the live video.
    
    preview(cam, hImage);
    hold on
    frame = [350, 100, 550, 550];
    rectangle('Position', frame, 'EdgeColor','r','LineWidth', 5);
    face_to_detect = 1;
    
    while face_to_detect < 7
        reliable = true;
        measurements = 5;
        while measurements > 0
            snap = snapshot(cam);
            sz = size(snap);
            x  = floor(sz(1:2)/2);
            centerpiece = reshape(snap(x(1), x(2), :), 1, []);
            if detect_color(centerpiece) ~= face_to_detect
                 reliable = false;
            end
            measurements = measurements - 1;
            pause(0.2);
        end
        
        % check if correct face:
        if reliable
           % detect face
           face_img = imcrop(snap, frame);
           f2 = figure;
           imshow(face_img);
           hold on
           sz_img = size(face_img);
           u = floor(sz_img(1)/6);
           pieces_centers = [u u; 3*u u; 5*u u;
                             u 3*u; 3*u 3*u; 5*u 3*u;
                             u 5*u; 3*u 5*u; 5*u 5*u];
           fill_order = [1 4 7 2 5 8 3 6 9];
           for piece_num = 1:9
                row = pieces_centers(piece_num, :);
                plot(row(1), row(2), 'b*', 'MarkerSize', 5);
                col_face = detect_color(reshape(face_img(row(1), row(2), :), 1, []));
                faces(face_to_detect, fill_order(piece_num)) = col_face; 
           end
           pause(2);
           face_to_detect = face_to_detect + 1;
           
           delete(f2)
           preview(cam, hImage);
           rectangle('Position', frame, 'EdgeColor','r','LineWidth', 5)
           hold on 
        end
         pause;
    end
    
% THIS IS FOR NON IMAGE ACQUISITION SOLVES     
%     f1 = ones(1,9);
%     f2 = 2 * ones(1,9);
%     f3 = 3 * ones(1,9);
%     f4 = 4 * ones(1,9);
%     f5 = 5 * ones(1,9);
%     f6 = 6 * ones(1,9);
%     
%     faces = [f1; f2; f3; f4; f5; f6];

    all_moves = {'up' 'upp' 'down' 'downp' 'front' 'frontp' 'back' 'backp' 'left' 'leftp' 'right' 'rightp'};
    % testing generator
    scramble = cell(1,30);
    % for repeating test
    % scramble = {'right','down','downp','up','upp','backp','downp','leftp','backp','down','downp','upp','back','upp','right','up','right','down','leftp','up','left','down','rightp','back','back','downp','front','back','back','frontp'};


    for i = 1:length(scramble)
        scramble{i} = all_moves{randi(12)};
        faces = rotate_side(faces, char(scramble(i)));
    end
end