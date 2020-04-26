function faces = final_turns(faces)

    if faces(1, 2) == 2
        algorithm = {'up'};
        faces = execute_algorithm(faces, algorithm, 0);

    elseif faces(1, 2) == 3
        algorithm = {'up', 'up'};
        faces = execute_algorithm(faces, algorithm, 0);

    elseif faces(1, 2) == 4
        algorithm = {'upp'};
        faces = execute_algorithm(faces, algorithm, 0);
    end
end

