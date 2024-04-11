function [ payoff ] = payofffunction( p1_resources, p2_resources, attacking_node_value, defending_node_value, gamma, delta )
%PAYOFFFUNCTION Summary of this function goes here
%   Detailed explanation goes here
    victory_probability = p1_resources^gamma/(p1_resources^gamma + p2_resources^gamma);
    victory_value = (p1_resources + defending_node_value) * (1 - delta);
    defeat_value = (p1_resources - attacking_node_value) * (1 - delta);
    payoff = victory_value * victory_probability + defeat_value * (1 - victory_probability);

end

