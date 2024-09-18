

function axhandles = hellmargins(fignum,mgno,mgni,sizeRows,sizeCols)
% function which will maximize space on figure by adjusting subplot
% positions
% will automatically make all subplots the same size. 
% specify sizeRows and sizeCols to make sizes unique. These should be input
% as a fraction of 1. 
% NOTE: cannot call this like subplot though. must call as axhandles

% find the number of columns and rows on existing figure
fig=figure(fignum);
axhandles = findall(fig, 'Type', 'axes');
N = numel(axhandles);
n=1;
for i = 1:N
    pos1(n) = fig.Children(i).Position(1);
    pos2(n) = fig.Children(i).Position(2);
    n=n+1;
end
Nc = numel(unique(pos1));
Nr= numel(unique(pos2));

% find row sizes
if ~exist('sizeRows') || numel(sizeRows)==0
    Fracrow = ones(Nr,1)/Nr;
else

    % check for input errors
    error_msg = { ...
    'Input for sizeRows must sum to 1' ...
    'sizeRows must be the same length the number of rows in your figure.'};
    is_error = false(1,numel(error_msg));

    if abs(sum(sizeRows)-1)>1e-5;is_error(1) = true;end
    if Nr ~= numel(sizeRows);is_error(2) = true;end

    % display error messages
    if any(is_error)
        error_msg = ['The following error(s) occurred:' error_msg(is_error)];
        error(sprintf('%s\n',error_msg{:}));
    end

    % if all is well assign fracrow
    Fracrow = sizeRows(:);
end

% find Column sizes
if ~exist('sizeCols') || numel(sizeCols)==0
    Fraccol = ones(Nc,1)/Nc;
else

    % check for input errors
    error_msg = { ...
    'Input for sizeCols must sum to 1' ...
    'sizeCols must be the same length the number of rows in your figure.'};
    is_error = false(1,numel(error_msg));

    if abs(sum(sizeCols)-1)>1e-5;is_error(1) = true;end
    if Nc ~= numel(sizeCols);is_error(2) = true;end

    % display error messages
    if any(is_error)
        error_msg = ['The following error(s) occurred:' error_msg(is_error)];
        error(sprintf('%s\n',error_msg{:}));
    end

    % if all is well assign fracrow
    Fraccol = sizeCols(:)';
end

%space you can put plots on (exculudes margins)
SpaceCol = (1 - mgno*2 - mgni*(Nc-1));
SpaceRow = (1 - mgno*2 - mgni*(Nr-1));

% size of each subplot
W = SpaceCol * Fraccol;
H = SpaceRow * Fracrow;

% now set the plot sizes
k=1;
for ir = 1:Nr
    for ic = 1:Nc
        % define the positions
        Ypos = mgno + mgni*(Nr-ir) + sum(H(ir+1:Nr));
        Xpos = mgno + mgni*(ic-1) + sum(W(1:ic-1));
        axhandles(k).Position = [Xpos,Ypos,W(ic),H(ir)];
        k=k+1;
    end
end
