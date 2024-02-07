
function c=cuntycolorbar(cvec,ticklabs,labtext)
% make a colorbar where the colors are discrete and the text labels are
% centered on the colors

c=colorbar;
colormap(cvec)
cc=linspace(0,1,numel(ticklabs)+1);
cc=cc(1:end-1) + (cc(2)-cc(1))/2;
c.Ticks=cc;
c.TickLabels = ticklabs;
c.TickLabelInterpreter = 'latex';
c.Label.Interpreter = 'latex';
if exist("labtext")
c.Label.String = labtext;
end
c.Label.FontSize = 14;
c.TickDirection = 'none';