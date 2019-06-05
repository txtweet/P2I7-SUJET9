%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%
%%% Fonction EvolutionTemperaturePiece %%%
% Cette fonction permet l'affichage de l'�volution de la temp�rature de la
% pi�ce en fonction du temps. Ainsi, nous consid�rons un unique noeud d'air
% parmi tous ceux repr�sent�s dans la matrice Tair : sa temp�rature est la
% moyenne de la temp�rature de tous les noeuds. Le but est de constater
% comment la temp�rature de la pi�ce �volue pendant le fonctionnement du
% plancher chauffant.
% Les param�tres sont : Tneuf la matrice contenant tous les noeuds avec
%                           leur temp�rature associ�e
%                       i l'instant
% Les variables renvoy�es sont : 
% Ces variables prennent la valeur : 
function moyenne_noeud_dair=EvolutionTemperaturePiece(Tneuf)
global dt noeudsVert noeudsHor
% E=zeros(tmax,1);                        % Nous cr�ons une matrice colonne ayant autant de lignes qu'il y a d'instants de fonctionnement � prendre en compte.
T=reshape(Tneuf,noeudsVert,noeudsHor);  % 
E=zeros(size(T(noeudsVert-1,:)));
E(:)=T(noeudsVert-1,:);
moyenne_noeud_dair=mean(E)-273.15;
% E(i)=Tneuf(i);	% Nous r�cup�rons le num�ro de la ligne de Tneuf correspondant au noeud d'air.
% E(numero_de_colonne)=
% figure()
% plot(dt,E);
% title('Evolution de la temp�rature de la pi�ce en fonction du temps de fonctionnement du plancher chauffant');
% xlabel('Discr�tisation temporelle de la dur�e de fonctionnement du plancher chauffant');
% ylabel('Temp�rature de la pi�ce (moyenne des noeuds d air) en kelvin');
end