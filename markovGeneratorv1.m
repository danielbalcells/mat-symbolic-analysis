function outputnmat = markovGeneratorv1(nmat, nNotes)
% Generates a sequence of MIDI notes modeling the input note matrix with a
% first order Markov chain.
    notes = zeros(nNotes,3);
    % Take only MIDI note, velocity and duration in seconds
    simplenmat = nmat(:,[4,5,7]);
    % Concatenate each note and its next note
    markovNotes = [simplenmat(1:end-1,:),simplenmat(2:end,:)];
    % Take first note randomly, iterate
    notes(1,:) = simplenmat(randi(size(simplenmat,1)),[1,2,3]);
    currentNote = notes(1,1);
    
    for i=2:nNotes
        % Get all notes played after current note
        candidates = markovNotes(markovNotes(:,1)==currentNote,[4,5,6]);
        notes(i,:) = candidates(randi(size(candidates,1)),:);
    end
    
    % Convert to nmat format
    seconds2beats = 3.1166666666666;
    outputmidich = 1;
    outputnmat = zeros(nNotes,7);
    outputnmat(:,[4,5,7]) = notes;
    outputnmat(:,6) = cumsum(outputnmat(:,7));
    outputnmat(:,[1,2]) = seconds2beats * outputnmat(:,[6,7]);
    outputnmat(:,3) = outputmidich;