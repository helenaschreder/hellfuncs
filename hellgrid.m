
function [xcell,ycell,numg,datacell,stats]=hellgrid(xcoords,ycoords,xvec,yvec,varargin)
% Schreder, 8/29/23
%[xcell,ycell,numg,datacell,stats]=hellgrid2(xcoords,ycoords,xvec,yvec,varargin)
%
% MANDATORY INPUTS:
% xcoords & ycoords: coordinates you want to descretize based on
% xvec & yvec: edges of the bins you would like
% 
% VARARGIN INPUTS:
% 'ZData': 2D matrix where each point corresponds to xcoords and ycoords;
% to separate multiple data sets input as a 3D matrix where each mat in the
% third dimension is a new set of data.
% 
% 'EmptyEdge': output grid will normally be
% size(length(xvec)-1,length(yvec)-1), this will make the size one more in
% each direction (helpful for funcitons like imagesc).
% 
% 'Stats': calculates statistics for each cell of data. input as cell
% with strings;
%       -'BootStrap',N: mean from bootstrap and 95% confidence interval
%       -'Mean': regular mean
%       -'RMS': root mean squared
%       -'STD': standard deviaton
% 
% OUTPUTS:
% xcell & ycell: cells with each point in bin
% numg: number of points in each cell
% datacell: if Z data is input, cell with data points in each bin. third
% dimension is for each set of Z data
% stats: structure where each row corresponds to different data set (i.e.
% 1-> x, 2->y, 3...-> optional Z data).
% 
% NOTE: stats will not be calculated if there are less than 2 points in a
% cell

%--------------------------------------------------
zdatain=false;
znum=0;
statsout=false;
ee=-1;
calc_BS=false;
calc_mean=false;
calc_rms=false;
calc_std=false;
stats=[];
%--------------------------------------------------

%-PARSE INPUTS-------------------------------------
args=varargin;
for i=1:2:numel(args)
switch args{i}

    case 'ZData'
        zdatain=true;
        zdata=args{i+1};
        znum = size(zdata,3);

    case 'EmptyEdge'
        ee=args{i+1}-1;

    case 'Stats'
        statsout=true;
        statnames=args{i+1};

        %parse stats inputs
        for ic=1:numel(statnames)
        switch statnames{ic}
            case 'BootStrap';calc_BS=true;
                N=statnames{ic+1};
            case 'Mean';calc_mean=true;
            case 'RMS';calc_rms=true;
            case 'STD';calc_std=true;
        end
        end

end
end
%--------------------------------------------------

%-INITIALIZE MATS----------------------------------
xcell=cell(numel(yvec)+ee,numel(xvec)+ee);ycell=xcell;
if zdatain
    datacell = cell(numel(yvec)+ee,numel(xvec)+ee,znum);
else
    datacell=[];
end
numg = zeros(numel(yvec)+ee,numel(xvec)+ee);
%--------------------------------------------------

%-LOOP---------------------------------------------
for i=1:numel(yvec)-1 %each row

    %top and bottom limits
    yllim = yvec(i);
    yulim = yvec(i+1);
    inrow = ycoords >= yllim & ycoords <= yulim;

    for j=1:numel(xvec)-1 %each column

        %left and right limits
        xllim = xvec(j);
        xulim = xvec(j+1);
        incol = xcoords >= xllim & xcoords <= xulim;

        %data in the cell
        incell = inrow+incol == 2;
        xcell{i,j}={xcoords(incell)};
        ycell{i,j}={ycoords(incell)};

        for iz=1:znum
        %separates input z data
            zztemp=zdata(:,:,iz);
            datacell{i,j,iz} = {zztemp(incell)};
        end

        %number of points in each cell
        numg(i,j) = sum(incell(:));

    end
end
%--------------------------------------------------

%-STATISTICS---------------------------------------
if statsout
for zs=1:2+znum %loops through each data set

    %switching data matrix
    if zs==1
        data=xcell;
    elseif zs==2
        data=ycell;
    else
        data=datacell(:,:,zs-2); %extra data
    end
    
    %looping through each cell
    for i=1:size(numg,1) %each row
        for j=1:size(numg,2)

            %if there aren't two data points in a cell makes it NaN
            if numel(cell2mat(data{i,j}))<2
                dataround=[NaN,NaN];
            else
                dataround = cell2mat(data{i,j});
            end

            %bootstrapping
            if calc_BS
                boots=bootstrp(N,@mean,dataround);
                stats(zs).BootMean(i,j) = mean(boots(:));
                stats(zs).BootConfidence1(i,j) = boots(floor(0.05*N));
                stats(zs).BootConfidence2(i,j) = boots(ceil(0.95*N));
            end

            %regular mean
            if calc_mean
                stats(zs).Mean(i,j)=mean(dataround,'all');
                %maybe do nanmean
            end

            %std
            if calc_std
                stats(zs).STD(i,j)=std(dataround,0,'all');
            end

            %root mean squared
            if calc_rms
                 stats(zs).RMS(i,j)=sqrt(mean((dataround).^2));
            end

        end
    end
end %dataset loop
end
%--------------------------------------------------

% zerosinmat = numg==0;
% rmsg(zerosinmat) = NaN;
% meang(zerosinmat) = NaN;
