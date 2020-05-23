
function [faces, setup_moves, setup_idx, cross_moves, cross_moves_idx] = ...
            solve_edge_on_side(faces, piece, cross_moves, cross_moves_idx)
    %initialise setup
    setup_idx = 1;
    setup_moves = cell(1, 20);
    
    edge_idx = find_edge(piece, faces);
    
    
    %if on position 2 or 8, bring it to 6
    if edge_idx(2) == 2 || edge_idx(2) == 8 
        need_antisetup = ~(edge_idx(1) == piece(2));
        switch edge_idx(1)
            case 1
                %account for both cases
                move_antimove = {'front', 'frontp'};
                if edge_idx(2) == 8
                    move_antimove = move_antimove(2:-1:1);
                end
                faces = rotate_side(faces, move_antimove{1});
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move_antimove{1});
                
                %if piece was not inverted on same place
                if need_antisetup
                    [setup_moves, setup_idx] = add_move(setup_moves, setup_idx, move_antimove{2});
                end
            case 2 
                %account for both cases
                move_antimove = {'right', 'rightp'};
                if edge_idx(2) == 8
                    move_antimove = move_antimove(2:-1:1);
                end
                
                faces = rotate_side(faces, move_antimove{1});
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move_antimove{1});
             
                %if piece was not inverted on same place
                if need_antisetup
                    [setup_moves, setup_idx] = add_move(setup_moves, setup_idx, move_antimove{2});
                end             
            case 3
                %account for both cases
                move_antimove = {'backp', 'back'};
                if edge_idx(2) == 8
                    move_antimove = move_antimove(2:-1:1);
                end
                
                faces = rotate_side(faces, move_antimove{1});
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move_antimove{1});
                
                %if piece was not inverted on same place
                if need_antisetup
                    [setup_moves, setup_idx] = add_move(setup_moves, setup_idx, move_antimove{2});
                end
            case 4
                %account for both cases
                move_antimove = {'left', 'leftp'};
                if edge_idx(2) == 8
                    move_antimove = move_antimove(2:-1:1);
                end
           
                faces = rotate_side(faces, move_antimove{1});
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, move_antimove{1});
                
                %if piece was not inverted on same place
                if need_antisetup
                    [setup_moves, setup_idx] = add_move(setup_moves, setup_idx, move_antimove{2});
                end
        end
    end
    
    %recompute position  
    edge_idx = find_edge(piece, faces);

    %if on position 4 on a lateral side 
    if edge_idx(2) == 4
        switch edge_idx(1)
            case 1
                %setup top face
                for i = piece(2):3
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
                
                %insert piece
                faces = rotate_side(faces, 'leftp');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'leftp');
                
                %untisetup top face
                for i = piece(2):3
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
            case 2 
                %setup top face
                for i = 2:piece(2)
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
                %insert piece
                faces = rotate_side(faces, 'frontp');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'frontp');
                
                %untisetup top face
                for i = 2:piece(2)
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
            case 3 
                %setup top face
                loops = piece(2)-2;
                if piece(2) == 1
                    loops = 3;
                end
                for i = 1:loops
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
                %insert piece
                faces = rotate_side(faces, 'rightp');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'rightp');
                
                %untisetup top face
                for i = 1:loops
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
                
            case 4 
                %setup top face
                start = piece(2);
                if piece(2) == 4
                    start = 0;
                end
                for i = start:2
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
                
                %insert piece
                faces = rotate_side(faces, 'backp');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'backp');
                
                %untisetup top face
                for i = start:2
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
        end
    %else (is on position 6)
    else
        switch edge_idx(1)
            case 1
                %setup top face
                loops = piece(2)-2;
                if piece(2) == 1
                    loops = 3;
                end
                %setup top face
                for i = 1:loops
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
                %insert piece
                faces = rotate_side(faces, 'right');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'right');
                
                %untisetup top face
                for i = 1:loops
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
                
            case 2 
                %setup top face
                start = piece(2);
                if piece(2) == 4
                    start = 0;
                end
                
                for i = start:2
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
                
                %insert piece
                faces = rotate_side(faces, 'back');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'back');
                
                %untisetup top face
                for i = start:2
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
            case 3 
                for i = 3:-1:piece(2)
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
                
                %insert piece
                faces = rotate_side(faces, 'left');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'left');
                
                %untisetup top face
                for i = 3:-1:piece(2)
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
            case 4 
                for i = 2:piece(2)
                    faces = rotate_side(faces, 'up');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'up');
                end
                
                %insert piece
                faces = rotate_side(faces, 'front');
                [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'front');
                
                %untisetup top face
                for i = 2:piece(2)
                    faces = rotate_side(faces, 'upp');
                    [cross_moves, cross_moves_idx] = add_move(cross_moves, cross_moves_idx, 'upp');
                end
        end
    end
    
        
end

