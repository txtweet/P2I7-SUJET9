%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
% Fonction qui transforme deux coordonnées cylindriques
% en coordonnées cartésiennes
function [x,y]= ChangeCoordEnCart (r,theta)
x=r.*cos(theta);
y=r.*sin(theta);
end