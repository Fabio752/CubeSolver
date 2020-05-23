function draw_move(hl, hm, hr, move, degrees)
    for i = 1:degrees
        switch move
            case 'up'
                handles = [hl(:, 3); hm(:, 3); hr(:, 3)];
                rotate(handles, [0, 0, 1], -90/degrees);
            case 'upp'
                handles = [hl(:, 3); hm(:, 3); hr(:, 3)];
                rotate(handles, [0, 0, 1], 90/degrees);
            case 'down'
                handles = [hl(:, 1); hm(:, 1); hr(:, 1)];
                rotate(handles, [0, 0, 1], 90/degrees);
            case 'downp'
                handles = [hl(:, 1); hm(:, 1); hr(:, 1)];
                rotate(handles, [0, 0, 1], -90/degrees);
            case 'front'
                handles = [hl(1,:); hm(1,:); hr(1,:)];
                rotate(handles, [0, 1, 0], 90/degrees);
            case 'frontp'
                handles = [hl(1,:); hm(1,:); hr(1,:)];
                rotate(handles, [0, 1, 0], -90/degrees);
            case 'back'
                handles = [hl(3,:); hm(3,:); hr(3,:)];
                rotate(handles, [0, 1, 0], -90/degrees);
            case 'backp'
                handles = [hl(3,:); hm(3,:); hr(3,:)];
                rotate(handles, [0, 1, 0], 90/degrees);
            case 'left'
                rotate(hl, [1, 0, 0], 90/degrees);
            case 'leftp'
                rotate(hl, [1, 0, 0], -90/degrees);
            case 'right'
                rotate(hr, [1, 0, 0], -90/degrees);
            case 'rightp'
                rotate(hr, [1, 0, 0], 90/degrees);

            case 'x'
                handles = [hl; hm; hr];
                rotate(handles, [1, 0, 0], -90/degrees);
            case 'xp'
                handles = [hl; hm; hr];
                rotate(handles, [1, 0, 0], 90/degrees);
            case 'y'
                handles = [hl; hm; hr];
                rotate(handles, [0, 1, 0], 90/degrees);
            case 'yp'
                handles = [hl; hm; hr];
                rotate(handles, [0, 1, 0], -90/degrees);
            case 'z'
                handles = [hl; hm; hr];
                rotate(handles, [0, 0, 1], -90/degrees);
            case 'zp'
                handles = [hl; hm; hr];
                rotate(handles, [0, 0, 1], 90/degrees);
        end    
        pause(1/10000);
    end
end




