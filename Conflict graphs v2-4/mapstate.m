classdef mapstate
    %MAPSTATE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mapsize; %number of nodes in the graph
        network; %graph we are trying to take over
        resources; %resources corresponding to each node
        xcoordinates; %x-coordinates for geography plot
        ycoordinates; %y-coordinates for geography plot
        numberplayers;
        players; %IDs of players (e.g. 1:6)
        nodeowners; %ownership of each node 
        remainingplayers;
        gameover = 0; %0 by default, 1 if ended in peace, 2 if terminated and excluded
    end
    
    methods
        function obj = assignplayers(obj, numberofplayers)
            obj.players = 1:numberofplayers;
            obj.numberplayers = numberofplayers;
        end
        
        function obj = setnetwork(obj, networklayout)
            obj.mapsize = numnodes(networklayout);
            obj.network = networklayout;
        end
        
        function obj = initialise(obj, networklayout, resources)
            obj = setnetwork(obj, networklayout);
            obj = assignplayers(obj, obj.mapsize);
            obj.nodeowners = 1:obj.mapsize;
            obj.remainingplayers = 1:obj.mapsize;
            obj.resources = resources;
        end

        
        function hegemon = ishegemony(obj)
            leastowner = min(obj.nodeowners);
            greatestowner = max(obj.nodeowners);
            if leastowner == greatestowner
                hegemon = leastowner;
            else
                hegemon = 0;
            end
        end
        
        function obj = conquer(obj, victor, vanquished, node, parameters)
            if parameters.suddendeath == 0
                obj.nodeowners(node) = victor;
                %             if isempty(obj.nodeowners == vanquished)
                %                 obj.remainingplayers = setdiff(obj.remainingplayers, [vanquished]);
                %             end
                obj.remainingplayers = unique(obj.nodeowners);
            elseif parameters.suddendeath == 1
                obj.nodeowners(obj.nodeowners == vanquished) = victor;
                obj.remainingplayers = setdiff(obj.remainingplayers, [vanquished]);
                
                
            else
                error('Sudden death parameter not matched.');
            end
            affectednodes = obj.nodeowners == victor | obj.nodeowners == vanquished;
            obj.resources(affectednodes) = obj.resources(affectednodes) * (1 - parameters.delta);
            
        end
        
        function obj = attack(obj, attackingnode, defendingnode, parameters)
            attacker = obj.nodeowners(attackingnode);
            defender = obj.nodeowners(defendingnode);
            
            attackerresources = obj.playerresources(attacker);
            defenderresources = obj.playerresources(defender);
            evaluation = evaluateattack(attackerresources, defenderresources, parameters);
            if evaluation == 1
                winner = attacker;
                loser = defender;
                node = defendingnode;
            else
                winner = defender;
                loser = attacker;
                node = attackingnode;
            end
            obj = conquer(obj, winner, loser, node, parameters);
        end
        
        function resourcetotal = playerresources(obj, player)
            resourcetotal = sum(obj.resources(obj.nodeowners == player));
        end
        
        function player_adjacency_matrix = neighbouringplayers(obj)
            player_adjacency_matrix = zeros(obj.numberplayers);
            for playerindex = obj.remainingplayers
                ownednodes = find(obj.nodeowners == playerindex);
                cumulativeneighbourhood = [];
                for testnode = ownednodes
                    neighbourhood = neighbors(obj.network, testnode);
                    cumulativeneighbourhood = [cumulativeneighbourhood; neighbourhood];
                end
                neighbouringowners = obj.nodeowners(cumulativeneighbourhood);
                player_adjacency_matrix(playerindex, neighbouringowners) = 1;
            end
            assert(issymmetric(player_adjacency_matrix));
            player_adjacency_matrix(1:obj.numberplayers + 1:end) = 0;
        end
        
        function player_resource_list = allresources(obj)
            node_resource_list = obj.resources;
            node_owners = obj.nodeowners;
            player_resource_list = zeros(size(obj.players));
            for player = obj.remainingplayers'
                player_resource_list(player) = sum(node_resource_list(node_owners == player));
            end
        end
        
        function plothandle = plot(obj)
            temp_graph = obj.network;
            plothandle = plot(temp_graph, 'MarkerSize', 10*sqrt(obj.resources), ...
                'NodeCData', obj.nodeowners/obj.numberplayers, ...
                'XData', obj.xcoordinates, 'YData', obj.ycoordinates);
            caxis([0 1]);
            %text(plothandle.XData - 0.02, plothandle.YData, num2str(obj.resources));
        end
    end
    
end

