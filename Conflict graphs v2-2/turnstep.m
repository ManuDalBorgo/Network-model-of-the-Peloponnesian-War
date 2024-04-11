function [ new_mapstate, status ] = turnstep( starting_mapstate, parameters )
%TURNSTEP Summary of this function goes here
%   Detailed explanation goes here
strategy_matrix = payoffstrategy(starting_mapstate, full(adjacency(starting_mapstate.network)), ...
    allresources(starting_mapstate), parameters);
[status, attackingnode, defendingnode] = determine_attack(strategy_matrix);
if status == 1
    new_mapstate = attack(starting_mapstate, attackingnode, defendingnode, parameters);
else
    new_mapstate = starting_mapstate;
end
end

