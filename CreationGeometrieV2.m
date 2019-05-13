%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Création de la géométrie du problème %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx dy hc Tchauf
%% Variables du probleme
resolution = 1;                                         % nombre de noeuds par centimètre
hauteurDalle = 10;                                      % hauteur de la dalle (en cm)
largeurDalle = 10;                                      % largeur de la dalle (en cm)
rayonConduite = 1;                                      % rayon de l'élément chauffant 
hauteurConduite = (hauteurDalle+1)/2;                   % position du centre de l'élément chauffant par rapport au bas de la cellule modélisée
masse = 500;                                            % masse de la dalle de béton
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;  % volume de la dalle
rho = masse/volume;                                     % masse volumique du béton
lambda = 0.92;                                          % conductivité thermique du béton
c_p = 2.5e6;                                            % capacité thermique du béton
hc=1e3;                                                 % coefficient d'échanges convectifs de l'eau
Tchauf=293;                                             % température de l'eau, constante (en K)
%% Initialisation des paramètres
noeudsVert= resolution * hauteurDalle;                  % nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle;                  % nombre de neuds sur la largeur de la cellule
dx=1/resolution;                                        % discrétisation spatiale de la dalle selon la verticale
matCellule = zeros(noeudsVert,noeudsHor);               % matrice dont chaque coefficient représente une cellule de la dalle
rayonConduiteNum = floor(rayonConduite*resolution);     % valeur entière prise pour le rayon de la zone contenant l'eau
matT = zeros(noeudsVert,noeudsHor);                     % matrice dont chaque coefficient correspond à la température du point de la dalle correspondant
%% Parcours de la matrice à partir d'un point donné
position_centre = floor([(noeudsHor+1)/2 resolution*hauteurConduite]);
GenereMatriceCarree ();
T=zeros(noeudsHor*noeudsVert,1);
B=zeros(noeudsHor*noeudsVert,1);
A=matriceA(noeudsHor,noeudsVert,matCellule);
%%