function [loaded_mapstate] = loadstate(nodedata_filename, connections_filename)
%LOADSTATE Summary of this function goes here
%   Detailed explanation goes here
loaded_mapstate = mapstate;
node_data = readtable(nodedata_filename);
number_nodes = size(node_data, 1);
loaded_mapstate.mapsize = number_nodes;
loaded_mapstate.resources = node_data.Resources;
loaded_mapstate.xcoordinates = node_data.x_coordinate;
loaded_mapstate.ycoordinates = node_data.y_coordinate;
loaded_mapstate.numberplayers = number_nodes;
loaded_mapstate.players = (1:number_nodes)';
loaded_mapstate.nodeowners = node_data.Player;
loaded_mapstate.remainingplayers = unique(node_data.Player);

network_edges = readtable(connections_filename);
network = full(sparse(network_edges.Startnode, network_edges.Endnode, 1, number_nodes, number_nodes));
network = network + network';
loaded_mapstate.network = graph(network, node_data.Name);
end

