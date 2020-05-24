function [outcome, number_moves, solution] = main(faces)
    %% initialisation  
    DRAW_BOOL = 0;
    number_moves = 0;
    solution = {};
    
    %% cross
    
    %calculate cross moves
    [cross_moves, cross_moves_idx] = build_cross(faces);
    cross_moves = cross_moves(1:cross_moves_idx-1);
    %optimise cross moves
    cross_moves = optimise_algorithm(cross_moves);
    %make and display cross moves
    faces = execute_algorithm(faces, cross_moves, DRAW_BOOL);

    out = testing(faces, 'cross');
    if ~out
        outcome = 'FAILED CROSS';
        return;
    end

    %% f2l
    %from now on, face 5 <--> 6 and 2 <--> 4
    
    %calculate first two layers moves
    [f2l_moves, f2l_moves_idx] = build_f2l(faces);
    f2l_moves = f2l_moves(1:f2l_moves_idx-1);
    %optimise F2L moves
    f2l_moves = optimise_algorithm(f2l_moves);
    %make and display f2l moves
    faces = execute_algorithm(faces, f2l_moves, DRAW_BOOL);

    out = testing(faces, 'f2l');
    if ~out
        outcome = 'FAILED F2L';
        return;
    end

    %% oll

    %calculate orientation last layer moves
    oll_moves = build_oll(faces);
    oll_moves = oll_moves(2:end);
    %optimise OLL moves
    oll_moves = optimise_algorithm(oll_moves);
    %make and display OLL moves
    faces = execute_algorithm(faces, oll_moves, DRAW_BOOL);
    
    out = testing(faces, 'oll');
    if ~out
        outcome = 'FAILED OLL';
        return;
    end

    %% pll

    %calculate permutation last layer moves
    [pll_moves] = build_pll(faces);
     pll_moves = pll_moves(2:end);
    %optimise PLL moves
     pll_moves = optimise_algorithm(pll_moves);
    %make and display PLL moves
    faces = execute_algorithm(faces, pll_moves, DRAW_BOOL);

    out = testing(faces, 'pll');
    if ~out
        outcome = 'FAILED PLL';
        return;
    end

    %% final turns
    
    [~, ft_moves] = final_turns(faces, DRAW_BOOL);
    
    % outcome of the test
    solution = [cross_moves, f2l_moves, oll_moves, pll_moves, ft_moves];
    outcome = 'SUCCESS';
    number_moves = length(cross_moves) + f2l_moves_idx - 1 + length(oll_moves) + length(pll_moves);
end
