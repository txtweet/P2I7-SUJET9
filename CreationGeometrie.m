%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Création de la géométrie du problème %%%

%% Variables du probleme
resolution = 100;    %nombre de neuds par centimètre
hauteurDalle = 5;  %hauteur de la dalle (en cm)
largeurDalle = 5;  %largeur de la dalle (en cm)
rayonConduite = 0.5;  %rayon de l'element chauffant 
hauteurConduite = hauteurDalle/2; % position du centre de l'élément chauffant par rapport au bas de la céllule mdoélisée


%% Initialisation des paramètres
noeudsVert= resolution * hauteurDalle; %nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle; %nombre de neuds sur la largeur de la cellule
matCellule = zeros(noeudsVert,noeudsHor);
rayonConduiteNum = floor(rayonConduite*resolution);

%% parcourir la matrice à partir d'un point donné
position_centre = floor([noeudsHor/2 resolution*hauteurConduite]);

matCellule;
