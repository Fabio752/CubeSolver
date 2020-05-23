function idx = find_edge(edge, faces)
    idx = [-1, -1];
    
    face_to_look = [6 4 2 5;
                    6 1 3 5;
                    6 2 4 5;
                    6 3 1 5;
                    1 4 2 3;
                    3 4 2 1];
    edge_to_look = [0 4 0 6 2 8;
                    6 0 4 0 6 6;
                    0 6 0 4 8 2;
                    4 0 6 0 4 4;
                    8 8 8 8 0 0;
                    2 2 2 2 0 0];
              
              
    for i = 1:6
        for j = 2:2:8 
            target_face = face_to_look(i, j/2);
            target_edge = faces(target_face, edge_to_look(i, target_face));
            if faces(i, j) == edge(1) &&  target_edge == edge(2)
                %found
                idx = [i, j];
            end
        end
    end
end

