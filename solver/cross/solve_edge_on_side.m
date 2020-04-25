
function [faces, setup_moves, setup_idx, cross_moves, cross_moves_idx] = ...
            solve_edge_on_side(faces, k, edge_idx, cross_moves, cross_moves_idx)
    %initialise setup
    setup_idx = 1;
    setup_moves = cell(1, 20);
    
    %initialise setup top face
    for i = 2:k
        faces = rotate_side(faces, 'upp');
        [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');

        setup_moves{setup_idx} = 'up';
        setup_idx = setup_idx + 1;
    end


    %bring face to front position
    for i = 2:edge_idx(1)
        faces = rotate_cube(faces, 'z');
        [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'z');
        
        setup_moves{setup_idx} = 'zp';
        setup_idx = setup_idx + 1;
    end

    % bring edge to position 6 (right)
    i = 1;
    if edge_idx(2) == 6
        i = 6;
    end

    while i < edge_idx(2)
        faces = rotate_side(faces, 'front');
        [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'front');

        i = i * 2;
        setup_moves{setup_idx} = 'frontp';
        setup_idx = setup_idx + 1;
    end

    %rotate top face 
    for i = 3:-1:edge_idx(1)
        faces = rotate_side(faces, 'up');
        [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
        setup_moves{setup_idx} = 'upp';
        setup_idx = setup_idx + 1;
    end

    %move edge on top
    faces = rotate_side(faces, 'right');
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'right');
end

