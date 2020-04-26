function faces = final_turns(faces)
    % if two faces are solved, it is all solved
    if faces(1, 2) == 2 && faces(1, 2) == 3 
        return;
    elseif faces(1, 2) == 2
        algorithm = {'up'};
    elseif faces(1, 2) == 3
        algorithm = {'up', 'up'};
    elseif faces(1, 2) == 4
        algorithm = {'upp'};
    end
    faces = execute_algorithm(faces, algorithm, 0);
end

