function NH = dendritenumber(dendrite)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   dendrite is a structure that constains the same hyperboxes in ListH
%       There is a dendrite per class, and each dendrite can have different
%       number of hyperboxes for that class. 

% Output:
%   NH is the total number of hyperboxes 

NH = 0;
S = numel(dendrite);
for i=1:S
    NH = NH + size(dendrite(i).W,2);
end
