function helldir(topic,option)
% opens my commonly used folders.
% 
% SPEED DIAL:
    % 0: custom files
    % 1: research
    % 2: ice experiments
% ALL ENTRIES
    % 'hellfiles': my custom files
    % 'Research': TG_ellipse
    % 'IceExperiments': ice experiment
    % 'ParticleCode': Michelle Particle tracking code
    % 'chaos' or 'lastchaos': AMATH502
    % 'amath581' or 'lastamath581': AMATH 581
    % 'ocean' or 'lastocean': OCEAN 510
% OPTIONAL ENTRY:
    % option = 'addpath': adds requested folder to current path. otherwise
    % makes it the current directory.

%-OPTION-------------------------------------------------------------------
if ~exist('option')
    option = 'cd';
end
%--------------------------------------------------------------------------

%-SPEED DIAL---------------------------------------------------------------
if topic == 0
    topic = 'hellfiles';

elseif topic == 1
    topic = 'EllipseResearch';

elseif topic == 11
    topic = 'newResearch';

elseif topic == 2
    topic = 'LineResearch';

elseif topic == 3
    topic = 'Drifters';

elseif topic == 4
    topic = 'IceExperiments';

end
%--------------------------------------------------------------------------

%-TEXT INPUTS--------------------------------------------------------------
switch topic
    %my custom files
    case 'hellfiles'
        directory = '/Users/helenaschreder/Documents/MATLAB/hellfuncs';

    %research
    case 'EllipseResearch'
        directory = '/Users/helenaschreder/Desktop/UW/Ice/TG-Ellipse';

    %new version of research
    case 'newResearch'
        directory = '/Users/helenaschreder/Desktop/UW/Ice/Ellipse-Sims';

    case 'LineResearch'
        directory = '/Users/helenaschreder/Desktop/UW/Ice/Line-TGV';

    case 'Drifters'
        directory = '/Users/helenaschreder/Desktop/UW/Lab Things/Drifters 2024';

    % ice particle tracking experiments with K&I
    case 'IceExperiments'
        directory = '/Users/helenaschreder/Desktop/UW/Ice/ice_experiments';

    %michelle particle tracking code
    case 'ParticleCode'
        directory = '/Users/helenaschreder/Documents/MATLAB/ParticleTracking';

    % chaos (AMATH 502)
    case 'chaos'
        directory  = '/Users/helenaschreder/Desktop/UW/Chaos';
    case 'lastchaos'
        directory  = '/Users/helenaschreder/Desktop/UW/Chaos';
        subdirectory = '*_AMATH502';

    % AMATH 581
    case 'amath582'
        directory  = '/Users/helenaschreder/Desktop/UW/AMATH582';
    case 'lastamath582'
        directory  = '/Users/helenaschreder/Desktop/UW/AMATH582';
        subdirectory = '*_AMATH582';

    % AMATH 581
    case 'amath581'
        directory  = '/Users/helenaschreder/Desktop/UW/AMATH 581';
    case 'lastamath281'
        directory  = '/Users/helenaschreder/Desktop/UW/AMATH 581';
        subdirectory = '*_AMATH581';

    % OCEAN 510
    case 'ocean'
        directory = '/Users/helenaschreder/Desktop/UW/OCEAN 510';
    case 'lastocean'
        directory  = '/Users/helenaschreder/Desktop/UW/OCEAN 510';
        subdirectory = '*_OCEAN510';

    otherwise
        error('bad input')
end
%--------------------------------------------------------------------------

%SET DIRECTORY-------------------------------------------------------------
switch option
    case 'addpath'
        addpath(directory)
        fprintf('%s added to path\n',directory)

    case 'cd'
    cd(directory)
    
    % if subdirectory is requested
    if exist("subdirectory","var")
        % keyboard
        A = dir(subdirectory); %folder in that directory
        [~,last] = max(datetime({A.date})); %last edited folder
        cd(fullfile(directory, A(last).name)) %open that
    end
end
    
%--------------------------------------------------------------------------
