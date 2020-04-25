%scramble algorithm: F R L B2 L' R' F2 U2 D R' U2 L
% example: orange = 1
%          green = 2 
%          red = 3 
%          blue = 4
%          yellow = 5
%          white = 6
clear; clc;
f1 = [2 6 3 2 1 3 3 3 5];
f2 = [5 1 6 5 2 4 2 2 2];
f3 = [2 5 4 1 3 4 5 3 4];
f4 = [5 1 1 5 4 3 6 4 4];
f5 = [6 6 3 6 5 1 1 4 1];
f6 = [1 2 3 6 6 5 6 2 4];

faces = [f1; f2; f3; f4; f5; f6];

[hl, hm, hr] = draw(faces);
pause(1);

%calculate cross moves
[cross_moves, cross_moves_idx] = build_cross(faces);

%display cross moves
for i = 1:cross_moves_idx-1
    move = char(cross_moves(i));
%     draw_move(hl, hm, hr, move, 30);
    if move(1) == 'x' || move(1) == 'y' || move(1) == 'z'
        faces = rotate_cube(faces, move);
    else
        faces = rotate_side(faces, move);
    end
%     [hl, hm, hr] = draw(faces);
end

%from now on, face 5 <--> 6 and 2 <--> 4

white_angles = [6 1 2; 6 4 1; 6 3 4; 6 2 3]; 

