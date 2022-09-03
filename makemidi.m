function [] = makemidi(x)
 
% Code by Olivier Lartillot and Lars Monstad for the MIRAGE project
% A recursive Matlab script to make midifiles of automatically transcribed songs in the dataset. 
% Should be called in the scheduler.m with: 
% makemidi('/cluster/projects/nn9750k/lars1/2022/MusicTracker/Sets/februaryset');
cd(x);

recurs;


function recurs %(folder)
%    cd (folder)
    d = dir;
    disp(pwd);
    for i = 1:length(d)
        if strcmp(d(i).name(1),'.')
            continue
        end
        if d(i).isdir
            cd(d(i).name)
            recurs
            cd ..
        else
            %disp(d(i))
            if length(d(i).name) > 7 && strcmpi(d(i).name(end-6:end),'.onfeat')
                disp(d(i).name)
                %% Call the convertion function here
                convert(d(i).name)
                d(i).name
            end
        end
    end
end




function convert(filename)
% convert to midi 
  tab2=importdata(filename);
  N = size(tab2,1);
  M = zeros(N,6);
  M(:,1) = 1;         % all in track 1
  M(:,2) = 1;         % all in channel 1
  M(:,3) = [tab2.pitchOnset];
  M(:,4) = 60;
  M(:,5) = [tab2.on_t];
  M(:,6) = [tab2.off_t];
  midi_new = matrix2midi(M);
  writemidi(midi_new, [filename,'.mid']);
end

end
