% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

function visualizePath(moves, src, arenaHeight)
curStepR = src(1);
curStepC = src(2);

for i=2:size(moves, 2)-1
    switch(moves(i))%[D T R L]
        case 1
            curStepR = curStepR + 1;
        case 2
            curStepR = curStepR - 1;
        case 3
            curStepC = curStepC + 1;
        case 4
            curStepC = curStepC - 1;
        otherwise
    end
    
    rectangle('position', [curStepC, arenaHeight-curStepR+1, 1, 1], 'FaceColor', 'g')
    hold on;
    
end
end