function [ simulation_data ] = lotsofruns( parameters )
number_of_simulations = parameters.number_of_simulations;
number_of_steps = parameters.number_of_steps;
starting_mapstate = parameters.start_state;
end_mapstate = parameters.end_state;
%LOTSOFRUNS Summary of this function goes here
%   We create a simulation data array with number_of_simulations rows and
%   number_of_steps columns
simulation_data = cell(number_of_simulations, number_of_steps);
for step_counter = 1:number_of_steps
    for simulation_counter = 1:number_of_simulations
        if step_counter == 1
            current_mapstate = starting_mapstate;
        else 
            current_mapstate = simulation_data{simulation_counter, step_counter - 1};
        end
        if ~isempty(current_mapstate)
            [new_mapstate, status] = turnstep(current_mapstate, parameters);
            if status == 1
                compatibility = iscompatible(new_mapstate, end_mapstate, parameters);
                if compatibility == 1
                    simulation_data{simulation_counter, step_counter} = new_mapstate;
                else
                    simulation_data{simulation_counter, step_counter} = [];                    
                end
            else
                simulation_data{simulation_counter, step_counter} = [];
            end
        end
    end
end

end

