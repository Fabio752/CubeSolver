function new_algorithm = optimise_algorithm(moves)
    % optimisations are:
    % 4 equal moves in a row are removed
    % 3 equal moves in a row are inverted to one in the other direction
    % a move followed by the exact opposite is cancelled
    % two moves followed by the exact opposite are cancelled NOT YET DONE
    skip_values = 0;
    new_algorithm = {};
    for i = 1:length(moves)
        if skip_values > 0
            skip_values = skip_values - 1;
            continue;
        end

        % four equal in a row
        if ((length(moves) - i) > 3) && strcmp(moves{i}, moves{i+1}) && strcmp(moves{i+1}, moves{i+2}) ...
           && strcmp(moves{i+2}, moves{i+3})
           skip_values = 3;
           continue;
        end
        % three equal -> one reverted
        if ((length(moves) - i) > 2) && strcmp(moves{i}, moves{i+1}) && strcmp(moves{i+1}, moves{i+2})
            move = moves{i};
            if move(end) == 'p' && move(end-1) ~= 'u'
                anti_move = move(1:end-1);
            else
                anti_move = [move 'p'];
            end
            new_algorithm = [new_algorithm, {anti_move}]; 
            skip_values = 2;
            continue;
        end
        % move and antimove
        if ((length(moves) - i) > 0) && (strcmp([moves{i} 'p'], moves{i+1}) || strcmp(moves{i}, [moves{i+1} 'p']))
            skip_values = 1;
            continue;
        end
        new_algorithm = [new_algorithm, moves{i}];
    end
end

