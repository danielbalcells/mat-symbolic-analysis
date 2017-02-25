function ssm = my_ssm(feats, pitchInvariant)
    dims = size(feats);
    nVects = dims(1);
    nFeats = dims(2);
    ssm = zeros(nVects,nVects);
    
    for i=1:nVects
        a = feats(i,:);
        for j=1:nVects
            b = feats(j,:);
            if pitchInvariant
                ssm(i,j) = transpositionInvariantCosineDistance(a,b);
            else
                ssm(i,j) = dot(a,b)/ (sqrt(sum(a.*2)) * sqrt(sum(b.*2)));
            end
        end
    end