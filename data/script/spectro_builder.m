clc       % Clears the Command Window
clear all % Clears all variables that are in the Workspace
close all % Closes all open windows

addpath('E:\\Independent Study\\Project\audioData\\en10000')

cd 'E:\\Independent Study\\Project\\audioData\\en10000'

Files=dir('*.wav');
numfiles = length(Files)
numfiles = 1000
en_size = zeros(1,numfiles);
zh_size = zeros(1,numfiles);

for i = 0:numfiles-1
    fprintf('%d\n',i);
    [data, Fs] = audioread(['en',int2str(i),'.wav']);
    new_data = resample(data,16000,Fs);
    [s,f,t] = spectrogram(new_data,320,160,512,16000);
    normalize_s = 20*log10(abs(s));
    
    cd 'E:\\Independent Study\\Project\\spectro\\en10000\\data'
    fileID = fopen(['en',int2str(i),'.txt'],'w');
    fprintf(fileID,'%f\n',normalize_s);
    fclose(fileID);    
    
    [m,n] = size(normalize_s);
    en_size(i+1) = n;
    
end


cd 'E:\\Independent Study\\Project\\spectro\\en10000'
histfit(en_size,100,'kernel')
saveas(gcf,'en_size.png')
fileID = fopen('en_size.txt','w');
fprintf(fileID,'%f\n',en_size);
fclose(fileID);

addpath('E:\\Independent Study\\Project\audioData\\zh10000')

cd 'E:\\Independent Study\\Project\\audioData\\zh10000'

Files=dir('*.wav');
%numfiles = length(Files)

for i = 0:numfiles-1
    fprintf('%d\n',i);
    [data, Fs] = audioread(['zh',int2str(i),'.wav']);
    new_data = resample(data,16000,Fs);
    [s,f,t] = spectrogram(new_data,320,160,512,16000);
    normalize_s = 20*log10(abs(s));
    
    cd 'E:\\Independent Study\\Project\\spectro\\zh10000\\data'
    fileID = fopen(['zh',int2str(i),'.txt'],'w');
    fprintf(fileID,'%f\n',normalize_s);
    fclose(fileID);  
    
    [m,n] = size(normalize_s);
    zh_size(i+1) = n;
end

cd 'E:\\Independent Study\\Project\\spectro\\zh10000'
histfit(zh_size,100,'kernel')
saveas(gcf,'zh_size.png')
fileID = fopen('zh_size.txt','w');
fprintf(fileID,'%f\n',zh_size);
fclose(fileID);

size_list = zeros(1,2,numfiles);
for i = 0:numfiles-1
    size_list(1,1,i+1) = en_size(i+1);
    size_list(1,2,i+1) = zh_size(i+1);
end

cd 'E:\\Independent Study\\Project\\spectro'
dlmwrite('sizelist.txt',size_list)