% Set up timer and clean up
tic
clear;clc;close all

%% Parameter Initialization
channel =[8];
EMG = ['EMG' num2str(channel)];           % Can edit!
minute = 'Minute1';     % Can edit!

%%%% Don't Change afterwards %%%%
%% Replaced line 12 |=>  subjects = {'BB', 'JF', 'KE', 'NS', 'PS', 'RW', 'JS', 'JK', 'NP','RS', 'DM', 'LM', 'AK','JL'  };
subjects = {'BB', 'JF', 'KE', 'NS', 'PS', 'RW', 'JS', 'JK', 'NP','RS', 'DM', 'LM', 'AK','JL'};
muscle_names = {'TA' 'TA' ...
                'MG' 'MG' ...
                'LG' 'LG' ...
                'Soleus' 'Soleus' ...
                'VM' 'VM' ...
                'RF' 'RF' ...
                'BF' 'BF' ...
                'GM' 'GM' };

%% Acquire condition data
Control_database = ones(length(subjects),1000);
PFDF_database = ones(length(subjects),1000);
PSDS_database = ones(length(subjects),1000);
AEControl_database = ones(length(subjects),1000);

for i = 1:length(subjects)
    % Get the subject's data
    load(['X:\EMG\Code\Minute 1 Minute 4 Data\' subjects{i}]);
    
    % Get the EMG info
    control_data = EMG_norm.(EMG).('Control').(minute);
    PFDF_data = EMG_norm.(EMG).('PFDF').(minute);
    PSDS_data = EMG_norm.(EMG).('PSDS').(minute);
    AEControl_data = EMG_norm.(EMG).('AEControl').(minute);
    
    % Load subject's own normalizing factor
    load(['X:\EMG\Code\norm_factors\Enveloped Factors (n=14)\' subjects{i} '_factor'])
    
    % Normalize subject data
    norm_control_data = (control_data)/EMG_norm_factor;
    norm_PFDF_data = (PFDF_data)/EMG_norm_factor;
    norm_PSDS_data = (PSDS_data)/EMG_norm_factor;
    norm_AEControl_data = (AEControl_data)/EMG_norm_factor;
    
    % Enter data into data banks
    Control_database(i,:) = norm_control_data';
    PFDF_database(i,:) = norm_PFDF_data';
    PSDS_database(i,:) = norm_PSDS_data';
    AEControl_database(i,:) = norm_AEControl_data';
    
    clear EMG_norm subject EMG_norm_factor
end

% Remove all the variables
clearvars -except Control_database PFDF_database PSDS_database ... 
    PFDF_database AEControl_database muscle_names EMG channel

% Get the mean values for the data
Control_mean_data = mean(Control_database);
PFDF_mean_data = mean(PFDF_database);
PSDS_mean_data = mean(PSDS_database);
AEControl_mean_data = mean(AEControl_database);

%% Graph!

% Initialize graph
figure
xlim([0 1000])
xlabel('Gait Cycle (%)','FontWeight', 'bold', ...
    'FontSize', 24);
ylim([0 30])
ylabel('Normalized EMG', 'FontWeight', 'bold', ...
    'FontSize', 24);
set(gca, 'XTickLabel', [0:10:100], 'FontWeight', 'bold','FontSize',24);
if channel
title(sprintf('Gait Cycle vs. Normalized EMG (Right %s, n=14) for Minute 4',...
    muscle_names{channel}), 'FontWeight', 'bold', ... 
    'FontSize', 24);
end
% Calculate and plot the 95% cofidence intervals for control
confidence_intervals_control = ones(2,1000);
for i = 1:1000
    [~,~,ci,~] = ttest(Control_database(:,i), mean(Control_database(:,i)));
    confidence_intervals_control(:,i) = ci;
end
plotshaded(1:1000,confidence_intervals_control,[.1 .1 .1],'none'); hold on

% Initialize toe off line
%62.6 Right Leg so --> 62.6
%62.9 Left Leg so --> 62.9
%Leftleg line:-> toes = [629 629 629 629 629 629 629 629 629 629 629 629 629 629 629 629 ...
%    629 629 629 629 629 629 629 629 629 629];
%ys = [0:25];
%dot = [629 629];
%ydot = [0 .25]; <-: end left leg lines

toes = [626 626 626 626 626 626 626 626 626 626 626 626 626 626 626 626 ...
    626 626 626 626 626 626 626 626 626 626 626 626 626 626 626];
ys = [0:30];
dot = [626 626];
ydot = [0 .30];

% Plot the mean lines
plot(1:1000,Control_mean_data,'k-','LineWidth',1.25)
plot(1:1000,PFDF_mean_data,'g-','LineWidth',1.25)
plot(1:1000,PSDS_mean_data,'r-','LineWidth',1.25)
plot(1:1000,AEControl_mean_data,'b-','LineWidth',1.25)
plot(toes, ys, 'k--')
plot(dot, ydot, 'k')

toc