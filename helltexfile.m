function helltexfile(parts, subparts)
% function to make tex file for my homework
% inputs:
% parts: # problems in set
% subparts: vector length(parts) with the number of subparts in each
% problem is listed
% example:
% problem set with 1 (a,b,c); 2 (a,b,c,d,e,f); 3
% fileout = helltexfile(3,[3,6,0])

%check input
if numel(subparts)~=parts
    error('The subpart input vector must be the length of the number of parts requested')
end

if sum(subparts>26)~=0
    error('You have more subparts than there are letters of the alphabet, did not plan for that')
end

% location to save file to
destination = '/Users/helenaschreder/Desktop/';
filename = 'helltext.txt';
fname = fullfile(destination,filename);

% letters to be printed
alphabet = char(97:97+25);
ALPHABET = char(65:65+25);

% box definitions
begin_darkbox = '\begin{darkbox}';
end_darkbox = '\end{darkbox}';
begin_lightbox = '\begin{lightbox}';
end_lightbox = '\end{lightbox}';

% blank
blanktext = '...';

% width of tex file
cw = 64;

% so first entry overwrites
first = 1;

for i1 = 1:parts

    % main part
    header1 = ['%' repmat(num2str(i1),[1,cw-2]) '%'];
    header2 = ['%' repmat('-',[1,(cw-12)/2]) ' Problem ' num2str(i1) ' ' repmat('-',[1,(cw-12)/2-1]) '%'];
    header3 = header1;
    footer = header1;
    f = sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n',header1,header2,header3,begin_darkbox,blanktext,end_darkbox,footer);
    savetext(f,first,fname)
    first = 0;

    % sub  parts
    if subparts(i1)~=0
    for i2 = 1:subparts(i1)
        header1 = ['%' repmat(num2str(i1),[1,cw-2]) '%'];
        header2 = ['%' repmat('-',[1,(cw-12)/2-1]) ' Problem ' [num2str(i1) alphabet(i2)] ' ' repmat('-',[1,(cw-12)/2-1]) '%'];
        header3 = ['%' repmat(ALPHABET(i2),[1,cw-2]) '%'];
        footer = ['%' repmat([num2str(i1) ALPHABET(i2)],[1,(cw-2)/2]) '%'];
        f = sprintf('%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n',header1,header2,header3,begin_lightbox,[alphabet(i2) '. '],end_lightbox,footer);  
        savetext(f,first,fname)
    end
    end
end

%% save text to file
function savetext(f,first,fname)
    if first
        writelines(f,fname,"WriteMode","overwrite");
    else
        writelines(f,fname,"WriteMode","append");
    end
end

end

