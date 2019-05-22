%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Création de la géométrie du problème %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx hc Tchauf lambdaair hcmurs lambda rho c_p dt l noeudsVert noeudsHor lambdaisolant Tsol lambdamurs lambdasol c_p_murs rhomurs c_p_isolant rhoisolant
%% Variables du probleme
resolution=5;                                           % nombre de noeuds par centimètre
dt=1;                                                   % pas de temps (discrétisation du temps)
l=1;                                                    % discrétisation de l'espace
lambdaair=0.0262;                                       % conductivite thermique de l'air (d'après Cours de thermique, C. Obrecht)
lambdaisolant=0.04;                                     % conductivite thermique de l'isolant du bas
lambdamurs=0.04;                                        % conductivité thermique de l'isolant des murs
lambdaeau=0.6;                                          % conductivité thermique de l'eau (d'après le site ekopedia.fr)
lambda=0.142;                                           % conductivité thermique du béton (d'après le site laterlite.fr)
lambdasol=0.4;                                         % conductivité thermique du sol, ici gravier sec (d'après le site energieplus-lesite.be)
hauteurDalle=10;                                        % hauteur de la dalle (en cm)
largeurDalle=10;                                        % largeur de la dalle (en cm)
rayonConduite=1;                                        % rayon de l'élément chauffant 
hauteurConduite=(hauteurDalle+1)/2;                     % position du centre de l'élément chauffant par rapport au bas de la cellule modélisée
volume=hauteurDalle*largeurDalle-pi*rayonConduite^2;    % volume de la dalle
debit=100e-3/3600;                                      % débit du fluide caloporteur, en L/h
vitesse=debit/(pi*(rayonConduite*10^(-2)));             % vitesse de déplacement du fluide caloporteur dans le tube
mu=0.653e-3;                                            % viscosité dynamique de l'eau (cours de thermique, C. Obrecht)
rho_eau=1000;                                           % masse volumique de l'eau, untié S.I.
rho=600;                                                % masse volumique du béton en kg.m^(-3) (d'après le site laterlite.fr)
rhoisolant=20;                                         % masse volumique de l'isolant en kg.m^(-3) pour le polystyrène expansé (Guide des matériaux isolants, CAUE de la Haute-Loire)
rhomurs=20;                                            % masse volumique des murs
masse=rho*volume;                                       % masse de la dalle de béton
c_p=1e3;                                                % capacité thermique massique du béton (d'apès le site laterlite.fr)
c_p_eau=4178;                                           % capacité thermique massique de l'eau (cours de thermique, C. Obrecht)
c_p_isolant=1400;                                       % capacité thermique massique de l'isolant (polystyrène expansé)
c_p_murs=1400;                                          % capacité thermique massique des murs
Re=(rho_eau*vitesse*(2*rayonConduite*10^(-2)))/mu;      % constante de Reynolds (cours de thermique, C. Obrecht)
Pr=mu*c_p_eau/lambdaeau;                                % constante de Prandtl (cours de thermique, C. Obrecht)
hc=(0.023*Re^(4/5)*Pr^(1/3))/(2*rayonConduite*10^(-2)); % coefficient d'échanges convectifs de l'eau
hcmurs=1e3;                                             % coefficient d'echanges convectifs des murs de la piece
Tchauf=40+273.15;                                       % température de l'eau, constante (en K)
Tdepart=15+273.15;                                      % temperature de la piece
tmax=10;                                                % temps maximal de la simulation, en secondes
Text=3+273.15;                                          % temperature exterieure constante
Tsol=589+273.15;                                        % temperature du sol (sous la dalle)
%% Initialisation des paramètres
noeudsVert=resolution * hauteurDalle;               % nombre de neuds sur la hauteur de la cellule
noeudsHor =resolution * largeurDalle;               % nombre de neuds sur la largeur de la cellule
dx=1/resolution;                                    % discrétisation spatiale de la dalle selon la verticale
matCellule=zeros(noeudsVert,noeudsHor);             % matrice dont chaque coefficient représente une cellule de la dalle
rayonConduiteNum=floor(rayonConduite*resolution);   % valeur entière prise pour le rayon de la zone contenant l'eau
matT=zeros(noeudsVert,noeudsHor);                   % matrice dont chaque coefficient correspond à la température du point de la dalle correspondant
%% Parcours de la matrice à partir d'un point donné
position_centre=floor([(noeudsHor+1)/2 resolution*hauteurConduite]);  % coordonnées du centre du tube contenant le fluide caloporteur
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