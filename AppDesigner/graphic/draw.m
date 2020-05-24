function [handles_left, handles_middle, handles_right] = draw(faces, fig)
   
    % example: orange = 1
    %          green = 2 
    %          red = 3 
    %          blue = 4
    %          yellow = 5
    %          white = 6
    cla(fig);
    view(fig, 3)
    axis(fig, 'vis3d')
    
    set(fig,'visible','off')
    set(fig,'CameraViewAngleMode', 'Manual')
    axis(fig, 'equal')
    
    f1 = faces(1, :);
    f2 = faces(2, :);
    f3 = faces(3, :);
    f4 = faces(4, :);
    f5 = faces(5, :);
    f6 = faces(6, :);
    
    white = [1.0, 1.0, 1.0];
    yellow = [1.0, 1.0, 0];
    blue = [0, 0, 1.0];
    green = [0, 1.0, 0];
    red = [1.0, 0, 0];
    orange = [1.0, 0.6, 0.05];

    num2col = [orange; green; red; blue; yellow; white];

    black = [0.0, 0.0, 0.0];

    % colors = [orange; green; red; blue; yellow; white];
    colors_list = [1 f1(7); 4 f4(9); 5 f5(1); 1 f1(4); 4 f4(6); 1 f1(1); 4 f4(3); 6 f6(7);
                   4 f4(8); 5 f5(4); 4 f4(5); 4 f4(2); 6 f6(4);
                   4 f4(7); 3 f3(9); 5 f5(7); 4 f4(4); 3 f3(6); 4 f4(1); 3 f3(3); 6 f6(1);
                   1 f1(8); 5 f5(2); 1 f1(5); 1 f1(2); 6 f6(8);
                   5 f5(5); 6 f6(5);
                   3 f3(8); 5 f5(8); 3 f3(5); 3 f3(2); 6 f6(2);
                   1 f1(9); 2 f2(7); 5 f5(3); 1 f1(6); 2 f2(4); 1 f1(3); 2 f2(1); 6 f6(9);
                   2 f2(8); 5 f5(6); 2 f2(5); 2 f2(2); 6 f6(6);
                   2 f2(9); 3 f3(7); 5 f5(9); 2 f2(6); 3 f3(4); 2 f2(3); 3 f3(1); 6 f6(3)];
    color_idx = 1;

    handles_left = zeros(3);
    handles_middle = zeros(3);
    handles_right = zeros(3);
    
    %drawing loop
    for x = 0:2
        for y = 0:2
            for z = 0:2
                %initialise color vector
                colors = [black; black; black; black; black; black];

                vert = [x y z; x+1 y z; x+1 y+1 z; x y+1 z;
                         x y z+1; x+1 y z+1; x+1 y+1 z+1; x y+1 z+1];
                fac = [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8];

                jump = 0;

                %if center piece
                if ((x == 1 && y == 1) || (x == 1 && z == 1) || (y == 1 && z == 1)) 
                    jump = 0; 
                %if edge or 
                elseif mod(x+y+z, 2) == 1 
                    jump = 1;
                else
                    jump = 2;
                end
                %extrapolate data
                face_idx = colors_list(color_idx:color_idx+jump, 1); 
                face_color = colors_list(color_idx:color_idx+jump, 2);

                colors(face_idx, :) = num2col(face_color, :);
                if ~(x == 1 && y == 1 && z == 1)
                    color_idx = color_idx + jump + 1;
                end
                if x == 0
                    handles_left(y+1, z+1) = drawcube(vert, fac, colors, fig);
                elseif x == 1
                    handles_middle(y+1, z+1) = drawcube(vert, fac, colors, fig);
                else 
                    handles_right(y+1, z+1) = drawcube(vert, fac, colors, fig);
                end
            end
        end
    end    
end

function handle = drawcube (vert, fac, colors, fig)
    handle = patch('Vertices',vert,'Faces',fac, 'FaceVertexCData', ...
                    colors,'FaceColor','flat', 'Parent', fig);
end