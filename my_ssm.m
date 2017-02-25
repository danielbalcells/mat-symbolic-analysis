function ssm = my_ssm(feats, transpInvariant)
% function ssm = my_ssm(feats, transpInvariant)
%
% Compute self-similarity matrix between vectors of pitch class 
% distributions. Optionally, do this in a transposition-invariant way.

    % Compute dimensions and preallocate memory
    dims = size(feats);
    nVects = dims(1);
    nFeats = dims(2);
    ssm = zeros(nVects,nVects);
    
    % Iterate vectors and compute pair-wise cosine distances.
    for i=1:nVects
        a = feats(i,:);
        for j=1:nVects
            b = feats(j,:);
            if transpInvariant
                ssm(i,j) = transpositionInvariantCosineDistance(a,b);
            else
                ssm(i,j) = dot(a,b)/ (sqrt(sum(a.*2)) * sqrt(sum(b.*2)));
            end
        end
    end