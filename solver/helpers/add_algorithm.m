function [cr_m, cr_i] = add_algorithm(cr_m, cr_i, algorithm)
    for i = 1:length(algorithm)
        [cr_m,  cr_i] = add_move(cr_m, cr_i, algorithm{i});
    end
end

