function helldir(topic)
% opens my commonly used folders.
% 
% HELLFILES
%   0 or 'hellfiles'
% RESEARCH
%   1, 'research', or 'rees'
% OCEANOGRAPHY
%   2 or 'ocean'
%   21 or 'lastocean' to open last edited folder
% AMATH
%   3 or 'amath'
%   31 or 'lastamath' to open last edited folder

%some alternate inputs for research
if topic ==1
    topic = 'research';
elseif strcmp(topic,'rees')
    topic = 'research';

%alternate inputs for ocean
elseif topic == 2
    topic = 'ocean';
elseif topic == 21
    topic = 'lastocean';

%alternate inputs for ocean
elseif topic == 3
    topic = 'amath';
elseif topic == 31
    topic = 'lastamath';

% hellfiles 
elseif topic ==0
    topic = 'hellfiles';
end

%main inputs
switch topic

    %my custom files
    case 'hellfiles'
        directory = '/Users/helenaschreder/Documents/MATLAB/hellfuncs';

    %research
    case 'research'
        directory = '/Users/helenaschreder/Desktop/UW/Ice/TG-Ellipse';

    %general ocean
    case 'ocean'
        directory = '/Users/helenaschreder/Desktop/UW/OCEAN 510';

    %general amath
    case 'amath'
        directory  = '/Users/helenaschreder/Desktop/UW/AMATH 581';

    %last edited ocean
    case 'lastocean'
        directory  = '/Users/helenaschreder/Desktop/UW/OCEAN 510';
        subdirectory = '*_OCEAN510';

    %last edited amath
    case 'lastamath'
        directory  = '/Users/helenaschreder/Desktop/UW/AMATH 581';
        subdirectory = '*_AMATH581';

    otherwise
        error('bad input')
end

cd(directory)

% set directory
if exist("subdirectory","var")
    % keyboard
    A = dir(subdirectory); %folder in that directory
    [~,last] = max(datetime({A.date})); %last edited folder
    cd(fullfile(directory, A(last).name)) %open that
end