function [ strategy_list ] = payoffstrategy( current_mapstate, node_adjacency_matrix, player_resources, gamma, delta )
%first determine payoffs for all valid attacks
node_resources = current_mapstate.resources;
ownership = current_mapstate.nodeowners;
payoff_matrix = node_adjacency_matrix;
numberofnodes = size(ownership, 2);
for rowcounter = 1:numberofnodes
    for columncounter = 1:numberofnodes
        if node_adjacency_matrix(rowcounter, columncounter) == 1
            if ownership(rowcounter) ~= ownership(columncounter)
                payoff_matrix(rowcounter, columncounter) = ...
                    payofffunction(player_resources(ownership(rowcounter)), player_resources(ownership(columncounter)), ...
                    node_resources(rowcounter), node_resources(columncounter), gamma, delta);
            end
        end
    end
end

%remove negative payoffs
payoff_matrix(payoff_matrix < 0) = 0;

%return a 2-d matrix of attacking node x defending node

strategy_list = zeros(numberofnodes, numberofnodes);

%if we just want the max strategy for a player
remaining_players = current_mapstate.remainingplayers;
for Counter = remaining_players
    playersnodes = ownership == Counter;
    [max, rowindex, colindex] = twodmax(payoff_matrix(playersnodes, :));
    if max > 0 
        playersnodeslabels = find(playersnodes);
        strategy_list(playersnodeslabels(rowindex), colindex) = 1;
    end
end

%if we want strategy to be distributed as the +ve payoffs
remaining_players = current_mapstate.remainingplayers;
for Counter = remaining_players
    playersnodes = ownership == Counter;
    totalpayoff = sum(sum(payoff_matrix(playersnodes, :)));
    if totalpayoff > 0
        strategy_list(playersnodes, :) = payoff_matrix(playersnodes, :)/totalpayoff;
    end
end


end


