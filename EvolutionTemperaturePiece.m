%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%
%%% Fonction EvolutionTemperaturePiece %%%
% Cette fonction permet l'affichage de l'évolution de la température de la
% pièce en fonction du temps. Ainsi, nous considérons un unique noeud d'air
% parmi tous ceux représentés dans la matrice Tair : sa température est la
% moyenne de la température de tous les noeuds. Le but est de constater
% comment la température de la pièce évolue pendant le fonctionnement du
% plancher chauffant.
% Les paramètres sont : Tair la matrice contenant tous les noeuds d'air
%                           avec leur température associée
%                       T la matrice contenant ...
% Les variables renvoyées sont : 
% Ces variables prennent la valeur : 
function EvolutionTemperaturePiece(Taffichage)
global dt
figure()
plot(dt,Taffichage);
title('Evolution de la température de la pièce en fonction du temps de fonctionnement du plancher chauffant');
xlabel('Discrétisation temporelle de la durée de fonctionnement du plancher chauffant');
ylabel('Température de la pièce (moyenne des noeuds d air) en kelvin');
end