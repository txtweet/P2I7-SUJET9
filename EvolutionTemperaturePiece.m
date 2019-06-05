%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%
%%% Fonction EvolutionTemperaturePiece %%%
% Cette fonction permet l'affichage de l'évolution de la température de la
% pièce en fonction du temps. Ainsi, nous considérons un unique noeud d'air
% parmi tous ceux représentés dans la matrice Tair : sa température est la
% moyenne de la température de tous les noeuds. Le but est de constater
% comment la température de la pièce évolue pendant le fonctionnement du
% plancher chauffant.
% Les paramètres sont : Tneuf la matrice contenant tous les noeuds avec
%                           leur température associée
%                       i l'instant
% Les variables renvoyées sont : 
% Ces variables prennent la valeur : 
function moyenne_noeud_dair=EvolutionTemperaturePiece(Tneuf)
global dt noeudsVert noeudsHor
% E=zeros(tmax,1);                        % Nous créons une matrice colonne ayant autant de lignes qu'il y a d'instants de fonctionnement à prendre en compte.
T=reshape(Tneuf,noeudsVert,noeudsHor);  % 
E=zeros(size(T(noeudsVert-1,:)));
E(:)=T(noeudsVert-1,:);
moyenne_noeud_dair=mean(E)-273.15;
% E(i)=Tneuf(i);	% Nous récupérons le numéro de la ligne de Tneuf correspondant au noeud d'air.
% E(numero_de_colonne)=
% figure()
% plot(dt,E);
% title('Evolution de la température de la pièce en fonction du temps de fonctionnement du plancher chauffant');
% xlabel('Discrétisation temporelle de la durée de fonctionnement du plancher chauffant');
% ylabel('Température de la pièce (moyenne des noeuds d air) en kelvin');
end