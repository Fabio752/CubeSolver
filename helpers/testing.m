function [outcome] = testing(faces, part)
    outcome = false;
    [f1, f2, f3, f4, f6] = set_fs(faces);
    f5 = faces(5, :);
    
    switch part
        case 'cross'
            if f5(2) == 6 && f5(4) == 6 && f5(6) == 6 && f5(8) == 6
                outcome = true;
            end
        case 'f2l'
            if f5(1) == 6 && f5(3) == 6 && f5(7) == 6 && f5(9) == 6 && ...
               f1(4) == 1 && f1(6) == 1 && f2(4) == 4 && f2(6) == 4 && ...
               f3(4) == 3 && f3(6) == 3 && f4(4) == 2 && f4(6) == 2
                outcome = true;
            end
        case 'oll'
            if f6(1) == 5 && f6(2) == 5 && f6(3) == 5 && f6(4) == 5 && ...
               f6(6) == 5 && f6(7) == 5 && f6(8) == 5 && f6(9) == 5
                outcome = true;
            end
        case 'pll'
            if f1(1) == f1(2) && f2(1) == f2(2) && f3(1) == f3(2) && f4(1) == f4(2)
                outcome = true;
            end
    end

end

