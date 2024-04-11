function [ success ] = evaluateattack( resource1, resource2, parameters )
%EVALUATEATTACK Summary of this function goes here
%   Returns 1 if the attacker wins, 0 otherwise.
assert(resource1 > 0);
assert(resource2 > 0);
delta = parameters.delta;
probability = resource1^delta/(resource1^delta + resource2^delta);
success = random('bino', 1, probability);

end

