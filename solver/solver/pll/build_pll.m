function pll_moves = build_pll(faces)
    % init variables
    [f1, f2, f3, f4, ~] = set_fs(faces);
    pll_moves = cell(1, 1);
    
    %% angles permutation
    
    % if angles not solved yet
    if ~(f1(1) == f1(3) && f2(1) == f2(3) && f3(1) ==  f3(3) && f4(1) == f4(3))
        % no headlights -> make them
        if ~((f1(1) == f1(3)) || (f2(1) == f2(3)) || ...    
             (f3(1) == f3(3)) || (f4(1) == f4(3)))
            algorithm = {'front', 'right', 'upp', 'rightp', 'upp', 'right', 'up', 'rightp', ...
                         'frontp', 'right', 'up', 'rightp', 'upp', 'rightp', 'front', 'right', 'frontp'};
            faces = execute_algorithm(faces, algorithm, 0);
            [f1, f2, f3, f4, ~] = set_fs(faces);
            pll_moves = [pll_moves algorithm];
        else
            if f1(1) == f1(3)
                algorithm = {'up', 'up'};
                faces = execute_algorithm(faces, algorithm, 0);
                pll_moves = [pll_moves algorithm];

            elseif f2(1) == f2(3)
                faces = rotate_side(faces, 'upp');
                pll_moves = [pll_moves {'upp'}];

            elseif f4(1) == f4(3)
                faces = rotate_side(faces, 'up');
                 pll_moves = [pll_moves {'up'}];

            end
            algorithm = {'rightp', 'front', 'rightp', 'back', 'back', 'right', ...
                         'frontp', 'rightp', 'back', 'back', 'right', 'right'};
            faces = execute_algorithm(faces, algorithm, 0);
            [f1, f2, f3, f4, ~] = set_fs(faces);
            pll_moves = [pll_moves algorithm];
        end 
    end
    
    %% edges permutation
    
    % if edges are not solved
    if ~(f1(1) == f1(2) && f2(1) == f2(2) && f3(1) == f3(2) && f4(1) == f4(2))
       
        % if none is solved
       if ~((f1(1) == f1(2)) || (f2(1) == f2(2)) || (f3(1) ==  f3(2)) || (f4(1) == f4(2)))
            algorithm = {'front', 'front', 'up', 'left', 'rightp', 'front', ... 
                         'front', 'leftp', 'right', 'up', 'front', 'front'};
            faces = execute_algorithm(faces, algorithm, 0);
            [f1, f2, f3, ~, ~] = set_fs(faces);
            % add algorithm          
            pll_moves = [pll_moves algorithm];
       end
       
       % solve last three edges
       % align solved edges on the back
       while f3(1) ~= f3(2)
           faces = rotate_side(faces, 'up');
           [f1, f2, f3, ~, ~] = set_fs(faces);
           pll_moves = [pll_moves {'up'}];
       end
       
      % rotate edges to right
       if f1(2) == f2(1)
           algorithm = {'front', 'front', 'upp', 'left', 'rightp', 'front', ... 
                        'front', 'leftp', 'right','upp', 'front', 'front'}; 
       % rotate edges to left
       else
           algorithm = {'front', 'front', 'up', 'left', 'rightp', 'front', ...
                        'front', 'leftp', 'right', 'up', 'front', 'front'};
       end
       % add algorithm
       pll_moves = [pll_moves algorithm];
    end
end


