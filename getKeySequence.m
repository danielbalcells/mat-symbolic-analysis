function keySequence = getKeySequence(nmat,wLen,hop)
% function pitchClassesSequence = getPitchClassesSequence(nmat,wLen,hop)
% 
% Computes keys on a MIDI note matrix using a sliding
% window of the given length and hopsize.

    % Compute total number of output histograms and preallocate memory
    offset = 0;
    duration = nmat(end,6);
    nWindows = ceil(duration/hop);
    keySequence = zeros(nWindows, 1);
    
    % Slide window over note matrix. Retrieve all MIDI events within the
    % each window and compute pitch class distribution.
    for i = 1:nWindows
        thisWindowEvents = nmat(find((...
            (nmat(:,6)-offset)<wLen) .* ...
            ((nmat(:,6)-offset)>0)),:);
        if ~isempty(thisWindowEvents)
            keySequence(i,:) = kkkey(thisWindowEvents);
        end
        offset = offset + hop;
    end