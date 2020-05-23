function idx = find_angle(angle_to_find, faces)
    %setup stuff
    idx = [-1, -1];
    faces_to_look = [4 6 2 6 4 5 2 5;              
                     1 6 3 6 1 5 3 5;
                     2 6 4 6 2 5 4 5;
                     3 6 1 6 3 5 1 5;
                     1 4 2 1 4 3 3 2;
                     3 4 2 3 4 1 1 2];
                 
    angles_to_look = [3 7 1 9 9 1 7 3;
                      3 9 1 3 9 3 7 9;
                      3 3 1 1 9 9 7 7;
                      3 1 1 7 9 7 7 1;
                      7 9 7 9 7 9 7 9;
                      3 1 3 1 3 1 3 1];

    
    for i = 1:6
        offset = 1;
        for j = 1:2:9
            if j == 5 
                continue;
            end 
            target_faces = faces_to_look(i, offset:offset+1);
            target_angles = angles_to_look(i, offset:offset+1);
            
            other_angles(1) = faces(target_faces(1), target_angles(1));
            other_angles(2) = faces(target_faces(2), target_angles(2));
            
            if faces(i, j) == angle_to_find(1) && ...
               ((other_angles(1) == angle_to_find(2) && other_angles(2) == angle_to_find(3)) || ...
                (other_angles(2) == angle_to_find(2) && other_angles(1) == angle_to_find(3)))
                %found
                idx = [i, j];
            end
            offset = offset+2;
        end
        
    end
end

