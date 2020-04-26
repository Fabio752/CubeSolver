function faces = execute_algorithm(faces, moves, to_draw)
    for i = 1:length(moves)
        if to_draw 
            [hl, hm, hr] = draw(faces);
        end
        move = char(moves{i});
        if move(1) == 'x' || move(1) == 'y' || move(1) == 'z'
            faces = rotate_cube(faces, move);
        else
            faces = rotate_side(faces, move);
        end
        if to_draw
            draw_move(hl, hm, hr, move, 30);
        end       
    end
end

