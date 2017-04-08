% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

clc
clear all;
close all;
arena = importArena('arena10x10-1.txt', 10, 10);


visited = zeros(size(arena.arena_m,1), size(arena.arena_m, 2));
parent = zeros(size(arena.arena_m,1), size(arena.arena_m, 2));
costMatrix.g = inf(size(arena.arena_m,1), size(arena.arena_m, 2));
costMatrix.h = inf(size(arena.arena_m,1), size(arena.arena_m, 2));
costMatrix.f = inf(size(arena.arena_m,1), size(arena.arena_m, 2));

currPosR = arena.src(1);
currPosC = arena.src(2);
moveCnt = 1;
nxtMove = 0;

while(currPosR ~= arena.des(1) || currPosC ~= arena.des(2))
    costMatrix.lftUpdThisCycle = 0;
    costMatrix.dwnUpdThisCycle = 0;
    costMatrix.topUpdThisCycle = 0;
    costMatrix.rgtUpdThisCycle = 0;
    
    moveCnt = moveCnt + 1;
    visited(currPosR, currPosC) = 1;
    parent = setParents(currPosR, currPosC, parent, visited);
    costMatrix = setCostMatrix(currPosR, currPosC, costMatrix, parent, arena);
    
    options = [inf inf inf inf];
    
    if costMatrix.dwnUpdThisCycle
        options(1) = costMatrix.f(currPosR + 1, currPosC);
    end
    
    if costMatrix.topUpdThisCycle
        options(2) = costMatrix.f(currPosR - 1, currPosC);
    end
    
    if costMatrix.rgtUpdThisCycle
        options(3) = costMatrix.f(currPosR, currPosC + 1);
    end
    
    if costMatrix.lftUpdThisCycle
        options(4) = costMatrix.f(currPosR, currPosC-1);
    end
    
   switch(nxtMove(moveCnt-1))
        case 1
            options(2) = inf;
        case 2
            options(1) = inf;
        case 3
            options(4) = inf;
        case 4
            options(3) = inf;
        otherwise
    end
    nxt = find(options == min(options));
    
    
    for i =1:size(nxt, 2)
        
        switch (nxt(i)) %[Down Top Right Left]
            case 1
                if(visited(currPosR + 1, currPosC) == 0)
                    currPosR = currPosR + 1;
                    nxtMove(moveCnt) = nxt(i);
%                     disp('Down');
                    break;
                end
            case 2
                if(visited(currPosR - 1, currPosC) == 0)
                    currPosR = currPosR - 1;
                    nxtMove(moveCnt) = nxt(i);
%                     disp('Top');
                    break;
                end
            case 3
                if(visited(currPosR, currPosC + 1) == 0)
                    currPosC = currPosC + 1;
                    nxtMove(moveCnt) = nxt(i);
%                     disp('Right');
                    break;
                end
            case 4
                if(visited(currPosR, currPosC - 1) == 0)
                    currPosC = currPosC - 1;
                    nxtMove(moveCnt) = nxt(i);
%                     disp('Left');
                    break;
                end
            otherwise
        end
        
    end
    %     pause(1)
end

visualizeArena(arena.arena_m);
hold on
% pause();
visualizePath(nxtMove, arena.src, size(arena.arena_m, 2));

% figure(2);
% 
% imagesc((costMatrix.f))
% title('F-Costs');
% colormap hot;
% 
% colorbar
 