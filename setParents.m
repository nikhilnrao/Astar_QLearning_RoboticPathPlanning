% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

function parent = setParents(currPosR, currPosC, parent, visited)

% Top
if parent(currPosR - 1, currPosC) == 0 && (visited(currPosR - 1, currPosC) == 0)
    parent(currPosR - 1, currPosC) = sub2ind(size(parent), currPosR, currPosC);
end

% Down
if parent(currPosR + 1, currPosC) == 0 && (visited(currPosR + 1, currPosC) == 0)
    parent(currPosR + 1, currPosC) = sub2ind(size(parent), currPosR, currPosC);
end

% Left
if parent(currPosR, currPosC - 1) == 0 && (visited(currPosR, currPosC - 1) == 0)
    parent(currPosR, currPosC - 1) = sub2ind(size(parent), currPosR, currPosC);
end

% Right
if parent(currPosR, currPosC + 1) == 0 && (visited(currPosR, currPosC + 1) == 0)
    parent(currPosR, currPosC + 1) = sub2ind(size(parent), currPosR, currPosC);
end

end
