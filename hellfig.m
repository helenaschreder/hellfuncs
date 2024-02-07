
function [fig,cmp,cvec,cbar]=hellfig(num,varargin)
%HELLFIG
% OUTPUTS:
% fig: fig handle
% cmp: colormap matrix
%
% INPUTS:
% num: # figure. input 0 to make no figure (good for getting colormap)
% 'Aspect': any nonzero 1D input = 1:1, or put in a 2D or 3D vector for
%           another aspect ratio
% 'BigColorBar': creates a big color bar out of subplots. Must specify a
%                subsize that includes axes for the colorbar. e.g. if you
%                want subplots size 320 and a colorbar on the right, input
%                a subsize of 330.
%       After calling it, specify other things in a cell:
%       'location': north, south, east, or west
%       'title': title for colorbar
%       'limits': [lower limit, upper limit]
%       Useage: 'BigColorBar',{'location','east','title','your title','limits',[0,10]}
% 'ColorsVec': input a # after this and it will give you an Nx3 matrix
% where each row is a different color from the colormap% 'Fabio': sets colormap using fabio colormaps
% 'FigDim': [width,height]. To leave as default use 0 or NaN
% 'FigPos': [xpos,ypos,width,height]. To leave as default use NaN
% 'FontSize': fontsize, default is 12pt
% 'Grid': puts grid on each subplot. Can be 'on','off','minor'
% 'Interpreter': e.g. 'latex', 'none'
% 'InvisAx': removes box and numbers from axes, any input after
% 'LogScale': turns on log scale, [xaxis,yaxis] set 1 and 0
% 'SGtitle': Subplot group title
% 'SubSize': three digit number with amount of subplots
% 'Slims': xlim and ylim are the same, input a matrix with at least two
%          numbers to set limits
% 'Xlims': xlimits applied to each subplot
% 'Ylims': ylimits applied to each subplot
% 
% OTHER:
% handy line for saving vector files:
% saveas(gcf,[cd '/Figures/' name],'epsc')

%defaults
FontSize=12; 
SubNum=1; 
Aspectin=false;
InvisAx=false;
LogScaleY=false;
LogScaleX=false;
InterpSpec=false;
SLimsSpec=false;
ylimsin=false;
xlimsin=false;
sgtitlein=false;
gridin=false;
bigcolorbar=false;
colorvecrequested=false;
centeraxis=false;

%default outputs 
fig=[];
cmp=[];
cvec=[];
cbar=[];


%----------CREATE FIGURE----------
if num~=0
    fig=figure(num);clf
    fig.Color='w';
    fig.Units="inches";
    makefig = true;
else
    makefig=false;
    fig = [];
end

%----------PARSE INPUTS----------
args=varargin;
for i=1:2:numel(args)
    switch args{i}
        case 'Aspect'
            Aspect=args{i+1};
            if args{i+1}==0;Aspectin=false;
            else
                if length(Aspect)==2;assdims = [Aspect(1),Aspect(2),1];
                elseif length(Aspect)==3;assdims = Aspect;
                else;assdims=[1,1,1];
                end
                Aspectin=true;
            end

        case 'BigColorBar'
            bigcolorbar=true;
            bcbspecs=args{i+1};

        case 'CenterAx'
            centeraxis=true;        
        
        case 'ColorsVec'
            colorvecrequested=true;
            colorvecparts=args{i+1};

        case 'Fabio'
            FabioName=args{i+1};
            load('fabiocmps.mat','fabiocmps') %must have this file in the same folder
            cmp = fabiocmps.(FabioName);
            colormap(cmp)

        case 'FigDim'
            if makefig
            FigDim=args{i+1};
            FidgimNS=isnan(FigDim) + (FigDim==0);
            if ~FidgimNS(1);fig.Position(3)=FigDim(1);end
            if ~FidgimNS(2);fig.Position(4)=FigDim(2);end
            end

        case 'FigPos'
            if makefig
            figPos=args{i+1};
            temppos = figPos;
            temppos(isnan(figPos))=0;
            fig.Position=fig.Position.*(isnan(figPos))+temppos;
            end

        case 'FontSize'
            FontSize=args{i+1};

        case 'Grid'
            gridin=true;
            gridtype=args{i+1};

        case 'Interpreter'
            InterpName=args{i+1};
            set(0,'defaulttextinterpreter',InterpName)
            InterpSpec=true;

        case 'InvisAx'
            InvisAx=true;

        case 'LogScale'
            LogScale=args{i+1};
            LogScaleX=LogScale(1);
            LogScaleY=LogScale(2);

        case 'SGtitle'
            sgtitlein=true;
            SGtitle=args{i+1};

        case 'Slims' %square X and Y lims
            slims=args{i+1};
            slims=[min(slims(:)),max(slims(:))];
            SLimsSpec=true;

        case 'SubSize'
            SubSize=args{i+1};
            SubRows=floor(SubSize/100);
            SubCols=floor((SubSize-SubRows*100)/10);
            SubNum=SubRows*SubCols;

        case 'Xlims'
            xlimsin=true;
            xlims=args{i+1};

        case 'Ylims'
            ylimsin=true;
            ylims=args{i+1};
    end
end
%------------------------------


%----------CREATE AXES----------
if makefig
for i=1:SubNum
    if SubNum>1;subplot(SubRows,SubCols,i);end
    hold on
    box on
    ax=gca;
    ax.FontSize=FontSize;
    if InterpSpec;ax.TickLabelInterpreter="latex";end
    if Aspectin;daspect(assdims);end
    if InvisAx;ax.XColor='none';ax.YColor='none';end
    if LogScaleY;ax.YScale='log';end
    if LogScaleX;ax.XScale='log';end
    if SLimsSpec;xlim(slims);ylim(slims);end
    if gridin;grid(gridtype); end
    if xlimsin;xlim(xlims);end
    if ylimsin;ylim(ylims);end
    if centeraxis;ax.XAxisLocation='origin';ax.YAxisLocation='origin';end
end
if sgtitlein;sgtitle(SGtitle);end
end
%------------------------------

%-COLOR VEC--------------------
if colorvecrequested
    cin=round(linspace(1,256,colorvecparts));
    cmp=colormap;
    cvec=cmp(cin,:);
end
%------------------------------

%--------BIG COLOR BAR---------
if bigcolorbar && makefig
    cbar = hellbigcbar(num,bcbspecs{:});
end 
%------------------------------

%save figure
% saveas(gcf,'/Users/helenaschreder/Desktop/UW/Turbulence/ME543, H3/Figures/prob4E','epsc')