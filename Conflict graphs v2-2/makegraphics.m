function Counter = makegraphics()
number_of_iterations = 50;
parameters = setparameters;
starting_state = parameters.start_state;
currentstate = starting_state;

save_plot(currentstate, 0, 'This is the starting position where all city-states are independent.');
for Counter = 1:number_of_iterations
    [currentstate, status, message] = debug_turnstep(currentstate, parameters);
    save_plot(currentstate, Counter, message);
    if status == 0
        break;
    end
end
end

function [ new_mapstate, status, message ] = debug_turnstep( starting_mapstate, parameters )
%TURNSTEP Summary of this function goes here
%   Detailed explanation goes here
strategy_matrix = payoffstrategy(starting_mapstate, full(adjacency(starting_mapstate.network)), ...
    allresources(starting_mapstate), parameters);
[status, attackingnode, defendingnode] = determine_attack(strategy_matrix);
if status == 1
    new_mapstate = attack(starting_mapstate, attackingnode, defendingnode, parameters);
attackingplayer = starting_mapstate.nodeowners(attackingnode);
defendingplayer = starting_mapstate.nodeowners(defendingnode);
assert(attackingplayer ~= defendingplayer);
winner = new_mapstate.nodeowners(defendingnode);
message = write_message(attackingnode, defendingnode, attackingplayer, defendingplayer, winner, parameters);
    
else
    new_mapstate = starting_mapstate;
            message = 'No player has positive pay-off for attacking.';

    %error('Peace happened.');
end
end

function [message_text] = write_message(attackingnode, defendingnode, attackingplayer, defendingplayer, winner, parameters)
starting_state = parameters.start_state;
network = starting_state.network;
attack_source_name = char(network.Nodes.Name(attackingnode));
attack_target_name = char(network.Nodes.Name(defendingnode));
attackingplayername = char(network.Nodes.Name(attackingplayer));
defendingplayername = char(network.Nodes.Name(defendingplayer));
message_text = [attackingplayername ' attacks ' defendingplayername ' from ' attack_source_name ' at ' ...
    attack_target_name];
if winner == attackingplayer
    message_text = [message_text ' and wins.'];
else
    message_text = [message_text ' and loses.'];
end

end

function save_plot(mapstate, index, message)
newmessage = [num2str(index + 1) '. ' message];
filename = ['iteration ' num2str(index) '.png'];
mapfigure = plot(mapstate);
title(newmessage);
set(gcf, 'Name', filename);
set(gcf,'PaperPositionMode','auto')
print(filename,'-dpng','-r0')

end