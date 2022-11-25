%---expander_demo---%

clear;clc;

%---parameter---%
updBFS = -6;
upthreshold = 10^(updBFS/20);
downdBFS = -18;
downthreshold = 10^(downdBFS/20);
gain = 10^(-(updBFS+1)/20);

%---read_audio_file---%
[file,path] = uigetfile('*.wav');
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
end

[data,Fs] = audioread(file);
output = zeros(length(data),2);

%---expander---%
for index = 1:length(data)
    if (downthreshold < data(index,1)) && (upthreshold > data(index,1)) && (downthreshold < data(index,2)) && (upthreshold > data(index,2))
        output(index,1) = data(index,1)*gain;
        output(index,2) = data(index,2)*gain;
    elseif (-downthreshold > data(index,1)) && (-upthreshold < data(index,1)) && (-downthreshold > data(index,2)) && (-upthreshold < data(index,2))
        output(index,1) = data(index,1)*gain;
        output(index,2) = data(index,2)*gain;
    else
        output(index,1) = data(index,1);
        output(index,2) = data(index,2);
    end
end

%---write---%
filename = 'output.wav';
audiowrite(filename,output,Fs);