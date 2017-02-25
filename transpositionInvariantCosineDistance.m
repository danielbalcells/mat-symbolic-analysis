function dist = transpositionInvariantCosineDistance(a,b,allowedShifts)
% function dist = transpositionInvariantCosineDistance(a,b)
%
% Compute transposition-invariant cosine distance between pitch class
% distribution vectors a and b. Allowed
% Currently, this is done by taking the cosine
% distance between a and every allowed circular shift of b and returning
% the maximum of these distances.
    dims = size(a);
    nFeats = dims(2);
    nShifts = length(allowedShifts);
    shiftDists = zeros(1,nShifts);
    
    %Iterate all allowed shifts and get distance for each shift
    for i=1:nShifts
        c = circshift(b,allowedShifts(i));
        shiftDists(i) = dot(a,c) / (sqrt(sum(a.*2)) * sqrt(sum(c.*2)));
    end
    
    dist = max(shiftDists);