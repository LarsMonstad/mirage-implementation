 function [] = startUnix
 |
{Error: Function definition are not supported in this context. Functions can
only be created as local or nested functions in code files.
} 
{Error using nan
Requested 170x353703184 (448.0GB) array exceeds maximum array size preference
(188.4GB). This might cause MATLAB to become unresponsive.

Error in loadDatasets (line 105)
            X     = nan(dimension1, expLen*init);

Error in mlTrainPitchogram (line 13)
[par, X, Y, X2rat, XSet2, YSet2] = loadDatasets(List, @getXY, 'Skip', 1, 'Merge', 1, 'PreAllocate', 1.4);

Error in mlTrainPitch (line 107)
   mlTrainPitchogram('List', par.path, 'Load', 0);

Error in scheduler2022 (line 8)
 mlTrainPitch([-1 0 1 2 3 4 5 6 6.25 6.3 6.4 6.5 6.75 6.8 6.9 7 8 9 10 11 12],   'Path', {'Pitch/script22'});
} 
