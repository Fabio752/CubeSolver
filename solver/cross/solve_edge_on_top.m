function [faces, setup_moves, setup_idx, cross_moves, cross_moves_idx] = ...
                solve_edge_on_top(faces, k, edge_idx, cross_moves, cross_moves_idx)
    %initialise setup
    setup_idx = 1;
    setup_moves = cell(1, 20);
    
    %target position for 6
    target_position = [8 4 2 6];
    %bring piece down
    moves_to_edge_num = {'back' 'left' 'right' 'front'};
    move = moves_to_edge_num{edge_idx(2)/2};

    faces = rotate_side(faces, move);
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
    
    antisetup_move = [move 'p'];

    position = edge_idx(2);


    idx = k;
    %rotate top right amount
    while target_position(idx) ~= position
        faces = rotate_side(faces, 'up');
        [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
        
        setup_moves{setup_idx} = 'upp';
        setup_idx = setup_idx + 1;
        idx = idx + 1;
        if idx == 5
            idx = 1;
        end
        position = target_position(idx);  
    end

    %bring piece up
    faces = rotate_side(faces, antisetup_move);
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, antisetup_move);

end

