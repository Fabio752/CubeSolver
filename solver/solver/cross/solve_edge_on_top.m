function [faces, cross_moves, cross_moves_idx] = ...
                solve_edge_on_top(faces, edge_idx, cross_moves, cross_moves_idx)
   
    %bring piece down
    moves_to_edge_num = {'back' 'left' 'right' 'front'};
    move = moves_to_edge_num{edge_idx(2)/2};

    faces = rotate_side(faces, move);
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
    
    faces = rotate_side(faces, move);
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
end

