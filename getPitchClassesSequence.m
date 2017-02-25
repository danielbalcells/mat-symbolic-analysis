function pitchClassesSequence = getPitchClassesSequence(nmat,wLen,hop)
    offset = 0;
    duration = nmat(end,6);
    nWindows = ceil(duration/hop);
    pitchClassesSequence = zeros(nWindows,12);
    
    for i = 1:nWindows
        thisWindowEvents = nmat(find((...
            (nmat(:,6)-offset)<wLen) .* ...
            ((nmat(:,6)-offset)>0)),:);
        if ~isempty(thisWindowEvents)
            pitchClassesSequence(i,:) = pcdist1(thisWindowEvents);
        end
        offset = offset + hop;
    end