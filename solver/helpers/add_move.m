function [cr_m, cr_i] = add_move(cr_m, cr_i, move)
    cr_m{cr_i} = move;
    cr_i = cr_i + 1;
end

