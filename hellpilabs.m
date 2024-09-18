
function vs = hellpilabs(vec,set)
% INPUT
% vec: the vector you want labels for. ex. veec = -2*pi:pi/2:2*pi
% set: 2 element vector of 1 or 0. Will set your axes according to your
% inputs. e.g. [1,1] makes x and y 
% OUTPUT
% vs: labels based on your input 
% note: these labels are for latex interpreter
% TO DO:
% adjust so it somehow works with irrational numbers? Like if there's a
% sqrt(2) 

vp = vec/pi;
vs = cell(size(vp));

for  i=1:numel(vp)

    % zero
    if vp(i)==0
        vs{i} = '$0$';

    elseif vp(i)==1
        vs{i} = '$\pi$';

    elseif vp(i)==-1
        vs{i} = '$-\pi$';

    %integers
    elseif rem(vp(i),1)==0
        vs{i} = sprintf('$%1.0f%s$',vp(i),'\pi');

    % fraction
    else
        [num,den] = rat(abs(vp(i)));
        if num==1
            num=[];
        end
        ngps={'','-'};
        vs{i} = sprintf('$%s%s{%1.0f%s}{%1.0f}$',ngps{(vp(i)<0)+1},'\frac',num,'\pi',den);
    end

end

% set the ticks with the string you just made
if exist('set')
    ax = gca;
    if set(1)
        xlim([vec(1),vec(end)]);
        ax.XTick = vec;
        ax.XTickLabels = vs;
    end

    if set(2)
        ylim([vec(1),vec(end)]);
        ax.YTick = vec;
        ax.YTickLabels = vs;
    end

    if set(3)
        zlim([vec(1),vec(end)]);
        ax.ZTick = vec;
        ax.ZTickLabels = vs;
    end
end

end