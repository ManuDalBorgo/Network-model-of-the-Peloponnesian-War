function [ status, attackingnode, defendingnode ] = determine_attack( strategy_list )
%DETERMINESTRATEGY if status = 0 then we have peace

if max(strategy_list(:)) == 0
    status = 0;
    attackingnode = 0;
    defendingnode = 0;
else
    status = 1;
    matrix_size = size(strategy_list);
    strategy_vector = strategy_list(:);
    index_matrix = zeros(matrix_size);
    index_matrix(:) = 1:matrix_size(1)^2;
    item_chosen = randsample(index_matrix(:),1, true, strategy_vector);
    [attackingnode, defendingnode] = ind2sub(size(strategy_list),item_chosen);
    assert(strategy_list(attackingnode, defendingnode) > 0);
end


end

