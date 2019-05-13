%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
% Fonction qui transforme deux coordonnées cartésiennes
% en coordonnées cylindriques
function [R,theta]=ChangeCoordEnCyl(x,y)
R=sqrt(x.^2+y.^2);
theta=arctan(y/x);
end