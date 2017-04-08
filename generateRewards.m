% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

function R = generateRewards(arena)

[arSizeR, arSizeC] = size(arena.arena_m);
R = repmat(-1, arSizeR*arSizeC);
desLnrInd = sub2ind([arSizeR arSizeC], arena.des(1), arena.des(2));
R(desLnrInd, desLnrInd) = 100;

for i = 1:arSizeR*arSizeC
    [row, col] = ind2sub([arSizeR arSizeC], i);
    
    if(row > 1)
        if(sub2ind([arSizeR arSizeC], row-1, col) == desLnrInd)
            R(i, sub2ind([arSizeR arSizeC], row-1, col)) = 100;
        elseif(arena.arena_m(row-1, col) == 1)
            % Do Nothing; R is already initialized to -1
        else
            R(i, sub2ind([arSizeR arSizeC], row-1, col)) = 0;
        end
    end
    if(row < size(arena.arena_m))
        if(sub2ind([arSizeR arSizeC], row+1, col) == desLnrInd)
            R(i, sub2ind([arSizeR arSizeC], row+1, col)) = 100;
        elseif(arena.arena_m(row+1, col) == 1)
            % Do Nothing; R is already initialized to -1
        else
            R(i, sub2ind([arSizeR arSizeC], row+1, col)) = 0;
        end
    end
    
    if(col > 1)
        if(sub2ind([arSizeR arSizeC], row, col-1) == desLnrInd)
            R(i, sub2ind([arSizeR arSizeC], row, col-1)) = 100;
        elseif(arena.arena_m(row, col-1) == 1)
            % Do Nothing; R is already initialized to -1
        else
            R(i, sub2ind([arSizeR arSizeC], row, col-1)) = 0;
        end
    end
    if(col < size(arena.arena_m))
        if(sub2ind([arSizeR arSizeC], row, col+1) == desLnrInd)
            R(i, sub2ind([arSizeR arSizeC], row, col+1)) = 100;
        elseif(arena.arena_m(row, col+1) == 1)
            % Do Nothing; R is already initialized to -1
        else
            R(i, sub2ind([arSizeR arSizeC], row, col+1)) = 0;
        end
    end
end
end
