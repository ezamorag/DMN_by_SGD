function [ListH, ListC] = DivideAndConquer(H,P,T,Ld)
% Author: Erik Zamora, ezamora1981@gmail.com

% Input:
%   H is the hyperbox
%   P is a matrix NxQtrain containing the training samples 
%   T is a vector 1xQtrain containing the clases for training samples
%   Ld is the depth level for hyperbox H

% Output:
%   ListH is a matrix NHx(2*N) that contains the hyperboxes to classify 
%         training samples
%   ListC ia a vector NHx1 that contains the corresponding class for 
%         hyperboxes in ListH

global L E0

% Percentage error inside hyperbox H is calculated
mo = mode(T);
error_porc = length(find(T ~= mo))/length(T);

if error_porc <= E0    % Stop recursions?
    ListH = H';
    ListC = mo;
else                                 % Begining a new recursion level 
    L = max(L,Ld + 1);
    ListH = [];
    ListC = [];
    while ~isempty(P)                
        Hsub = generate_subhyperbox(H,P(:,1));
        [PHsub, THsub, P, T] = extract_samples(Hsub,P,T);
        [ListHsub, ListCsub] = DivideAndConquer(Hsub,PHsub,THsub,Ld + 1);
        ListH = [ListH; ListHsub];
        ListC = [ListC; ListCsub];
    end
    [ListH, ListC] = join_hyperboxes(ListH,ListC); 
end