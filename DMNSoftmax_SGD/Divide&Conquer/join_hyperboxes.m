function [newListH, newListC] = join_hyperboxes(ListH,ListC)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   ListH is a matrix that contains the hyperboxes to classify 
%         training samples
%   ListC ia a vector that contains the corresponding class for 
%         hyperboxes in ListH

% Output:
%   newListH is a matrix that contains the new hyperboxes to classify 
%         training samples
%   newListC ia a vector that contains the corresponding class for 
%         hyperboxes in newListH

% Important note: the global variable "tol" avoids infinity recursions due 
%       to the small numerical errors 
global tol

N = size(ListH,2)/2;
newListH = [];
newListC = [];
while ~isempty(ListH)
    % Take the first hyperbox in ListH
    Wmin = ListH(1,1:N);
    Wmax = ListH(1,N+1:end);
    C = ListC(1);
    % Find a hyperbox that shares a hyperplane with the first hyperbox
    flagU = 0;
    for i=2:size(ListH,1) 
        if C == ListC(i) 
            % Search for only one change between hyperboxes
            COND1 = (abs(Wmin - ListH(i,1:N)) < tol); 
            imin = find(COND1 == 0);
            COND2 = (abs(Wmax - ListH(i,N+1:end)) < tol); 
            imax = find(COND2 == 0);
            if (length(imin) == 1) && (length(imax) == 1) 
                COND3 = (imax == imin);
            else
                COND3 = 0;
            end
            if COND3 % Are they aligned in only one dimension?
                COND4 = (abs(Wmax(imin)-ListH(i,imin)) < tol);
                COND5 = (abs(ListH(i,N+imin)-Wmin(imin)) < tol);
                if COND4 || COND5 % Are they attached?
                    if COND4
                        UWmin = Wmin;
                        UWmax = ListH(i,N+1:end);
                    else
                        UWmin = ListH(i,1:N);
                        UWmax = Wmax;
                    end
                    newListH = [newListH; [UWmin UWmax]];
                    newListC = [newListC; C];
                    % Remove old hyperbox
                    ListH([1 i],:) = [];
                    ListC([1 i]) = [];
                    flagU = 1;
                    break
                end
            end
        end
    end
    if flagU == 0 % There was no union?
        newListH = [newListH; [Wmin Wmax]];
        newListC = [newListC; C];
        ListH(1,:) = [];
        ListC(1) = [];
    end
end