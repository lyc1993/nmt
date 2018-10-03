clc       % Clears the Command Window
clear all % Clears all variables that are in the Workspace
close all % Closes all open windows

addpath('../audiodata/en10000')

cd '../audiodata/en10000'

Files=dir('*.wav');
numfiles = length(Files);
numfiles = 1000
used_file_id = [];
en_size = [];
zh_size = [];

cd '../../spectrodata/en10000'
for i = 0:3
    fprintf('%d\n',i)
    cd '../../audiodata/en10000'
    [data, Fs] = audioread(['en',int2str(i),'.wav']);
    new_data = resample(data,16000,Fs);
    %fprintf('%d\n',length(data))
    if length(data)<=3e5 && length(data)>=2e5
        %padding
        
        %converting to spectrogram data
        [s,f,t] = spectrogram(new_data,320,160,512,16000);
        %normalize data
        normalize_s = 20*log10(abs(s));
        %save normalized data
        cd '../../spectrodata/en10000'
        fileID = fopen(['en',int2str(i),'.txt'],'w');
        fprintf(fileID,'%f\n',normalize_s);
        fclose(fileID);    
        %save the id number of the audio file for future use
        cd '..'
        used_file_id = [used_file_id,i];
        fileID = fopen('id.txt','a+');
        fprintf(fileID,'%d\n',i);
        fclose(fileID);    
        [m,n] = size(normalize_s);
        en_size = [en_size,length(data)];
        cd './en10000'
    end
end


histfit(en_size,100,'kernel')
saveas(gcf,'en_size.png')
fileID = fopen('en_size.txt','w');
fprintf(fileID,'%f\n',en_size);
fclose(fileID);

addpath('../../audiodata/zh10000')

cd '../../audiodata/zh10000'

Files=dir('*.wav');
%numfiles = length(Files)

for i = used_file_id
    fprintf('%d\n',i);
    [data, Fs] = audioread(['zh',int2str(i),'.wav']);

    new_data = resample(data,16000,Fs);
    %padding
        
    %converting to spectrogram data
    [s,f,t] = spectrogram(new_data,320,160,512,16000);
    normalize_s = 20*log10(abs(s));
    %save normalized data
    cd '../../spectrodata/zh10000'
    fileID = fopen(['zh',int2str(i),'.txt'],'w');
    fprintf(fileID,'%f\n',normalize_s);
    fclose(fileID);  
    
    [m,n] = size(normalize_s);
    zh_size = [zh_size,length(data)];
end


histfit(zh_size,100,'kernel')
saveas(gcf,'zh_size.png')
fileID = fopen('zh_size.txt','w');
fprintf(fileID,'%f\n',zh_size);
fclose(fileID);