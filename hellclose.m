function hellclose
% function to close all of the files not in the current folder
% note: does not close newly created files (e.g. untitledX.m)

% all open files
A = matlab.desktop.editor.getAll;

% current folder
currentfolder = pwd;

% check if the file is in this folder or in none (e.g. not yet saved)
toclose=zeros(numel(A),1);
for i = 1:numel(A)
    a=strfind(A(i).Filename,'/');
    if ~isempty(a) %in current folder
        toclose(i) = ~strcmp(currentfolder,A(i).Filename(1:a(end)-1));
        % infolder(i) = contains(A(i).Filename,currentfolder); %to keep things open from subfolders
    else %untitled
        toclose(i) = false;
    end
end
toclose = logical(toclose);

% find just the name of the file
n=1;filenames=cell(1,sum(toclose));
for i = (find(toclose==1))'
    a=strfind(A(i).Filename,'/');
    filenames{n} = A(i).Filename(a(end)+1:end);
    n=n+1;
end

if sum(toclose)==0
    fprintf('Nothing to close.\n')
else

% tell the user which files were closed
% fprintf('closed: %0s\n',A(toclose).Filename) %with directory
fprintf('closed: %0s\n',filenames{:}) %without directory 

%close files
close(A(toclose))

end
