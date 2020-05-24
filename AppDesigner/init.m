function [faces, rel] = init(cam, cube_ax, preview_ax, USE_WEBCAM, ...
                             face_to_detect, faces, frame)
    if nargin < 3
        cube_ax = uiaxes();
        USE_WEBCAM = 0;
    end
    
    rel = true;
    if USE_WEBCAM
        % orange = 1 green = 2 red = 3 blue = 4 yellow = 5 white = 6
        
        measurements = 5;
        while measurements > 0
            snap = snapshot(cam);
            sz = size(snap);
            x  = floor(sz(1:2)/2);
            centerpiece = reshape(snap(x(1), x(2), :), 1, []);
            if detect_color(centerpiece) ~= face_to_detect
                 rel = false;
            end
            measurements = measurements - 1;
            pause(0.2);
        end

        % check if correct face:
        if rel
           % detect face
           face_img = imcrop(snap, frame);
           imshow(face_img, 'Parent', preview_ax);
           sz_img = size(face_img);
           u = floor(sz_img(1)/6);
           pieces_centers = [u u; 3*u u; 5*u u;
                             u 3*u; 3*u 3*u; 5*u 3*u;
                             u 5*u; 3*u 5*u; 5*u 5*u];
           fill_order = [1 4 7 2 5 8 3 6 9];
           for piece_num = 1:9
                row = pieces_centers(piece_num, :);
                col_face = detect_color(reshape(face_img(row(1), row(2), :), 1, []));
                faces(face_to_detect, fill_order(piece_num)) = col_face; 
           end
        end        
    else
        % THIS IS FOR NON IMAGE ACQUISITION SOLVES     
        faces = ones(6, 9) .* [1; 2; 3; 4; 5; 6];

        all_moves = {'up' 'upp' 'down' 'downp' 'front' 'frontp' 'back' 'backp' 'left' 'leftp' 'right' 'rightp'};
        % testing generator
        scramble = cell(1,30);

        for i = 1:length(scramble)
            scramble{i} = all_moves{randi(12)};
            faces = rotate_side(faces, char(scramble(i)));
        end
    end
    
    draw(faces, cube_ax);
end