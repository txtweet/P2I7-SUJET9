%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
% Fonction qui transforme deux coordonn�es cart�siennes
% en coordonn�es cylindriques
function [R,theta]=ChangeCoordEnCyl(x,y)
R=sqrt(x.^2+y.^2);
theta=arctan(y/x);
end