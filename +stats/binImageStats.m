function ImgStats = binImageStats(ImgStats)
%BINIMAGESTATS Bin image statistics and add to structure
%
% Example: 
%   ImgStats = BINIMAGESTATS(ImgStats)
%   
%   See also COMPUTEIMAGESTATS.
%
% v1.0, 1/5/2016, Steve Sebastian <sebastian@utexas.edu>

binEdges = ImgStats.Settings.binEdges;

nBins = size(binEdges.L,2) - 1;
nTargets = size(ImgStats.Settings.targets,3);

patchIndex = cell(nTargets,1);

for iTar = 1:nTargets
    patchIndex{iTar} = cell(nBins,nBins,nBins);
    for iLum = 1:nBins    
        disp(num2str(iLum));
        for iCon = 1:nBins
            for iSim = 1:nBins
                Sa = ImgStats.Sa(:,:,iTar);
                patchIndex{iTar}{iLum,iCon,iSim} = ...
                 find(ImgStats.L(:) > binEdges.L(iLum) & ImgStats.L(:) <= binEdges.L(iLum+1) ...
                    & ImgStats.C(:) > binEdges.C(iCon) & ImgStats.C(:) <= binEdges.C(iCon+1) ...
                    & Sa(:) > binEdges.Sa(iSim,iTar) & Sa(:) <= binEdges.Sa(iSim+1,iTar));
            end
        end
    end
end

ImgStats.patchIndex = patchIndex;
    