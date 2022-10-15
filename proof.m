function [F1,precision,recall,align,binalign] = proof(file_truth,file_test)
seq1 = midi2nmat(file_truth);
seq1 = seq1(:,[6,4])'; % Onset time and pitch series for the first sequence (reference, truth of autority)

seq2 = midi2nmat(file_test);
seq2 = seq2(:,[6,4])'; % Onset time and pitch series for the evaluated sequence

maxTmerge = 0.13; % Annotations within 130 ms can be merged
% maxTskip  = 0.035; % If within 30 ms, no need to
maxPmerge = 0.75; % Annotations within 0.75 cent can be merged
% maxPskip  = 0.4;

w = getWeightM(seq1, seq2, maxTmerge, maxPmerge);
% Get similarity matrix based on distance of onsets and of pitch between
% each pair of notes in the two sequences.

[~, i1, i2] = bipartite_matching(w);
% Infers the alignment between the two sequences.
% i1 and i2 are the indices in the first and second sequences.

align = zeros(6,0);
% Each column corresponds to a successive alignment between two notes in
% the two sequences.
% The six rows of align contains the following:
% - The onset and pitch of the note in the reference sequence
% - The index of that note in the reference sequence
% - The onset and pitch of the note in the evaluated sequence
% - The index of that note in the evaluated sequence

align1 = 0;
align2 = 0;

tp = length(i1);
% All notes in the alignment are considered as correct, so the number of
% true positives within each sequence is the number of aligned notes.

fn = size(seq1,2) - length(i1);
% The false negatives are the notes in the reference sequence that have not
% been aligned.

fp = size(seq2,2) - length(i2);
% The false positives are the notes in the evaluated sequence that have not
% been aligned.

precision = tp/(tp+fp)
recall = tp/(tp+fn)
F1 = 2 / (1/recall + 1/precision)

if nargout > 3
    for i = 1:length(i1)
        % For each successive pair of notes in the alignment
        note1i = seq1(:,i1(i));
        note2i = seq2(:,i2(i));
    
        % The aligned note will be added in align at the column that is inc step
        % after the last column
         
        if isempty(align)
            inc = 1;
            dec = 1;
        else
            delta1 = i1(i) - align1;
            delta2 = i2(i) - align2;
            dec = min(delta1, delta2);
            if dec < 0
                inc = dec;
            else
                inc = max(delta1, delta2);
            end
        end
        endalign = size(align,2);
        if dec > 0 && inc > 1
            if delta1 == 1
                align(1:3,endalign+1:endalign+inc-1) = NaN;
            end
            if delta2 == 1
                align(4:6,endalign+1:endalign+inc-1) = NaN;
            end
        end
    
        align(:,endalign+inc) = [note1i;i1(i);note2i;i2(i)];
        % The aligned note is added in align at the column that is inc step
        % after the last column
        
        align1 = max(align1,i1(i)); % Rightmost index in reference sequence so far
        align2 = max(align2,i2(i)); % Rightmost index in evaluated sequence so far
    end
    
    binalign = align([1,4],:);
    binalign(binalign > 0) = 1;
    binalign(isnan(binalign)) = -1;
    figure,imagesc(binalign)
end
