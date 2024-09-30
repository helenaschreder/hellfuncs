
function eplt = hellerror(x,y,e,type,pltspecs)
% x,y: data
% e: error. if you have +/-, input as two columns [-,+].
% type: 'lines', 'fill', 'bars'
% pltspecs: plotting specificaitons. Will default to things I like. 
% note: there are some defaults that you can't change. i.e. removes fill
% edge color and bar linestyle
% OUTPUT:
% eplt: plot object for the error. 

% rearrange things
x = x(:);
y = y(:);

% fix size 
[m,i] = min(size(e));

% checks
if numel(size(e))>2
    error('your error is more than 2D? idk what to do about that.')
end

% make columns
if i==1
    e = transpose(e);
end

% make two columns
if m==1
    e = [-e,e];
elseif m>2
    error('something wacky is happening.')
end

% plot
switch type
    case 'lines'
        if ~exist("pltspecs");pltspecs = {'k--'};end
        eplt(2) = plot(x,y+e(:,1),pltspecs{:});
        eplt(1) = plot(x,y+e(:,2),pltspecs{:});

    case 'fill'
        if ~exist("pltspecs");pltspecs = {'FaceAlpha',.2};end
        eplt = fill([flip(x);(x)],[flip(y+e(:,1));(y+e(:,2))],'m','EdgeColor','none',pltspecs{:});

    case 'bars'
        if ~exist("pltspecs");pltspecs = {'Color','k'};end
        eplt = errorbar(x,y,e(:,1),e(:,2),'LineStyle','none',pltspecs{:});
end

end