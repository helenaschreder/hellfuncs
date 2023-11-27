
function [fig,cmp,colorvecs]=hellfig(num,varargin)
%HELLFIG
% OUTPUTS:
% fig: fig handle
% cmp: colormap matrix
%
% INPUTS:
% 'FigPos': [xpos,ypos,width,height]. To leave as default use NaN
% 'FigDim': [width,height]. To leave as default use 0 or NaN
% 'SubSize': three digit number with amount of subplots
% 'FontSize': fontsize, default is 12pt
% 'Aspect': any nonzero 1D input = 1:1, or put in a 2D or 3D vector for
%           another aspect ratio
% 'Fabio': sets colormap using fabio colormaps
% 'InvisAx': removes box and numbers from axes, any input after
% 'LogScale': turns on log scale, [xaxis,yaxis] set 1 and 0
% 'Interpreter': e.g. 'latex', 'none'
% 'Slims': xlim and ylim are the same, input a matrix with at least two
%          numbers to set limits
% 'Xlims': xlimits applied to each subplot
% 'Ylims': ylimits applied to each subplot
% 'SGtitle': Subplot group title
% 'Grid': puts grid on each subplot. Can be 'on','off','minor'
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
% where each row is a different color from the colormap
% 
% OTHER:
% handy line for saving vector files:
% saveas(gcf,[cd '/Figures/' name],'epsc')

%----------CREATE FIGURE----------
fig=figure(num);clf
fig.Color='w';
fig.Units="inches";

%----------PARSE INPUTS----------
args=varargin;

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

for i=1:2:numel(args)
    switch args{i}
        case 'FigPos'
            figPos=args{i+1};
            temppos = figPos;
            temppos(isnan(figPos))=0;
            fig.Position=fig.Position.*(isnan(figPos))+temppos;

        case 'FigDim'
            FigDim=args{i+1};
            FidgimNS=isnan(FigDim) + (FigDim==0);
            if ~FidgimNS(1);fig.Position(3)=FigDim(1);end
            if ~FidgimNS(2);fig.Position(4)=FigDim(2);end

        case 'SubSize'
            SubSize=args{i+1};
            SubRows=floor(SubSize/100);
            SubCols=floor((SubSize-SubRows*100)/10);
            SubNum=SubRows*SubCols;

        case 'FontSize'
            FontSize=args{i+1};

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

        case 'Fabio'
            FabioName=args{i+1};
            load('fabiocmps.mat','fabiocmps') %must have this file in the same folder
            cmp = fabiocmps.(FabioName);
            colormap(cmp)

        case 'LogScale'
            LogScale=args{i+1};
            LogScaleX=LogScale(1);
            LogScaleY=LogScale(2);

        case 'InvisAx'
            InvisAx=true;

        case 'Interpreter'
            InterpName=args{i+1};
            set(0,'defaulttextinterpreter',InterpName)
            InterpSpec=true;

        case 'Slims' %square X and Y lims
            slims=args{i+1};
            slims=[min(slims(:)),max(slims(:))];
            SLimsSpec=true;

        case 'Ylims'
            ylimsin=true;
            ylims=args{i+1};

        case 'Xlims'
            xlimsin=true;
            xlims=args{i+1};

        case 'SGtitle'
            sgtitlein=true;
            SGtitle=args{i+1};

        case 'Grid'
            gridin=true;
            gridtype=args{i+1};

        case 'BigColorBar'
            bigcolorbar=true;
            bcbspecs=args{i+1};

        case 'ColorsVec'
            colorvecrequested=true;
            colorvecparts=args{i+1};

    end
end
%------------------------------


%----------CREATE AXES----------
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
end
if sgtitlein;sgtitle(SGtitle);end
%------------------------------

%-COLOR VEC--------------------
if colorvecrequested
    cin=round(linspace(1,256,colorvecparts));
    cmp=colormap;
    colorvecs=cmp(cin,:);
end
%------------------------------

%--------BIG COLOR BAR---------
if bigcolorbar

bcbtitlein=false;
bcblimsin=false;

if SubNum==1;error('To create a big color bar, please input specify a subplot amount greater than 1.');end

    %parse inputs
    for ibcb=1:2:numel(bcbspecs)
        switch bcbspecs{ibcb}
            case 'location'
                switch bcbspecs{ibcb+1}
                    case 'north'
                        if SubRows<2;error('For a north big color bar plase specify a subsize with 2 or more rows.');end
                        bcbvec=1:SubCols;
                    case 'south'
                        if SubRows<2;error('For a south big color bar plase specify a subsize with 2 or more rows.');end
                        bcbvec=SubNum-SubCols+1:SubNum;
                    case 'east'
                        if SubCols<2;error('For an east big color bar plase specify a subsize with 2 or more columns.');end
                        bcbvec=SubCols:SubCols:SubNum;
                    case 'west'
                        if SubCols<2;error('For a west big color bar plase specify a subsize with 2 or more columns.');end
                        bcbvec=1:SubCols:SubNum;
                    otherwise 
                        if SubCols<2;error('Automatically chose east for location but you dont have enough subplots. fix this.');end
                        bcbvec=SubCols:SubCols:SubNum;
                end

            case 'title'
                bcbtitlein=true;
                bcbtitle = bcbspecs{ibcb+1};

            case 'limits'
                bcblimsin=true;
                bcblims=bcbspecs{ibcb+1};
        end

    end

    try 
        subplot(SubRows,SubCols,bcbvec)
    catch
        error('check that you entered correct location information.')
    end
    ax=gca;
    ax.Color='none';
    grid('off')
    ax.FontSize=12;
    ax.XColor='none';
    ax.YColor='none';
    c=colorbar;
    c.Position(3)=c.Position(3)*4;
    if bcbtitlein;c.Label.String=bcbtitle;end
    if bcblimsin;clim(bcblims);end

end %if bigcolorbar
%------------------------------

%save figure
% saveas(gcf,'/Users/helenaschreder/Desktop/UW/Turbulence/ME543, H3/Figures/prob4E','epsc')