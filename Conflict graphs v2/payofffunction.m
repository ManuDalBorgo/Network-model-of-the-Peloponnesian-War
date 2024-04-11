function [ payoff ] = payofffunction( p1_resources, p2_resources, attacking_node_value, defending_node_value, parameters )
%PAYOFFFUNCTION Summary of this function goes here
%   This function is currently unused
gamma = parameters.gamma;
delta = parameters.delta;
suddendeath = parameters.suddendeath;
    victory_probability = p1_resources^gamma/(p1_resources^gamma + p2_resources^gamma);
if suddendeath == 0
    defeat_value = (p1_resources - attacking_node_value) * (1 - delta);
    payoff = victory_value * victory_probability ...
        + defeat_value * (1 - victory_probability) ...
        - p1_resources;
elseif suddendeath == 1
    victory_value = (p1_resources + p2_resources) * (1 - delta);
    payoff = victory_value * victory_probability - p1_resources;    
else
    error('Sudden death parameter not matched.');
end
end

