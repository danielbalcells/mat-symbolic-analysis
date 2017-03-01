function outputnmat = markovGeneratorv3(extendedNmat, nNotes)
% Generates a sequence of MIDI notes modeling the input note matrix with a
% first order Markov chain. Differs from markovGenerator in that there are
% two levels of generation:
%   -Key level: models long-term harmony (i.e. verse)
%   -Note level: models notes played in relation to long-term key
%
% Differs from markovGeneratorv2 in that it uses second-order Markov
% chains.
%
% extendedNmat follows the format of a typical MIDI toolbox nmat, with two
% or three additional columns:
%   - Column 8: MIDI note number of the long-term root note
%   - Column 9: Interval in semitones between current note and long-term
%   root.
%   - Column 10: Interval in semitones between current short-term root
%   (i.e. chord) and current long-term root (i.e. key).
    
    % Initialize matrices
    genNotes = zeros(nNotes,3);
    genKeys = zeros(nNotes,1);
    % Low level model: Note generation
    % Take only note-to-root interval, velocity and duration in seconds
    modelNotes = extendedNmat(:,[9,5,7]);
    % High level model: Chord progression
    modelKeys = extendedNmat(:,8);
    % Concatenate each note and its previous two notes to build
    % 1st order Markov chains
    markovNotes = [ modelNotes(1:end-2,:),...
                    modelNotes(2:end-1,:),...
                    modelNotes(3:end,:)];
    markovKeys = [  modelKeys(1:end-2),...
                    modelKeys(2:end-1),...
                    modelKeys(3:end)];
    
    % Take first two notes randomly, iterate
    % Second note is taken using 1st order Markov chain
    genNotes(1,:) = modelNotes(randi(size(modelNotes,1)),[1,2,3]);
    noteCandidates = markovNotes( markovNotes(:,1)==genNotes(1,:),...
                                [4,5,6]);
    genNotes(2,:) = noteCandidates(randi(size(noteCandidates,1)),:);
    currentNote = genNotes(2,1);
    prevNote = genNotes(1,1);
    
    % Same for keys: first key is random, second key uses first-order
    % Markov chain
    genKeys(1) = modelKeys(randi(size(modelKeys,1)),1);
    keyCandidates = markovKeys(markovKeys(:,1)==genKeys(1),2);
    genKeys(2) = keyCandidates(randi(size(keyCandidates,1)),:);
    currentKey = genKeys(2);
    prevKey = genKeys(1);
    
    for i=2:nNotes
        % Get all notes played after current and previous note
        noteCandidates = markovNotes(markovNotes(:,1)==prevNote &...
                                    markovNotes(:,4)==currentNote,...
                                    [7,8,9]);
        % If there are no candidates using order 2, use order 1
        if isempty(noteCandidates)
            noteCandidates = markovNotes(markovNotes(:,4)==currentNote,[7,8,9]);
        end
        genNotes(i,:) = noteCandidates(randi(size(noteCandidates,1)),:);
        currentNote = genNotes(i,1);
        
        % Get all keys played after current and previous note
        keyCandidates = markovKeys(markovKeys(:,1)==prevKey &...
                                   markovKeys(:,2)==currentKey,3);
        % If there are no candidates using order 2, use order 1
        if isempty(keyCandidates)
            keyCandidates = markovKeys(markovKeys(:,2)==currentKey,3);
        end
        genKeys(i) = keyCandidates(randi(size(keyCandidates,1)),:);
        currentKey = genKeys(i);
    end
    % Add generated key numbers to note intervals to get absolute notes
    genNotes(:,1) = genNotes(:,1) + genKeys;
    
    % Convert to nmat format
    seconds2beats = 3.1166666666666; % so ugly to hardcode this right?
    outputmidich = 1;
    outputnmat = zeros(nNotes,7);
    outputnmat(:,[4,5,7]) = genNotes;
    outputnmat(:,6) = cumsum(outputnmat(:,7));
    outputnmat(:,[1,2]) = seconds2beats * outputnmat(:,[6,7]);
    outputnmat(:,3) = outputmidich;