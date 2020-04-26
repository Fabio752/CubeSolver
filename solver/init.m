function faces = init()
    % orange = 1 green = 2 red = 3 blue = 4 yellow = 5 white = 6
    clear;  
    
    f1 = ones(1,9);
    f2 = 2 * ones(1,9);
    f3 = 3 * ones(1,9);
    f4 = 4 * ones(1,9);
    f5 = 5 * ones(1,9);
    f6 = 6 * ones(1,9);
    
    faces = [f1; f2; f3; f4; f5; f6];

    all_moves = {'up' 'upp' 'down' 'downp' 'front' 'frontp' 'back' 'backp' 'left' 'leftp' 'right' 'rightp'};
    % testing generator
    scramble = cell(1,30);
    % for repeating test
    % scramble = {'right','down','downp','up','upp','backp','downp','leftp','backp','down','downp','upp','back','upp','right','up','right','down','leftp','up','left','down','rightp','back','back','downp','front','back','back','frontp'};


    for i = 1:length(scramble)
        scramble{i} = all_moves{randi(12)};
        faces = rotate_side(faces, char(scramble(i)));
    end
end