for i = 1:4
    idx = find_angle(white_angles(i, :), faces);
    [hl, hm, hr] = draw(faces);
    %initialise setup
    setup_idx = 1;
    setup_moves = cell(1, 20);
    
    %Goal: place edge in position: 4 - 3 or 1-1
    % adjust if on side bottom layer
    if idx(1) < 5 && idx(2) > 6    
        while (idx(1) ~= 3 || idx(2) ~= 9) && (idx(1) ~= 4 && idx(2) ~= 7)
            faces = rotate_side(faces, 'down');
            setup_moves{setup_idx} = 'downp';
            setup_idx = setup_idx + 1;
            idx = find_angle(white_angles(i, :), faces);
        end
        
        if idx(1) == 3
            faces = rotate_side(faces, 'backp');
            faces = rotate_side(faces, 'upp');
            faces = rotate_side(faces, 'back');
        else  
            faces = rotate_side(faces, 'left');
            faces = rotate_side(faces, 'up');
            faces = rotate_side(faces, 'leftp');
            faces = rotate_side(faces, 'up');
            faces = rotate_side(faces, 'up');
        end
        %undo setup moves
        for j = (setup_idx-1):-1:1
            move = setup_moves{j}; 
            faces = rotate_side(faces, move);
        end
        setup_idx = 1;
    
    %adjust if on top layer    
    elseif idx(1) < 5 && idx(2) < 6
        [hl, hm, hr] = draw(faces);
        if idx(2) == 1 && idx(1) ~= 1
            %set on position 4 - 1
            for j = idx(1):4
                faces = rotate_side(faces, 'upp');
                 [hl, hm, hr] = draw(faces);
            end
        elseif idx(2) == 3 && idx(1) ~= 4
            %set on position 4 - 3
            for j = idx(1):3
                faces = rotate_side(faces, 'upp');
            end
        end
        
    %adjust if on bottom face
    elseif idx(1) == 5
        switch idx(2)
            case 1
                faces = rotate_side(faces, 'front');
                faces = rotate_side(faces, 'up');
                faces = rotate_side(faces, 'frontp');
                faces = rotate_side(faces, 'upp');
            case 3
                faces = rotate_side(faces, 'right');
                faces = rotate_side(faces, 'up');
                faces = rotate_side(faces, 'rightp');
            case 7
                faces = rotate_side(faces, 'left');
                faces = rotate_side(faces, 'up');
                faces = rotate_side(faces, 'leftp');
                faces = rotate_side(faces, 'up');
                faces = rotate_side(faces, 'up');
            case 9
                faces = rotate_side(faces, 'back');
                faces = rotate_side(faces, 'upp');
                faces = rotate_side(faces, 'upp');
                faces = rotate_side(faces, 'backp');   
        end
    else
        while idx(2) ~= 1
            faces = rotate_side(faces, 'up');
            idx = find_angle(white_angles(i, :), faces);
        end
        faces = rotate_side(faces, 'backp');
        faces = rotate_side(faces, 'up');
        faces = rotate_side(faces, 'up');
        faces = rotate_side(faces, 'back');        
    end
  

    %goal insert piece
    for j = 2:i
        faces = rotate_side(faces, 'upp');
        faces = rotate_cube(faces, 'z');
        setup_moves{setup_idx} = 'zp';
        setup_idx = setup_idx + 1;
        [hl, hm, hr] = draw(faces);
    end
    
    idx = find_angle(white_angles(i, :), faces);
    %insert with L' U' L if on position 1, F' L F L' if on position 3
    if idx(2) == 1
        faces = rotate_side(faces, 'front');
        [hl, hm, hr] = draw(faces);
        faces = rotate_side(faces, 'up');
        [hl, hm, hr] = draw(faces);
        faces = rotate_side(faces, 'frontp');
        [hl, hm, hr] = draw(faces);

    else
        faces = rotate_side(faces, 'leftp');
        faces = rotate_side(faces, 'upp');
        faces = rotate_side(faces, 'left');
    end
    
    %goal: find edge and bring it to place
    corr_edge = white_angles(i, 2:3);
    edge_idx = find_edge(corr_edge, faces);
    [hl, hm, hr] = draw(faces);
    %if it is correct do nothing
    if edge_idx(1) == 1 && edge_idx(2) == 4
        %do nothing
        
    %if its in place but inverted
    elseif edge_idx(1) == 4 && edge_idx(2) == 6
        faces = rotate_side(faces, 'leftp');
        faces = rotate_side(faces, 'upp');
        faces = rotate_side(faces, 'left');
        faces = rotate_side(faces, 'up');
        faces = rotate_side(faces, 'front');
        faces = rotate_side(faces, 'up');
        faces = rotate_side(faces, 'frontp');
        faces = rotate_side(faces, 'upp');
        faces = rotate_side(faces, 'upp');
        [hl, hm, hr] = draw(faces);
        [hl, hm, hr] = draw(faces);
    %edge is inserted in a wrong position
    elseif (edge_idx(1) ~= 6 && edge_idx(2) ~= 2) 
        move_to_do = {'err', 'right'; 'right', 'back'; 'back' 'backp'; 'backp', 'err'};
        move = char(move_to_do(edge_idx(1), round(edge_idx(2)/3)));
        faces = rotate_side(faces, move);
        faces = rotate_side(faces, 'up');
        if move(end) == 'p'
            anti_move = move(1:end-1);
        else
            anti_move = [move 'p'];
        end
        faces = rotate_side(faces, anti_move);
        [hl, hm, hr] = draw(faces);
        [hl, hm, hr] = draw(faces);
    end
        
    %place on top of the right color
    edge_idx = find_edge(corr_edge, faces);
    if edge_idx(1) == 6
        corr_edge = corr_edge(2:-1:1);
        edge_idx = find_edge(corr_edge, faces);
    end
    
    color_white_edge = find_edge([corr_edge(1) 6], faces);
    color_face = color_white_edge(1);
    while edge_idx(1) ~= color_face
        faces = rotate_side(faces, 'up');
        edge_idx = find_edge(corr_edge, faces);
        [hl, hm, hr] = draw(faces);
        
    end
    
    %algorithm to insert
    %find out on which face is it, 1 or 4
    edge_idx = find_edge(corr_edge, faces);
    if edge_idx(1) == 6
        edge_idx = find_edge(corr_edge(2:-1:1), faces);
    end
    
    switch edge_idx(1)
        case 4
            faces = rotate_side(faces, 'up');
            faces = rotate_side(faces, 'front');
            faces = rotate_side(faces, 'up');
            faces = rotate_side(faces, 'frontp');
            faces = rotate_side(faces, 'upp');
            faces = rotate_side(faces, 'leftp');
            faces = rotate_side(faces, 'upp');
            faces = rotate_side(faces, 'left');
            
        case 1
            faces = rotate_side(faces, 'upp');
            faces = rotate_side(faces, 'leftp');
            faces = rotate_side(faces, 'upp');
            faces = rotate_side(faces, 'left');
            faces = rotate_side(faces, 'up');
            faces = rotate_side(faces, 'front');
            faces = rotate_side(faces, 'up');
            faces = rotate_side(faces, 'frontp');
    end
    [hl, hm, hr] = draw(faces);
    %undo setup z rotations 
    for j = (setup_idx-1):-1:1
        move = setup_moves{j}; 
        faces = rotate_cube(faces, move);
    end
    
end

[hl, hm, hr] = draw(faces);

%initialise object

%TODO:
% rotation functions
% find angle
% build cross
% build f2l
% build oll
% build pll
