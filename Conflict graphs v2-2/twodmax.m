function [ maximum, rowindex, colindex ] = twodmax( input_matrix )
%TWODMAX Determines the maximum value and indices of a 2-d matrix
[maximum, I] = max(input_matrix(:));
[rowindex,colindex] = ind2sub(size(input_matrix), I);
end

