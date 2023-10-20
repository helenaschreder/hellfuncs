 

function run_hellcheckin

% -=- LABELS -=-
%x and y labels (west & south are - , north & east are +)
%ideally you make the negative emotion - and positive one +
tit_west='Stressed';
tit_east='At Ease';
tit_south='Inadequate';
tit_north='Capable';
tit_nsew={tit_north,tit_south,tit_east,tit_west};

% -=- FILE NAME AND PATH -=-
%file name: if unchanged it will create a text file with your input words
your_name='Schreder';
file_name=[your_name '_' tit_north '_' tit_south '_' tit_east '_' tit_west];

%file path: MUST CHANGE
directory='/Users/helenaschreder/Documents/MATLAB/hellmatfiles'; 

% -=- OTHER -=-
%round so that all your points are -1:0.05:1
snap_2nice_nums=true;

%number of days before today you'd like plotted
days_back=30;

% -=- FORMATTING -=-
%figure number
fig_num=80085;

%colors
color_fig='#FFCBC5';
color_ax='#FFF5F2';
color_a1='#5B516A'; %title, colorbar labels
color_a2='#1A5C71'; %boarder, x-y labels
colors={color_fig,color_ax,color_a1,color_a2};

%font (listfonts to see available)
font_name='Graphik'; 

hellcheckin(1,'AxTitles',tit_nsew,'Colors',colors,'DaysBack',14, ...
    'FigNum',80085,'FileName',file_name,'OnceADay',1,'FontName',font_name, ...
    'OnceADay',1)

end