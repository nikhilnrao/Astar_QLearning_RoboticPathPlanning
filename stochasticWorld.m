% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

function currState = stochasticWorld(arena, currState, nextState)

randn = randi(100);
diff = currState - nextState;
upd = 0;

if (randn <= 60) || (arena.arena_m(currState) == 1)
    currState = nextState;
    
elseif(randn > 90)
    % Do Nothing
    
else
    switch(diff)
        case 1 % Robot trying to move up
            errChoice = randi(3);
            
            % Make sure the robot does not wander off on an obstacle
            if (errChoice == 1 && arena.arena_m(currState + 1) ~= 1)
                currState = currState + 1; % go down
                
            elseif (errChoice == 2 && arena.arena_m(currState + size(arena.arena_m, 1)) ~= 1)
                currState = currState + size(arena.arena_m, 1); % go right
                
            elseif (errChoice == 3 && arena.arena_m(currState - size(arena.arena_m, 1)) ~= 1)
                currState = currState - size(arena.arena_m, 1); % go left
            end
            
        case -1 % Robot trying to move down
            errChoice = randi(3);
            
            % Make sure the robot does not wander off on an obstacle
            if (errChoice == 1 && arena.arena_m(currState - 1) ~= 1)
                currState = currState - 1; % go up
                
            elseif (errChoice == 2 && arena.arena_m(currState + size(arena.arena_m, 1)) ~= 1)
                currState = currState + size(arena.arena_m, 1); % go right
                
            elseif (errChoice == 3 && arena.arena_m(currState - size(arena.arena_m, 1)) ~= 1)
                currState = currState - size(arena.arena_m, 1); % go left
            end
            
        case -size(arena.arena_m, 1) % Robot trying to move right
            errChoice = randi(3);
            
            % Make sure the robot does not wander off on an obstacle
            if (errChoice == 1 && arena.arena_m(currState - 1) ~= 1)
                currState = currState - 1; % go up
                
            elseif (errChoice == 2 && arena.arena_m(currState + 1) ~= 1)
                currState = currState + 1; % go down
                
            elseif (errChoice == 3 && arena.arena_m(currState - size(arena.arena_m, 1)) ~= 1)
                currState = currState - size(arena.arena_m, 1); % go left
            end
            
        case +size(arena.arena_m, 1) % Robot trying to move left
            errChoice = randi(3);
            
            % Make sure the robot does not wander off on an obstacle
            if (errChoice == 1 && arena.arena_m(currState - 1) ~= 1)
                currState = currState - 1; % go up
                
            elseif (errChoice == 2 && arena.arena_m(currState + 1) ~= 1)
                currState = currState + 1; % go down
                
            elseif (errChoice == 3 && arena.arena_m(currState + size(arena.arena_m, 1)) ~= 1)
                currState = currState + size(arena.arena_m, 1); % go right
            end
            
    end
    
    
    
    
    
end
end