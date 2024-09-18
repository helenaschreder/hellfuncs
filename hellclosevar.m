
function hellclosevar
% close all of the variable windows
% source: https://www.mathworks.com/matlabcentral/answers/345583-close-all-variable-editor-windows

desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
Titles  = desktop.getClientTitles;
for k = 1:numel(Titles)
   Client = desktop.getClient(Titles(k));     
   if ~isempty(Client) & ...
      strcmp(char(Client.getClass.getName), 'com.mathworks.mde.array.ArrayEditor')
      Client.close();
   end
end