% Author: Nikhil Nagraj Rao
% PID: n3621940
% University of Central Florida
% 30 March 2015
% CAP 6671 - Robotics Assignment

clc
clear all;
close all;

arena = importArena('arena_learnQ-10x10.txt', 10, 10);
alpha = 0.9;
gamma = 0.5;
nrEpisodes = 50;
stepsPerEpsd = 150;
learnPolicy = 'greedy';
learn = 0;

goalState = sub2ind(size(arena.arena_m), arena.des(1), arena.des(2));
R = generateRewards(arena);
if learn == 1
    Q = learnQMatrix(arena, R, alpha, gamma, nrEpisodes, stepsPerEpsd, learnPolicy);
    save('qMatrix.mat', 'Q');
else
    load('qMatrix');
end

if learn == 1
    arena.src(1) = size(arena.arena_m, 1) - 8 + 1; 
    arena.src(2) = 9;    
    arena.arena_m(arena.src(1), arena.src(2)) = 2;
    currState = sub2ind(size(arena.arena_m), arena.src(1), arena.src(2));
    visualizeArena(arena.arena_m);
else
    prompt = 'What is the source node Row? ';
    arena.src(1) = size(arena.arena_m, 1) - input(prompt) + 1;
    prompt = 'What is the source node Column? ';
    arena.src(2) = input(prompt);
    arena.arena_m(arena.src(1), arena.src(2)) = 2;
    currState = sub2ind(size(arena.arena_m), arena.src(1), arena.src(2));

    visualizeArena(arena.arena_m);
    hold on
    nextState =0;
end
    
    while(currState ~= goalState)
        nextState = find(Q(currState, :) == max(Q(currState, :)));
        
        if nextState ~= goalState
            [nxtR, nxtC] = ind2sub(size(arena.arena_m), nextState);
            rectangle('position', [nxtC, size(arena.arena_m, 1)-nxtR + 1, 1, 1], 'FaceColor', 'g');
        end
        if learn == 1
            currState = nextState;
        else
            currState = stochasticWorld(arena, currState, nextState);
        end
    end

