function [ strategy_list ] = payoffstrategy( current_mapstate, node_adjacency_matrix, player_resources, parameters )
delta = parameters.delta;
gamma = parameters.gamma;
strategy = parameters.strategy;
suddendeath = parameters.suddendeath;
if strategy == 0
    error ('Random strategy not yet implemented.');
else
%first determine payoffs for all valid attacks
node_resources = current_mapstate.resources;
ownership = current_mapstate.nodeowners;
%payoff_matrix = node_adjacency_matrix;
numberofnodes = max(size(ownership));
% for rowcounter = 1:numberofnodes
%     for columncounter = 1:numberofnodes
%         if node_adjacency_matrix(rowcounter, columncounter) == 1
%             if ownership(rowcounter) ~= ownership(columncounter)
%                 payoff_matrix(rowcounter, columncounter) = ...
%                     payofffunction(player_resources(ownership(rowcounter)), player_resources(ownership(columncounter)), ...
%                     node_resources(rowcounter), node_resources(columncounter), gamma, delta);
%             end
%         end
%     end
% end
node_player_resources = player_resources(ownership);

attacking_player_resources = repmat(node_player_resources, 1, numberofnodes);
defending_player_resources = attacking_player_resources';
bonus_resources = repmat(node_resources, 1, numberofnodes)';
bet_resources = repmat(node_resources, 1, numberofnodes);
victory_probability = (attacking_player_resources.^gamma) ./ (attacking_player_resources .^ gamma + defending_player_resources .^ gamma);
if suddendeath == 0
    victory_value = (attacking_player_resources + bonus_resources) * (1 - delta);
    defeat_value = (attacking_player_resources - bet_resources) * (1 - delta);
elseif suddendeath == 1
    victory_value = (attacking_player_resources + defending_player_resources) * (1 - delta);
    defeat_value = 0;
else
    error('Sudden death parameter not matched.');
    
end

payoff_matrix = (ownership ~= ownership') .* node_adjacency_matrix .* (victory_probability .* victory_value ...
    + (1 - victory_probability) .* defeat_value ...
    - attacking_player_resources);

%remove negative payoffs
payoff_matrix(payoff_matrix < 0) = 0;

%return a 2-d matrix of attacking node x defending node

strategy_list = zeros(numberofnodes, numberofnodes);
if strategy == 1
%if we just want the max strategy for a player

remaining_players = current_mapstate.remainingplayers;
for Counter = remaining_players'
    playersnodes = ownership == Counter;
    [maximum, rowindex, colindex] = twodmax(payoff_matrix(playersnodes, :));
    if maximum > 0 
        playersnodeslabels = find(playersnodes);
        strategy_list(playersnodeslabels(rowindex), colindex) = 1;
    end
end
elseif strategy == 2
%if we want strategy to be distributed as the +ve payoffs
remaining_players = current_mapstate.remainingplayers;
for Counter = remaining_players'
    playersnodes = ownership == Counter;
    totalpayoff = sum(sum(payoff_matrix(playersnodes, :)));
    if totalpayoff > 0
        strategy_list(playersnodes, :) = payoff_matrix(playersnodes, :)/totalpayoff;
    end
end
else
    error('Strategy not recognised.');
end

end


