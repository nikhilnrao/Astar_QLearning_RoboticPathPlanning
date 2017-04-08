% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

function Q = learnQMatrix(arena, R, alpha, gamma, nrEpisodes, stepsPerEpsd, learnPolicy)

[arSizeR, arSizeC] = size(arena.arena_m);
goalState = sub2ind([arSizeR arSizeC], arena.des(1), arena.des(2));
Q = zeros(arSizeR*arSizeC);

for episode = 1:nrEpisodes
    currState = randi(arSizeR*arSizeC);
    
    %     Make sure init state does not land on a
    %     corner obstacle which has no plaussible next states.
    while(arena.arena_m(currState) == 1)
        currState = randi(arSizeR*arSizeC);
    end
    
    nextState = 0;
    stepCnt = 0;
    
    while((nextState ~= goalState) && (stepCnt < stepsPerEpsd))
        stepCnt = stepCnt + 1;
        
        psblNxtStates = find(R(currState, :) >= 0);
        nextState = psblNxtStates(randi(size(psblNxtStates, 2)));
        
        if (strcmp(learnPolicy, 'greedy'))
            qAdd = max(Q(nextState, :));
        end
        
        Q(currState, nextState) = (1-alpha)*Q(currState , nextState) ...
            + alpha*(R(currState, nextState) + gamma*qAdd);
        
        % Stochastic World
        currState = stochasticWorld(arena, currState, nextState);
        
        
    end
    
end

end
