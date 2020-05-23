function [cross_moves, cross_moves_idx] = build_cross(faces)
    
    cross_moves = cell(1, 100);
    cross_moves_idx = 1;
    cross_edges = [6 1; 6 4; 6 3; 6 2];

    for k = 1:4

        %find cross edge
        piece = cross_edges(k, :);
        edge_idx = find_edge(piece, faces);
        
        
        %if piece is on top -> bring to bottom
        if edge_idx(1) == 6
            [faces, cross_moves, cross_moves_idx] = ...
                solve_edge_on_top(faces, edge_idx, cross_moves, cross_moves_idx);
                    
            %find edge back
            edge_idx = find_edge(piece, faces);
        end 


        % if is on side
        if edge_idx(1) < 5
           [faces, setup_moves, setup_idx, cross_moves, cross_moves_idx] = ...
                solve_edge_on_side(faces, piece, cross_moves, cross_moves_idx);

        %if is on bottom
        elseif edge_idx(1) == 5
            
            [faces, setup_moves, setup_idx, cross_moves, cross_moves_idx] = ... 
                solve_edge_on_bottom(faces, k, edge_idx, cross_moves, cross_moves_idx);
        end
        
        %undo setup moves
        for i = (setup_idx-1):-1:1
            move = setup_moves{i}; 
            if move(1) == 'x' || move(1) == 'y' || move(1) == 'z' 
                faces = rotate_cube(faces, move);
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
            else 
                faces = rotate_side(faces, move);
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move);
            end
        end
    end
    
    %Put white cross below
    faces = rotate_cube(faces, 'y');
    faces = rotate_cube(faces, 'y');
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'y');
    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'y');
end


