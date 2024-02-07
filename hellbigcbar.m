function c = hellbigcbar(fignum,varargin)

% 'BigColorBar': creates a big color bar out of subplots. Must specify a
%                subsize that includes axes for the colorbar. e.g. if you
%                want subplots size 320 and a colorbar on the right, input
%                a subsize of 330.
%       After calling it, specify other things in a cell:
%       'location': north, south, east, or west
%       'title': title for colorbar
%       'limits': [lower limit, upper limit]
%       Useage: 'BigColorBar',{'location','east','title','your title','limits',[0,10]}
% EXAMPLE USAGE:
% hellfig(1,'SubSize',220)
% hellbigcolorbar(1,'location','east','title','my title','limits',[1,2])

bcbtitlein=false;
bcblimsin=false;

% find the number of columns and rows on existing figure
h=figure(fignum);
N=numel(h.Children);
for n = 1:N
    pos1(n) = h.Children(n).Position(1);
    pos2(n) = h.Children(n).Position(2);
end
Ncols = numel(unique(pos1));
Nrows= numel(unique(pos2));
Nsub = Ncols*Nrows;

%cannot run if only one subplot
if Nsub == 1
    error('To create a big color bar, please input specify a subplot amount greater than 1.');
end

%warning if only two subplots
if Nsub == 2
    warning('With only 2 subplots, making a regual colorbar is recommended')
end


%parse inputs
args=varargin;
for ibcb=1:2:numel(args)
    switch args{ibcb}
        case 'location'
            switch args{ibcb+1}
                case 'north'
                    if Nrows<2;error('For a north big color bar plase specify a subsize with 2 or more rows.');end
                    bcbvec=1:Ncols;
                case 'south'
                    if Nrows<2;error('For a south big color bar plase specify a subsize with 2 or more rows.');end
                    bcbvec=Nsub-Ncols+1:Nsub;
                case 'east'
                    if Ncols<2;error('For an east big color bar plase specify a subsize with 2 or more columns.');end
                    bcbvec=Ncols:Ncols:Nsub;
                case 'west'
                    if Ncols<2;error('For a west big color bar plase specify a subsize with 2 or more columns.');end
                    bcbvec=1:Ncols:Nsub;
                otherwise 
                    if Ncols<2;error('Automatically chose east for location but you dont have enough subplots. fix this.');end
                    bcbvec=Ncols:Ncols:Nsub;
            end

        case 'title'
            bcbtitlein=true;
            bcbtitle = args{ibcb+1};

        case 'limits'
            bcblimsin=true;
            bcblims=args{ibcb+1};
    end

end

try 
    subplot(Nrows,Ncols,bcbvec)
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