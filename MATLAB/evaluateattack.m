function [ success ] = evaluateattack( resource1, resource2, parameters )
%EVALUATEATTACK Summary of this function goes here
%   Returns 1 if the attacker wins, 0 otherwise.
assert(resource1 > 0);
assert(resource2 > 0);
probability = resource1^parameters/(resource1^parameters + resource2^parameters);
success = random('bino', 1, probability);

end

