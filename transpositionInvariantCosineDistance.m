function dist = transpositionInvariantCosineDistance(a,b)
% function dist = transpositionInvariantCosineDistance(a,b)
%
% Compute transposition-invariant cosine distance between pitch class
% distribution vectors a and b. Currently, this is done by taking the cosine
% distance between a and every possible circular shift of b and returning
% the minimum of these distances.
    dims = size(a);
    nFeats = dims(2);
    shiftDists = zeros(1,nFeats);
    
    %Iterate all possible shifts and get distance for each shift
    c = b;
    for i=1:nFeats
        shiftDists(i) = dot(a,c) / (sqrt(sum(a.*2)) * sqrt(sum(c.*2)));
        c = circshift(c,1);
    end
    
    dist = max(shiftDists);