%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Cr�ation de la g�om�trie du probl�me %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx dy hc Tchauf

%% Variables du probleme
resolution = 1;                                         % nombre de noeuds par centim�tre
hauteurDalle = 10;                                      % hauteur de la dalle (en cm)
largeurDalle = 10;                                      % largeur de la dalle (en cm)
rayonConduite = 1;                                      % rayon de l'�l�ment chauffant 
hauteurConduite = (hauteurDalle+1)/2;                   % position du centre de l'�l�ment chauffant par rapport au bas de la cellule mod�lis�e
masse = 500;                                            % masse de la dalle de b�ton
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;  % volume de la dalle
rho = masse/volume;                                     % masse volumique du b�ton
lambda = 0.92;                                          % conductivit� thermique du b�ton
c_p = 2.5e6;                                            % capacit� thermique du b�ton
hc=1e3;                                                 % coefficient d'�changes convectifs de l'eau
Tchauf=293;                                             % temp�rature de l'eau, constante (en K)


%% Initialisation des param�tres
noeudsVert= resolution * hauteurDalle; %nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle; %nombre de neuds sur la largeur de la cellule
dx=largeurDalle/noeudsHor;
dy=hauteurDalle/noeudsVert;
matCellule = zeros(noeudsVert,noeudsHor);
rayonConduiteNum = floor(rayonConduite*resolution);
matT = zeros(noeudsVert,noeudsHor);
%% parcourir la matrice � partir d'un point donn�
position_centre = floor([(noeudsHor+1)/2 resolution*hauteurConduite]);
GenereMatriceCarree ();
T=zeros(noeudsHor*noeudsVert,1);
B=zeros(noeudsHor*noeudsVert,1);
A=matriceA(noeudsHor,noeudsVert,matCellule);
%%

