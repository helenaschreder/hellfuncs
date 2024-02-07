
function c=helldisccbar(cvec,ticklabs,labtext,c)
% make a colorbar where the colors are discrete and the text labels are
% centered on the colors
% INPUTS
% cvec: colormap/vector (typically <256)
% ticklabs: tick labels, as a string or cell
% labtext: (optional) label for color bar
% c: existing colorbar

%create color bar
if ~exist("c")
    c=colorbar;
end

%add color map
colormap(cvec)

%sets ticks to be centered on the colors
clim([0,1])
cc=linspace(0,1,numel(ticklabs)+1);
cc=cc(1:end-1) + (cc(2)-cc(1))/2;
c.Ticks=cc;

%removes tick lines
c.TickDirection = 'none';

%add tick labels for each color
c.TickLabels = ticklabs;

%color bar title (if requested)
if exist("labtext")
    c.Label.String = labtext;
end

%formatting
c.TickLabelInterpreter = 'latex';
c.Label.Interpreter = 'latex';
c.Label.FontSize = 14;
