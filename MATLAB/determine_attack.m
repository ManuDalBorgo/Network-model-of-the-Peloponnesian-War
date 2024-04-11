function [ status, attackingnode, defendingnode ] = determine_attack( strategy_list )
%DETERMINESTRATEGY if status = 0 then we have peace

if max(strategy_list(:)) == 0
    status = 0;
else
    status = 1;
    matrix_size = size(strategy_list);
    strategy_vector = strategy_matrix(:);
    index_matrix = zeros(matrix_size);
    index_matrix(:) = 1:matrix_size(1)^2;
    item_chosen = randsample(index_matrix(:),1, true, strategy_vector);
    [attackingnode, defendingnode] = ind2sub(size(strategy_matrix),item_chosen);
 
end


end

