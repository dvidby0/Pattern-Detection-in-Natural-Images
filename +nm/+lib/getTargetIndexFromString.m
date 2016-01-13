function tIndex = getTargetIndexFromString(Settings, targetTypeStr)
%GETTARGETINDEXFROMSTRING Returns the target key index given a target string
% 
% Example: 
%	Settings = nm.stats.LOADEXPERIMENTSETTINGS('fovea');
%   tIndex = nm.lib.GETTARGETINDEXFROMSTRING(Settings, gabor); 
%
% v1.0, 1/13/2016, Steve Sebastian <sebastian@utexas.edu>

%% Find the index, return -1 if not found
indexCell = strfind(settings.targetKey, targetTypeStr);
tIndex = find(not(cellfun('isempty', indexCell)));

if(isempty(tIndex))
	tIndex = -1;
end