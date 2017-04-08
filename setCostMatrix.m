% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment


function costMatrix = setCostMatrix(currPosR, currPosC, costMatrix, parent, arena)


src = arena.src;
des = arena.des;
% In case it is the source node
if parent(currPosR, currPosC) == 0
    
    % Self
    costMatrix.g(currPosR, currPosC) = pdist([currPosR currPosC; src], 'cityblock');
    costMatrix.h(currPosR, currPosC) = pdist([currPosR currPosC; des], 'euclidean');
    costMatrix.f(currPosR, currPosC) = costMatrix.g(currPosR, currPosC) + ...
        costMatrix.h(currPosR, currPosC);
    
    
    % Top
    if(arena.arena_m(currPosR - 1, currPosC) ~= 1)
        costMatrix.g(currPosR - 1, currPosC) = pdist([currPosR-1 currPosC; src], 'cityblock');
        costMatrix.h(currPosR - 1, currPosC) = pdist([currPosR-1 currPosC; des], 'euclidean');
        costMatrix.f(currPosR - 1, currPosC) = costMatrix.g(currPosR - 1, currPosC) + ...
            costMatrix.h(currPosR - 1, currPosC);
        costMatrix.topUpdThisCycle = 1;
        
    end
    
    % Down
    if(arena.arena_m(currPosR + 1, currPosC) ~= 1)
        costMatrix.g(currPosR + 1, currPosC) = pdist([currPosR+1 currPosC; src], 'cityblock');
        costMatrix.h(currPosR + 1, currPosC) = pdist([currPosR+1 currPosC; des], 'euclidean');
        costMatrix.f(currPosR + 1, currPosC) = costMatrix.g(currPosR + 1, currPosC) + ...
            costMatrix.h(currPosR + 1, currPosC);
        costMatrix.dwnUpdThisCycle = 1;
    end
    
    
    % Left
    if(arena.arena_m(currPosR, currPosC - 1) ~= 1)
        costMatrix.g(currPosR, currPosC - 1) = pdist([currPosR currPosC-1; src], 'cityblock');
        costMatrix.h(currPosR, currPosC - 1) = pdist([currPosR currPosC-1; des], 'euclidean');
        costMatrix.f(currPosR, currPosC - 1) = costMatrix.g(currPosR, currPosC - 1) + ...
            costMatrix.h(currPosR, currPosC - 1);
        costMatrix.lftUpdThisCycle = 1;
    end
    
    
    % Right
    if(arena.arena_m(currPosR, currPosC + 1) ~= 1)
        costMatrix.g(currPosR, currPosC + 1) = pdist([currPosR currPosC+1; src], 'cityblock');
        costMatrix.h(currPosR, currPosC + 1) = pdist([currPosR currPosC+1; des], 'euclidean');
        costMatrix.f(currPosR, currPosC + 1) = costMatrix.g(currPosR, currPosC + 1) + ...
            costMatrix.h(currPosR, currPosC + 1);
        costMatrix.rgtUpdThisCycle = 1;
    end
    
else
    % Top
    [parentR, parentC] =  ind2sub(size(parent), parent(currPosR, currPosC));
    
    if(arena.arena_m(currPosR - 1, currPosC) ~= 1)
        if costMatrix.f(currPosR - 1, currPosC) == inf
            costMatrix.g(currPosR - 1, currPosC) = costMatrix.g(parentR, parentC) + 2;
            costMatrix.h(currPosR - 1, currPosC) = pdist([currPosR-1 currPosC; des], 'euclidean');
            costMatrix.f(currPosR - 1, currPosC) = costMatrix.g(currPosR - 1, currPosC) + ...
                costMatrix.h(currPosR - 1, currPosC);
            costMatrix.topUpdThisCycle = 1;
        end
    end
    
    % Down
    if(arena.arena_m(currPosR + 1, currPosC) ~= 1)
        if costMatrix.f(currPosR + 1, currPosC) == inf
            costMatrix.g(currPosR + 1, currPosC) = costMatrix.g(parentR, parentC) + 2;
            costMatrix.h(currPosR + 1, currPosC) = pdist([currPosR+1 currPosC; des], 'euclidean');
            costMatrix.f(currPosR + 1, currPosC) = costMatrix.g(currPosR + 1, currPosC) + ...
                costMatrix.h(currPosR + 1, currPosC);
            costMatrix.dwnUpdThisCycle = 1;
        end
    end
    
    % Left
    if(arena.arena_m(currPosR, currPosC - 1) ~= 1)
        if costMatrix.f(currPosR, currPosC - 1) == inf
            costMatrix.g(currPosR, currPosC - 1) = costMatrix.g(parentR, parentC) + 2;
            costMatrix.h(currPosR, currPosC - 1) = pdist([currPosR currPosC-1; des], 'euclidean');
            costMatrix.f(currPosR, currPosC - 1) = costMatrix.g(currPosR, currPosC - 1) + ...
                costMatrix.h(currPosR, currPosC - 1);
            costMatrix.lftUpdThisCycle = 1;
        end
    end
    
    % Right
    if(arena.arena_m(currPosR, currPosC + 1) ~= 1)
        if costMatrix.f(currPosR, currPosC + 1) == inf
            costMatrix.g(currPosR, currPosC + 1) = costMatrix.g(parentR, parentC) + 2;
            costMatrix.h(currPosR, currPosC + 1) = pdist([currPosR currPosC+1; des], 'euclidean');
            costMatrix.f(currPosR, currPosC + 1) = costMatrix.g(currPosR, currPosC + 1) + ...
                costMatrix.h(currPosR, currPosC + 1);
            costMatrix.rgtUpdThisCycle = 1;
        end
    end
end


end
