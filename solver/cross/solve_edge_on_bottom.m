
function [faces, setup_moves, setup_idx, cross_moves, cross_moves_idx] = ... 
            solve_edge_on_bottom(faces, k, edge_idx, cross_moves, cross_moves_idx)
    
    %initialise setup
    setup_idx = 1;
    setup_moves = cell(1, 20);
    %adjust target position to 5
    target_position = [2 4 8 6];
    position = edge_idx(2);

    %rotate bottom right amount
    idx = find(target_position == position);

    while target_position(k) ~= position
        faces = rotate_side(faces, 'downp');
        [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'downp');

        setup_moves{setup_idx} = 'down';
        setup_idx = setup_idx + 1;

        idx = idx + 1;
        if idx == 5
            idx = 1;
        end
        position = target_position(idx);  
    end

    % bring piece up
    moves_to_edge_num = {'front' 'left' 'right' 'back'};
    move = moves_to_edge_num{position/2};

    faces = rotate_side(faces, move);
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
    
    faces = rotate_side(faces, move);
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
end

