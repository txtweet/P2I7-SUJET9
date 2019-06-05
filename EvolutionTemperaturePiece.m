%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%
%%% Fonction EvolutionTemperaturePiece %%%
% Cette fonction permet l'affichage de l'�volution de la temp�rature de la
% pi�ce en fonction du temps. Ainsi, nous consid�rons un unique noeud d'air
% parmi tous ceux repr�sent�s dans la matrice Tair : sa temp�rature est la
% moyenne de la temp�rature de tous les noeuds. Le but est de constater
% comment la temp�rature de la pi�ce �volue pendant le fonctionnement du
% plancher chauffant.
% Les param�tres sont : Tair la matrice contenant tous les noeuds d'air
%                           avec leur temp�rature associ�e
%                       T la matrice contenant ...
% Les variables renvoy�es sont : 
% Ces variables prennent la valeur : 
function EvolutionTemperaturePiece(Taffichage)
global dt
figure()
plot(dt,Taffichage);
title('Evolution de la temp�rature de la pi�ce en fonction du temps de fonctionnement du plancher chauffant');
xlabel('Discr�tisation temporelle de la dur�e de fonctionnement du plancher chauffant');
ylabel('Temp�rature de la pi�ce (moyenne des noeuds d air) en kelvin');
end