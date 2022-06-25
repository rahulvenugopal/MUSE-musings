% Load .csv file from MUSE
% Figure out sampling rate from timestamps | Hardcoding as of now
% Select only raw channels | TP9, AF7,AF8,TP10
% Create EEGLAB structure
% Update channel locations | from locs file
% Update EEG.data | chan * timepoints
% Save as .set file
% author @ Rahul Venugopal on 24th of June 2022

%% Read the MUSE out csv file
[musedata, header] = xlsread('RestEEG_MUSE.csv');  

% Picking only Timestamp and raw channels

% Columns are Timestamp, TP9, AF7,AF8,TP10
header = header(1,:);
data = musedata(:,[22,23,24,25]);
timestamps = musedata(:,1);

% Taking transpose channel*datapoints
data = data';
%% Creating EEGLAB structure
eeglab; 

[EEG.data] = data; %The data
[EEG.srate] = 256; %The sampling rate
[EEG.chanlocs] = readlocs('MUSE.locs'); %The electrodes and their locations
[EEG.nbchan] = 4; %Number of electrodes
[EEG.event] = []; %The events - this data is continuous so there will be no markers
[EEG.pnts] = length(EEG.data); %How many data points
[EEG.trials] = 1; %Number of trials
EEG.setname = 'Rest MUSE';

% Update the EEGLAB GUI
eeglab redraw

% Saving the EEG as .set file
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','RestEEGMUSE.set','filepath','D:\\MUSE-musings\\');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
