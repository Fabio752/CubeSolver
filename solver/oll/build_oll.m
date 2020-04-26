function oll_moves = build_oll(faces)
    % init variables
    [f1, f2, f3, f4, f6] = set_fs(faces);    
    oll_moves = cell(1, 1);
    
    %% case when yellow cross is not done
    if ~(f6(2) == 5 && f6(4) == 5 && f6(6) == 5 && f6(8) == 5)
        
        %dot case -> make a line
        if ~(f6(2) == 5 || f6(4) == 5 || f6(6) == 5 || f6(8) == 5)
            
            algorithm = {'front', 'up', 'right', 'upp', 'rightp', 'frontp'};
            faces = execute_algorithm(faces, algorithm, 0);
            [~, ~, ~, ~, f6] = set_fs(faces);
            oll_moves = [oll_moves algorithm];
        end 
        
        % line -> solved
        if (f6(2) == 5 && f6(8) == 5) || (f6(4) == 5 && f6(6) == 5)
            % set line horizontally
            if (f6(2) == 5 && f6(8) == 5)
                faces = rotate_side(faces, 'up');
                oll_moves = [oll_moves {'up'}];
            end
            
            algorithm = {'front', 'right', 'up', 'rightp', 'upp', 'frontp'};
            faces = execute_algorithm(faces, algorithm, 0);
            [f1, f2, f3, f4, f6] = set_fs(faces);
            oll_moves = [oll_moves algorithm];
      
        % L case -> solved
        else
            % set L on top left
            if (f6(2) == 5 && f6(6) == 5)
                faces = rotate_side(faces, 'upp');
                oll_moves = [oll_moves {'upp'}];
                
            elseif (f6(4) == 5 && f6(8) == 5)
                faces = rotate_side(faces, 'up');
                oll_moves = [oll_moves {'up'}];
                    
            elseif (f6(6) == 5 && f6(8) == 5)
                algorithm = {'up', 'up'};
                faces = execute_algorithm(faces, algorithm, 0);
                oll_moves = [oll_moves algorithm];
            end
            
            algorithm = {'front', 'up', 'right', 'upp', 'rightp', 'frontp'};
            faces = execute_algorithm(faces, algorithm, 0);
            [f1, f2, f3, f4, f6] = set_fs(faces);
            oll_moves = [oll_moves algorithm];
        end
    end
    
    %% complete yellow face
    
    % if solved already
    if (f6(1) == 5 && f6(2) == 5 && f6(3) == 5 && f6(4) == 5 && f6(6) == 5 && f6(7) == 5 && f6(8) == 5 && f6(9) == 5)
        return;
    end
    
    % cases with all edges correctly oriented:
    algorithm = cell(1, 20); 
    found = false;
    while ~found
        if f6(2) == 5 && f6(3) == 5 && f6(4) == 5 && f6(5) == 5 && f6(6) == 5 && ...
           f6(8) == 5 && f1(3) == 5 && f3(3) == 5 && f4(3)
            algorithm = {'left', 'up', 'leftp', 'up', 'left', 'up', 'up', 'leftp'}; 
            found = true;
        elseif f6(2) == 5 && f6(4) == 5 && f6(5) == 5 && f6(6) == 5 && f6(8) == 5 && ...
               f1(1) == 5 && f1(3) == 5 && f3(1) == 5 && f3(3)
            algorithm = {'right', 'up', 'up', 'rightp', 'upp', 'right', 'up', 'rightp', 'upp', 'right', 'upp', 'rightp'};
            found = true;
        elseif f6(1) == 5 && f6(2) == 5 && f6(3) == 5 && f6(4) == 5 && f6(5) == 5 && ...
               f6(6) == 5 && f6(8) == 5 && f1(1) == 5 && f1(3)
            algorithm = {'right', 'right', 'down', 'rightp', 'up', 'up', 'right', 'downp', 'rightp', 'up', 'up', 'rightp'}; 
            found = true;
        elseif f6(1) == 5 && f6(2) == 5 && f6(4) == 5 && f6(5) == 5 && f6(6) == 5 && ...
               f6(8) == 5 && f6(9) == 5 && f1(1) == 5 && f2(3)
            algorithm = {'rightp', 'front', 'right', 'backp', 'rightp', 'frontp', 'right', 'back'}; 
            found = true;
        elseif f6(1) == 5 && f6(2) == 5 && f6(4) == 5 && f6(5) == 5 && f6(6) == 5 && ...
               f6(8) == 5 && f1(1) == 5 && f2(1) == 5 && f3(1)
            algorithm = {'rightp', 'upp', 'right', 'upp', 'rightp', 'up', 'up', 'right'};
            found = true;
        elseif f6(2) == 5 && f6(4) == 5 && f6(5) == 5 && f6(6) == 5 && f6(8) == 5 && ...
               f1(3) == 5 && f3(1) == 5 && f4(1) == 5 && f4(3)
            algorithm = {'right', 'up', 'up', 'right', 'right', 'upp', 'right', 'right', 'upp', 'right', 'right', 'up', 'up', 'right'}; 
            found = true;
        elseif f6(1) == 5 && f6(2) == 5 && f6(4) == 5 && f6(5) == 5 && f6(6) == 5 && ...
               f6(7) == 5 && f6(8) == 5 && f1(3) == 5 && f3(1)
            algorithm = {'x', 'rightp', 'upp', 'left', 'up', 'right', 'upp', 'xp', 'leftp', 'front'}; 
            found = true; 
        end
        if ~found
            faces = rotate_side(faces, 'up');
            [f1, f2, f3, f4, f6] = set_fs(faces);
            oll_moves = [oll_moves {'up'}];
        end
    end
    
    oll_moves = [oll_moves algorithm];    
end



