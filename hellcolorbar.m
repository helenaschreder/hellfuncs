
function c=hellcolorbar(cvec,ticklabs,labtext)
% make a colorbar where the colors are discrete and the text labels are
% centered on the colors
% INPUTS
% cvec: colormap/vector (typically <256)
% ticklabs: tick labels, as a string or cell
% labtext: (optional) label for color bar

%create color bar
c=colorbar;

%add color map
colormap(cvec)

%sets ticks to be centered on the colors
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
