%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
% Fonction qui transforme deux coordonn�es cylindriques
% en coordonn�es cart�siennes
function [x,y]= ChangeCoordEnCart (r,theta)
x=r.*cos(theta);
y=r.*sin(theta);
end