%%%%%%%%%%%%%%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Obtention de l'indice k afin de remplir les matrices A, B et T %%%
%
% Les param�tres sont :
% La variable renvoy�e est :
function coord=index(i,j)
global noeudsVert
coord = (i-1)*noeudsVert+j;
end