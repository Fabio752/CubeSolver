function [f2l_moves, f2l_moves_idx] = build_f2l(faces)
    % init variable
    f2l_moves = cell(1, 200);
    f2l_moves_idx = 1;
    white_angles = [6 1 2; 6 4 1; 6 3 4; 6 2 3]; 

    for i = 1:4
        % find_angle
        idx = find_angle(white_angles(i, :), faces);
        
        % initialise setup
        setup_idx = 1;
        setup_moves = cell(1, 20);

        % Goal: place edge in position: 4 - 3 or 1-1
        
        %% adjust if on side bottom layer
        if idx(1) < 5 && idx(2) > 6    
            while (idx(1) ~= 3 || idx(2) ~= 9) && (idx(1) ~= 4 || idx(2) ~= 7)
                faces = rotate_side(faces, 'down');
                [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'down');

                setup_moves{setup_idx} = 'downp';
                setup_idx = setup_idx + 1;
                idx = find_angle(white_angles(i, :), faces);
            end

            if idx(1) == 3
                algorithm = {'backp' 'upp' 'back'};
                faces = execute_algorithm(faces, algorithm, 0);
                [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);
            else  
                algorithm = {'left' 'up' 'leftp' 'up' 'up'};
                faces = execute_algorithm(faces, algorithm, 0);
                [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);
            end
            % undo setup moves
            for j = (setup_idx-1):-1:1
                move = setup_moves{j}; 
                faces = rotate_side(faces, move);
                [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, move);
            end
            setup_idx = 1;

        %% adjust if on top layer    
        elseif idx(1) < 5 && idx(2) < 6
            if idx(2) == 1 && idx(1) ~= 1
                %set on position 4 - 1
                for j = idx(1):4
                    faces = rotate_side(faces, 'upp');
                    [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'upp');
                end
                
            elseif idx(2) == 3 && idx(1) ~= 4
                %set on position 4 - 3
                for j = idx(1):3
                    faces = rotate_side(faces, 'upp');
                    [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'upp');
                end
            end

        %% adjust if on bottom face
        elseif idx(1) == 5
            switch idx(2)
                case 1
                    algorithm = {'front','up','frontp','upp'};                   
                case 3
                    algorithm = {'right','up','rightp'};
                case 7
                    algorithm = {'left','up','leftp','up','up'};
                case 9
                    algorithm = {'back','upp','upp','backp'};
            end
            faces = execute_algorithm(faces, algorithm, 0);
            [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);
            
        else
            
            while idx(2) ~= 1
                faces = rotate_side(faces, 'up');
                [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'up');
                idx = find_angle(white_angles(i, :), faces);
            end
            
            algorithm = {'backp','up','up','back'};
            faces = execute_algorithm(faces, algorithm, 0);       
            [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);
        end

        %% insert piece
        for j = 2:i
            faces = rotate_side(faces, 'upp');
            [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'upp');  
        end
        for j = 2:i
            faces = rotate_cube(faces, 'z');
            [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'z');           
            setup_moves{setup_idx} = 'zp';
            setup_idx = setup_idx + 1;
        end

        idx = find_angle(white_angles(i, :), faces);
        
        %% insert with L' U' L if on position 1, F' L F L' if on position 3
        if idx(2) == 1
            algorithm = {'front','up','frontp'};
        else
            algorithm = {'leftp','upp','left'};
        end
        faces = execute_algorithm(faces, algorithm, 0);
        [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);

        %% find edge and bring it to place
        
        corr_edge = white_angles(i, 2:3);
        edge_idx = find_edge(corr_edge, faces);

        % if it is correct do nothing
        if ~(edge_idx(1) == 1 && edge_idx(2) == 4)
            
            % if its in place but inverted
            if edge_idx(1) == 4 && edge_idx(2) == 6
                algorithm = {'leftp','upp','left','up','front','up','frontp','upp','upp'};
                faces = execute_algorithm(faces, algorithm, 0);
                [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);

            % edge is inserted in a wrong position
            elseif (edge_idx(1) ~= 6 && edge_idx(2) ~= 2) 
                move_to_do = {'err', 'right'; 'right', 'back'; 'back' 'backp'; 'backp', 'err'};
                move = char(move_to_do(edge_idx(1), round(edge_idx(2)/3)));
                algorithm = {move, 'up'};
                faces = execute_algorithm(faces, algorithm, 0);
                [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);
                
                % revert move
                if move(end) == 'p'
                    anti_move = move(1:end-1);
                else
                    anti_move = [move 'p'];
                end
                faces = rotate_side(faces, anti_move);
                [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, anti_move);
            end

            % place on top of the right color
            edge_idx = find_edge(corr_edge, faces);
            if edge_idx(1) == 6
                corr_edge = corr_edge(2:-1:1);
                edge_idx = find_edge(corr_edge, faces);
            end

            color_white_edge = find_edge([corr_edge(1) 6], faces);
            color_face = color_white_edge(1);
            while edge_idx(1) ~= color_face
                faces = rotate_side(faces, 'up');
                [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, 'up');

                edge_idx = find_edge(corr_edge, faces);
            end

            %% algorithm to insert
            % find out on which face is it, 1 or 4
            edge_idx = find_edge(corr_edge, faces);
            if edge_idx(1) == 6
                edge_idx = find_edge(corr_edge(2:-1:1), faces);
            end
            
            switch edge_idx(1)
                case 4
                    algorithm = {'up','front','up','frontp','upp','leftp','upp','left'};
                    faces = execute_algorithm(faces, algorithm, 0);
                    [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);

                case 1
                    algorithm = {'upp','leftp','upp','left','up','front','up','frontp'};
                    faces = execute_algorithm(faces, algorithm, 0);
                    [f2l_moves, f2l_moves_idx] = add_algorithm(f2l_moves, f2l_moves_idx, algorithm);
            end
            
        end
        
        %undo setup z rotations 
        for j = (setup_idx-1):-1:1
            move = setup_moves{j}; 
            faces = rotate_cube(faces, move);
            [f2l_moves, f2l_moves_idx] = add_move(f2l_moves, f2l_moves_idx, move);
        end
    end
end


