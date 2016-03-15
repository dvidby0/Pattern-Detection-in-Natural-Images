function setUpExperiment(ImgStats, expTypeStr)
%SETUPEXPERIMENT Creates and saves all experimental stimuli and settings
% 
% Example: 
%  SETUPEXPERIMENT(ImgStats, 'fovea'); 
%
% Output: 
%  None
%
% See also:
%   SESSIONSETTINGS
%
% v1.0, 2/18/2016, Steve Sebastian <sebastian@utexas.edu>

%% FOVEA 
if(strcmp(expTypeStr, 'fovea'))
    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 10 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    % Contrast range for each level
    targetLvls = repmat(linspace(0.2, 0.05, 5), [size(binIndex,1) , 1]);    

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);

    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), targetLvls(iBin,:));
            
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];

    nSubjects = size(subjectStr, 1);
    
    ExpSettings.targetTypeStr = {'gabor', 'dog'};
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            
            fpOut = [fpSubjects '/' expTypeStr '/' ExpSettings.targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
%% FOVEA PILOT
elseif(strcmp(expTypeStr, 'fovea_pilot'))
    % Experimental bins
    binIndex = [5 1 5; 5 5 5; 5 10 5; 5 5 1; 5 5 10];
 
    nLevels = 4;
    
    % Contrast range for each level
    lumVal = ImgStats.Settings.binCenters.L/100;
    
    targetLvls(1,1,:) = linspace(0.01, 0.003, nLevels);
    targetLvls(1,2,:) = linspace(0.013, 0.05, nLevels);
    targetLvls(1,3,:) = linspace(0.05, 0.02, nLevels);
    targetLvls(1,4,:) = linspace(0.012, 0.02, nLevels);
    targetLvls(1,5,:) = linspace(0.04 , 0.008, nLevels);

	targetLvls(2,1,:) = linspace(0.006, 0.02, nLevels);
    targetLvls(2,2,:) = linspace(0.05, 0.01, nLevels);
    targetLvls(2,3,:) = linspace(0.1, 0.05, nLevels);
    targetLvls(2,4,:) = linspace(0.08, 0.02, nLevels);
    targetLvls(2,5,:) = linspace(0.035 , 0.01, nLevels);
    
    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), targetLvls(iTarget, iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
%% PERIPHERY
elseif(strcmp(expTypeStr, 'periphery'))    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5; 7 5 5; 9 5 5; ...
                5 1 5; 5 3 5; 5 7 5; 5 10 5; ...
                5 5 1; 5 5 3; 7 7 7; 10 5 5];
 
    
    % Eccentricity range for each level
    eLvls = repmat(linspace(2, 10, 5), [size(binIndex,1) , 1]);    

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['sps'; 'rcw'; 'jsa'; 'yhb'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Experiment %s Updated: %s', expTypeStr, datestr(now,'dd.mm.yyyy-HH-MM'));
    fclose(ftemp);     
elseif(strcmp(expTypeStr, 'periphery-pilot'))    
    % Experimental bins
    binIndex = [1 5 5; 3 5 5; 5 5 5;7 5 5; 9 5 5;...
        5 1 5; 5 3 5;5 7 5; 5 9 5; ...
        5 5 1; 5 5 3;5 5 7;5 5 9];
 
    
    % Eccentricity range for each level
    eLvls = repmat(linspace(2, 10, 5), [size(binIndex,1) , 1]);    

    fpSettings = '~/experiment_files/experiment_settings';
    fpSubjects = '~/experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    ImgStats.Settings.imgFilePathExperiment = '~/occluding/natural_images/images_pht/';    
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['rcw';'sps';'jsa';'yhb'];  
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('~/experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Experiment %s Updated: %s', expTypeStr, datestr(now,'dd.mm.yyyy-HH-MM'));
    fclose(ftemp);      

%% Phase Noise
elseif(strcmp(expTypeStr, 'phase-noise'))    
    % Experimental bins
    binIndex    = [1 1 1; 1 2 1; 1 3 1; 1 4 1;1 5 1];  
     
    % Eccentricity range for each level
    eLvls(1,:) = [13.5, 14, 14.5, 15, 17, 21];
    eLvls(2,:) = [7, 7.5, 8, 8.5, 9, 12];
    eLvls(3,:) = [2.5, 4.5, 5, 6, 7, 9];
    eLvls(4,:) = [3. 3.5, 4, 4.5, 5, 7.5];
    eLvls(5,:) = [2, 3.25, 3.5, 3.75, 4, 5];

    fpSettings = 'experiment_files/experiment_settings';
    fpSubjects = 'experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    ImgStats.Settings.imgFilePathExperiment = '/data/masking/natural_images/pixel_space/';
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['rcw-pilot2'];
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Experiment %s Updated: %s', expTypeStr, datestr(now,'dd.mm.yyyy-HH-MM'));
    fclose(ftemp);    
    
elseif(strcmp(expTypeStr, 'uniform'))    
    % Experimental bins
    binIndex    = [1 1 1; 2 1 1; 3 1 1; 4 1 1;5 1 1];  
     
    % Eccentricity range for each level
    eLvls(1,:) = [13.5, 14, 14.5, 15, 17, 21];
    eLvls(2,:) = [7, 7.5, 8, 8.5, 9, 12];
    eLvls(3,:) = [2.5, 4.5, 5, 6, 7, 9];
    eLvls(4,:) = [3. 3.5, 4, 4.5, 5, 7.5];
    eLvls(5,:) = [2, 3.25, 3.5, 3.75, 4, 5];

    fpSettings = '~/experiment_files/experiment_settings';
    fpSubjects = '~/experiment_files/subject_out';
    
    nBins = size(binIndex, 1);
    nTargets = size(ImgStats.Settings.targets, 3);
    
    ImgStats.Settings.imgFilePathExperiment = '/data/masking/natural_images/pixel_space/';
    
    % Session files
    for iBin = 1:nBins
        for iTarget = 1:nTargets
            ExpSettings = experiment.sessionSettings(ImgStats, expTypeStr,...
                ImgStats.Settings.targetKey{iTarget}, binIndex(iBin,:), eLvls(iBin,:));
            fpOut = [fpSettings '/' expTypeStr '/' ExpSettings.targetTypeStr ...
                '/L' num2str(binIndex(iBin,1)) '_C' num2str(binIndex(iBin,2)) ...
                '_S' num2str(binIndex(iBin,3)) '.mat'];
            save(fpOut, 'ExpSettings');
        end
    end
 
    %% Subject experiment files
    subjectStr = ['rcw'];
    nSubjects = size(subjectStr, 1);
    targetTypeStr = ImgStats.Settings.targetKey;
    ExpSettings.binIndex = binIndex;
    
    for iSubject = 1:nSubjects
        for iTarget = 1:nTargets
            SubjectExpFile = experiment.subjectExperimentFile(ExpSettings, binIndex);
            fpOut = [fpSubjects '/' expTypeStr '/' targetTypeStr{iTarget} ...
                '/' subjectStr(iSubject,:) '.mat']; 
            save(fpOut, 'SubjectExpFile');
        end
    end
    
    ftemp = fopen('~/experiment_files/README.txt', 'w');  % Date stamp file generation.
    fprintf(ftemp, 'Experiment %s Updated: %s', expTypeStr, datestr(now,'dd.mm.yyyy-HH-MM'));
    fclose(ftemp);    
    
    
end
    
end
