%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Création de la géométrie du problème %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx dy hc Tchauf

%% Variables du probleme
resolution = 1;    %nombre de neuds par centimètre
hauteurDalle = 10;  %hauteur de la dalle (en cm)
largeurDalle = 10;  %largeur de la dalle (en cm)
rayonConduite = 1;  %rayon de l'element chauffant 
hauteurConduite = (hauteurDalle+1)/2; % position du centre de l'élément chauffant par rapport au bas de la céllule mdoélisée
masse = 500;
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;
rho = masse/volume;
lambda = 0.92;
c_p = 2.5e6;
hc=1e3;
Tchauf=293;


%% Initialisation des paramètres
noeudsVert= resolution * hauteurDalle; %nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle; %nombre de neuds sur la largeur de la cellule
dx=largeurDalle/noeudsHor;
dy=hauteurDalle/noeudsVert;
matCellule = zeros(noeudsVert,noeudsHor);
rayonConduiteNum = floor(rayonConduite*resolution);
matT = zeros(noeudsVert,noeudsHor);
%% parcourir la matrice à partir d'un point donné
position_centre = floor([(noeudsHor+1)/2 resolution*hauteurConduite]);
GenereMatriceCarree ();
T=zeros(noeudsHor*noeudsVert,1);
B=zeros(noeudsHor*noeudsVert,1);
A=matriceA(noeudsHor,noeudsVert,matCellule);
%%

