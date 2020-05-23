function [outcome, number_moves] = main()
    %% initialisation
    %TODO:
    % tidy up
    % commit
    % more efficient moves (fix optimisation function)
    % image acquisition
    
    faces = init();
    number_moves = 0;

    draw(faces);

    %% cross
    
    %calculate cross moves
    [cross_moves, cross_moves_idx] = build_cross(faces);
    cross_moves = cross_moves(1:cross_moves_idx-1);
    %optimise cross moves
    cross_moves = optimise_algorithm(cross_moves);
    %make and display cross moves
    faces = execute_algorithm(faces, cross_moves, 1);

    out = testing(faces, 'cross');
    if ~out
        outcome = 'cross';
        return;
    end

    %% f2l
    %from now on, face 5 <--> 6 and 2 <--> 4
    draw(faces);
    pause(0.5)
    
    %calculate first two layers moves
    [f2l_moves, f2l_moves_idx] = build_f2l(faces);
    f2l_moves = f2l_moves(1:f2l_moves_idx-1);
    %optimise F2L moves
    f2l_moves = optimise_algorithm(f2l_moves);
    %make and display f2l moves
    faces = execute_algorithm(faces, f2l_moves, 1);

    out = testing(faces, 'f2l');
    if ~out
        outcome = 'f2l';
        return;
    end

    %% oll
    draw(faces);
    pause(0.5);

    %calculate orientation last layer moves
    oll_moves = build_oll(faces);
    %optimise OLL moves
    %oll_moves = optimise_algorithm(oll_moves);
    %make and display OLL moves
    faces = execute_algorithm(faces, oll_moves(2:end), 0);
    
    out = testing(faces, 'oll');
    if ~out
        outcome = 'oll';
        return;
    end

    %% pll
    draw(faces);
    pause(0.5)
    %calculate permutation last layer moves
    [pll_moves] = build_pll(faces);
    %optimise PLL moves
    %pll_moves = optimise_algorithm(pll_moves);
    %make and display PLL moves
    faces = execute_algorithm(faces, pll_moves(2:end), 0);

    out = testing(faces, 'pll');
    if ~out
        outcome = 'pll';
        return;
    end

    %% final turns
    draw(faces);
    pause(0.5);
    
    faces = final_turns(faces);
    draw(faces);
    % outcome of the test
    outcome = 'success';
    number_moves = length(cross_moves) + f2l_moves_idx - 1 + length(oll_moves) + length(pll_moves);
end
