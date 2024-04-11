function [simulationparams] = setparameters()

simulationparams = struct;
%This script sets parameters for how the simulation proceeds

%Loading data
simulationparams.start_state = loadstate('start_state.csv', 'network.csv');
simulationparams.end_state = loadstate('intermediate_state.csv', 'network.csv');

%Simulation details
simulationparams.number_of_simulations = 10000;
simulationparams.number_of_steps = 10;

%Strategies
%Current strategies: 
%0: random attack on anything possible (not implemented)
%1: attack node with highest immediate payoff
%2: attack nodes with positive immediate payoffs, with probability
%proportional to the payoff
simulationparams.strategy = 2;

%Combat
%If suddendeath = 1 then victory over one node takes over the entire empire
%owning that node (eliminating the player). Otherwise the attacker gambles
%one node against an adjacent defending node, 
simulationparams.suddendeath = 0;
%The ratio of victory currently depends on attacker and defender empire
%strengths only, and is the ratio attacker^gamma vs defender^gamma
simulationparams.gamma = 0.9;

%Costs of war
%After combat each node of both empires involved decreases in strength by
%delta. 
simulationparams.delta = 0.05;

%Defection
%NOT YET IMPLEMENTED
%Individual nodes may defect from empires controlling a sufficiently large
%proportion of all resources on the map.
simulationparams.defectempiresize = 0.3;
simulationparams.defectempireprob = 0.05;
%Individual nodes may defect from empires if they control a sufficiently
%large proportion of all resources in the empire.
simulationparams.defectcontrolresources = 0.4;
simulationparams.defectcontrolprob = 0.05;


%Model constraints
%Not yet implemented - whether one empire controlling the same nodes is 
%the same empire whether it flies a Spartan or Corinthian flag (i.e. has a
%different player ID.)

end