

function hellgif(filename,i,varargin)
% filename: file name, do NOT include '.gif'
% i: for loop index, needed to tell what first frame is
% i think if you dont enter anything for varargin it'll default to all
% framse and a pause time of 0.1
% optional:
% 'FrameNum': number of frames desired
    % time between frames defaults to 0.1;
% 'Pause': amount of time between frames
% 'Time': total amount of time you want the animation
    % defaults to using all frames
% 'Max': max amount of frames, REQUIRED with 'FrameNum' or 'Time'

%{ 
EXAMPLE CALLING:

for i=1:N
    plot(...)
    hellgif('mygif',i,varargin)
end

%}

%--INITIALIZE------------
framesin = false;
pausein = false;
timein = false;
maxin = false;
allframes = true;
%------------------------

%--PARSE INPUT-----------
if ~isempty(varargin) %|| ~isempty(varargin{1})
    for j=1:2:length(varargin)
        switch varargin{j}
    
            %makes an animation with a specificed number of frames
            case 'FrameNum'
                framesin = true;
                frameamnt = varargin{j+1};
    
            %Pause time
            case 'Pause'
                pausein = true;
                pausetime = varargin{j+1};
    
            % total time for gif
            case 'Time'
                timein = true;
                totaltime = varargin{j+1};
    
            %max amount of frames matlab will plot
            %REQUIRED with 'FrameNum' or 'Time'
           case 'Max'
                maxin = true;
                maxframes = varargin{j+1};
        
        end
    end
else
    pausetime=0.1;
end
%------------------------

%-CHECKS-----------------
%checking that max # of frames in input with 'FrameNum' or 'Time'
if ~maxin
    if timein && pausein %can do just these and itll be find
    else
    if framesin || timein
    error("Include the maximum # of loops your code will run through when using 'FrameNum' or 'Time' (e.g. 'Max',100)")
    end
    end
end

%making sure not all things are entered
if pausein && framesin && timein
    error('Cannot specify all things. Choose one or two.')
end
%------------------------

%..CALCULATING THINGS......................
%--TIME SPEC-------------
if timein 
    if pausein %uses all frames
        allframes = false;
        maxframes = round(totaltime/pausetime);
        framesin = true;
    elseif framesin
        pausetime = totaltime/frameamnt;
    else 
        pausetime = totaltime/maxframes;
    end
end
%------------------------

%--FRAME # SPEC----------
if framesin
    allframes = false;
    gfindx = round(linspace(1,maxframes,frameamnt));
    if ~pausein;pausetime=0.1;end
end
%------------------------

% %--TIME & FRAME #--------
% if framesin && timein
%     pausetime = totaltime/maxframes;
% end
% %------------------------
%..........................................


%--MAKE GIF---------------
if allframes || sum(i==gfindx) 

frame = getframe(gcf);
img =  frame2im(frame);
[img,cmap] = rgb2ind(img,256);
if i == 1
    imwrite(img,cmap,[filename '.gif'],'gif','LoopCount',Inf,'DelayTime',pausetime);
else
    imwrite(img,cmap,[filename '.gif'],'gif','WriteMode','append','DelayTime',pausetime);
end
pause(pausetime)
end
%------------------------
