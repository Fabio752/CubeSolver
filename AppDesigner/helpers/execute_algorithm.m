function faces = execute_algorithm(faces, moves, to_draw, fig)

    for i = 1:length(moves)
        if to_draw && nargin == 4
            [hl, hm, hr] = draw(faces, fig);
        end
        move = char(moves{i});
        if move(1) == 'x' || move(1) == 'y' || move(1) == 'z'
            faces = rotate_cube(faces, move);
        else
            faces = rotate_side(faces, move);
        end
        if to_draw && nargin == 4
            draw_move(hl, hm, hr, move, 15);
        end       
    end
end

