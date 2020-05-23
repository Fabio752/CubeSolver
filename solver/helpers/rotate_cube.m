function new_faces = rotate_cube(faces, dir)
    switch dir
        case 'x'
            new_faces = rotate_x(faces);
        case 'xp'
            new_faces = rotate_x(faces);
            new_faces = rotate_x(new_faces);
            new_faces = rotate_x(new_faces);
        case 'y'
            new_faces = rotate_y(faces);
        case 'yp'
            new_faces = rotate_y(faces);
            new_faces = rotate_y(new_faces);
            new_faces = rotate_y(new_faces);
        case 'z'
            new_faces = rotate_z(faces);     
        case 'zp'
            new_faces = rotate_z(faces);
            new_faces = rotate_z(new_faces);
            new_faces = rotate_z(new_faces);
    end

end

function new_faces = rotate_x(faces)
    new_faces = faces([5 2 6 4 3 1], :);
    new_faces(2, :) = new_faces(2, [7 4 1 8 5 2 9 6 3]);
    new_faces(4, :) = new_faces(4, [3 6 9 2 5 8 1 4 7]);
    new_faces([3 5], :) = new_faces([3 5], 9:-1:1);
end

function new_faces = rotate_y(faces)
    new_faces = faces([1 6 3 5 2 4], [7 4 1 8 5 2 9 6 3]);
    new_faces(3, :) = faces(3, [3 6 9 2 5 8 1 4 7]);
end

function new_faces = rotate_z(faces)
    new_faces = faces([2 3 4 1 5 6], :);
    new_faces(6, :) = new_faces(6, [7 4 1 8 5 2 9 6 3]);
    new_faces(5, :) = new_faces(5, [3 6 9 2 5 8 1 4 7]);
end