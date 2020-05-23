% UP = rotate_up
% UP' = rotate_up3
% DOWN = y2 rotate_up y2
% DOWN' = y2 rotate_up3 y2
% FRONT = x rotate_up x'
% FRONT' = x rotate_up3 x'
% BACK = x' rotate_up x
% BACK' = x' rotate_up3 x
% LEFT = y rotate_up y'
% LEFT' = y rotate_up3 y'
% RIGHT = y' rotate_up y
% RIGHT' = y' rotate_up3 y


function new_faces = rotate_side(faces, move)
    switch move
        case 'up'
            new_faces = up(faces);
        case 'upp'
            new_faces = up(faces);
            new_faces = up(new_faces);
            new_faces = up(new_faces);
        case 'down'
            new_faces = down(faces);
        case 'downp'
            new_faces = down(faces);
            new_faces = down(new_faces);
            new_faces = down(new_faces);
        case 'front'
            new_faces = front(faces);
        case 'frontp'
            new_faces = front(faces);
            new_faces = front(new_faces);
            new_faces = front(new_faces);
        case 'back'
            new_faces = back(faces);
        case 'backp'
            new_faces = back(faces);
            new_faces = back(new_faces);
            new_faces = back(new_faces);
        case 'left'
            new_faces = left(faces);
        case 'leftp'
            new_faces = left(faces);
            new_faces = left(new_faces);
            new_faces = left(new_faces);
        case 'right'
            new_faces = right(faces);
        case 'rightp'
            new_faces = right(faces);
            new_faces = right(new_faces);
            new_faces = right(new_faces);   
    end
end


function new_faces = up(faces)
    new_faces = faces;
    for i = 1:3
        new_faces(i, 1:3) = faces(i+1, 1:3);
    end
    new_faces(4, 1:3) = faces(1, 1:3);
    new_faces(6, :) = faces(6, [7 4 1 8 5 2 9 6 3]);
end

function new_faces = down(faces)
    new_faces = rotate_cube(faces, 'y');
    new_faces = rotate_cube(new_faces, 'y');

    new_faces = up(new_faces);

    new_faces = rotate_cube(new_faces, 'y');
    new_faces = rotate_cube(new_faces, 'y');
end

function new_faces = front(faces)
    new_faces = rotate_cube(faces, 'x');

    new_faces = up(new_faces);

    new_faces = rotate_cube(new_faces, 'xp');
end

function new_faces = back(faces)
    new_faces = rotate_cube(faces, 'xp');

    new_faces = up(new_faces);

    new_faces = rotate_cube(new_faces, 'x');
end


function new_faces = left(faces)
    new_faces = rotate_cube(faces, 'y');

    new_faces = up(new_faces);

    new_faces = rotate_cube(new_faces, 'yp');
end

function new_faces = right(faces)
    new_faces = rotate_cube(faces, 'yp');

    new_faces = up(new_faces);

    new_faces = rotate_cube(new_faces, 'y');
end
