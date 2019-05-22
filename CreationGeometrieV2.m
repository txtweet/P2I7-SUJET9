%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Création de la géométrie du problème %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx hc Tchauf lambdaair hcmurs lambda rho c_p dt l noeudsVert noeudsHor lambdaisolant Tsol
%% Variables du probleme
resolution = 5;                                         % nombre de noeuds par centimètre
hcmurs=1e3;                                             % coefficient d'echanges convectifs des murs de la piece
lambdaair=0.0262;                                       % conductivite thermique de l'air
lambdaisolant=0.004;                                    % conductivite thermique de l'isolant du bas
hauteurDalle = 10;                                      % hauteur de la dalle (en cm)
largeurDalle = 10;                                      % largeur de la dalle (en cm)
rayonConduite = 1;                                      % rayon de l'élément chauffant 
hauteurConduite = (hauteurDalle+1)/2;                   % position du centre de l'élément chauffant par rapport au bas de la cellule modélisée
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;  % volume de la dalle
rho = 350;                                              % masse volumique du béton en kg.m^(-3) (d'après le site plancher-chauffant.ooreka.fr)
masse = rho*volume;                                     % masse de la dalle de béton
lambda = 0.30;                                          % conductivité thermique du béton (d'après le site energieplus-lesite.be)
c_p = 2.5e3;                                            % capacité thermique massique du béton
hc=1e3;                                                 % coefficient d'échanges convectifs de l'eau
Tchauf=50+273.15;                                       % température de l'eau, constante (en K)
dt=1;                                                   % pas de temps (discrétisation du temps)
l=1;                                                    % discrétisation de l'espace
Tdepart=15+273.15;                                      % temperature de la piece
tmax=10;                                                % temps maximal de la simulation, en secondes
Text=3+273.15;                                          %temperature exterieure constante
Tsol=589+273.15;                                          %temperature du sol (sous la dalle)
%% Initialisation des paramètres
noeudsVert= resolution * hauteurDalle;              % nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle;              % nombre de neuds sur la largeur de la cellule
dx=1/resolution;                                    % discrétisation spatiale de la dalle selon la verticale
matCellule = zeros(noeudsVert,noeudsHor);           % matrice dont chaque coefficient représente une cellule de la dalle
rayonConduiteNum = floor(rayonConduite*resolution);	% valeur entière prise pour le rayon de la zone contenant l'eau
matT = zeros(noeudsVert,noeudsHor);                 % matrice dont chaque coefficient correspond à la température du point de la dalle correspondant
%% Parcours de la matrice à partir d'un point donné
position_centre = floor([(noeudsHor+1)/2 resolution*hauteurConduite]);  % coordonnées du centre du tube contenant le fluide caloporteur
% ATTENTION : pour une faible résolution et des dimensions de la dalle
% paires, la position du centre est décentrée vers le haut à gauche.
GenereMatrice();    % matCellule et matT sont remplies selon la géométrie du problème
%% Résolution du problème
Tancien=zeros(noeudsHor*noeudsVert,1);              % matrice colonne qui contient la température en chaque point de chaque cellule
Tneuf=ones(noeudsHor*noeudsVert,1);                 % matrice colonne qui contient la température en chaque point de chaque cellule
Tneuf(:)=Tdepart;                                   % a changer
B=zeros(noeudsHor*noeudsVert,1);                    % matrice colonne
A=matriceA(noeudsHor,noeudsVert,matCellule,Tneuf, Text);  %
i=dt;
while i<tmax
    Tancien=Tneuf;
    A=matriceA(noeudsHor,noeudsVert,matCellule,Tancien, Text);
    Tneuf=A\B;
    A;
    B;
    i=i+dt;
end
T=reshape(Tneuf,noeudsVert,noeudsHor);
surf(T);
view(2);
%%