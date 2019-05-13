%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Cr�ation de la g�om�trie du probl�me %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx hc Tchauf lambdaair hcmurs lambda rho c_p dt l
%% Variables du probleme
resolution = 1;                                         % nombre de noeuds par centim�tre
hcmurs=1e3;                                             % coefficient d'echanges convectifs des murs de la piece
lambdaair=0.0262;                                       % conductivite thermique de l'air
hauteurDalle = 8;                                      % hauteur de la dalle (en cm)
largeurDalle = 8;                                      % largeur de la dalle (en cm)
rayonConduite = 1;                                      % rayon de l'�l�ment chauffant 
hauteurConduite = (hauteurDalle+1)/2;                   % position du centre de l'�l�ment chauffant par rapport au bas de la cellule mod�lis�e
masse = 500;                                            % masse de la dalle de b�ton
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;  % volume de la dalle
rho = masse/volume;                                     % masse volumique du b�ton
lambda = 0.92;                                          % conductivit� thermique du b�ton
c_p = 2.5e6;                                            % capacit� thermique du b�ton
hc=1e3;                                                 % coefficient d'�changes convectifs de l'eau
Tchauf=293;                                             % temp�rature de l'eau, constante (en K)
dt=1;
l=1; 
Tdepart=30;                                             % temperature de la piece
tmax=3;                                               % temps maximal de la simulation, en secondes
%% Initialisation des param�tres
noeudsVert= resolution * hauteurDalle;              % nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle;              % nombre de neuds sur la largeur de la cellule
dx=1/resolution;                                    % discr�tisation spatiale de la dalle selon la verticale
matCellule = zeros(noeudsVert,noeudsHor);           % matrice dont chaque coefficient repr�sente une cellule de la dalle
rayonConduiteNum = floor(rayonConduite*resolution);	% valeur enti�re prise pour le rayon de la zone contenant l'eau
matT = zeros(noeudsVert,noeudsHor);                 % matrice dont chaque coefficient correspond � la temp�rature du point de la dalle correspondant
%% Parcours de la matrice � partir d'un point donn�
position_centre = floor([(noeudsHor+1)/2 resolution*hauteurConduite]);  % coordonn�es du centre du tube contenant le fluide caloporteur
% ATTENTION : pour une faible r�solution et des dimensions de la dalle
% paires, la position du centre est d�centr�e vers le haut � gauche.
GenereMatrice();                                                  % matCellule et matT sont remplies selon la g�om�trie du probl�me
%% R�solution du probl�me
Tancien=zeros(noeudsHor*noeudsVert,1);                % matrice colonne qui contient la temp�rature en chaque point de chaque cellule
Tneuf=ones(noeudsHor*noeudsVert,1);                % matrice colonne qui contient la temp�rature en chaque point de chaque cellule
Tneuf(:)=Tdepart;                               %a changer
B=zeros(noeudsHor*noeudsVert,1);                % matrice colonne
A=matriceA(noeudsHor,noeudsVert,matCellule,Tneuf);    %
i=dt;
while i<tmax
    Tancien=Tneuf;
    A=matriceA(noeudsHor,noeudsVert,matCellule,Tancien);
    Tneuf=A\B;
    i=i+dt;
end
%%