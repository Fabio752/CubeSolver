function [faces, rel] = detect_face(faces, face_to_detect, frame, preview_ax, cam)
    cla(preview_ax);
    set(preview_ax,'visible','off');
    
    rel = true;
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
end

