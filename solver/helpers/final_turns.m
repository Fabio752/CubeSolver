function faces = final_turns(faces, to_draw)

    if faces(1, 2) == 2
        algorithm = {'up'};
        faces = execute_algorithm(faces, algorithm, to_draw);

    elseif faces(1, 2) == 3
        algorithm = {'up', 'up'};
        faces = execute_algorithm(faces, algorithm, to_draw);

    elseif faces(1, 2) == 4
        algorithm = {'upp'};
        faces = execute_algorithm(faces, algorithm, to_draw);
    end
end

