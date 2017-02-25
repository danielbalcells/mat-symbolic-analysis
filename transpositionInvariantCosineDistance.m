function dist = transpositionInvariantCosineDistance(a,b)
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