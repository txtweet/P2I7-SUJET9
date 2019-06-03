%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Création de la géométrie du problème %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx hc hcairdalle hcairmurs Tchauf lambdaair hcmurs lambda rho c_p dt l noeudsVert noeudsHor lambdaisolant Tsol Text lambdamurs lambdasol c_p_air c_p_murs rhomurs rhoair c_p_isolant rhoisolant eisolant esol
%% Variables du probleme
resolution=3;                                           % nombre de noeuds par centimètre
dt=1;                                                   % pas de temps (discrétisation du temps)
l=1;                                                    % discrétisation de l'espace
lambdaair=0.0262;                                       % conductivite thermique de l'air (d'après Cours de thermique, C. Obrecht)
lambdaisolant=0.038;                                     % conductivite thermique de l'isolant du bas
lambdamurs=0.05;                                        % conductivité thermique de l'isolant des murs
lambdaeau=0.6;                                          % conductivité thermique de l'eau (d'après C. OBRECHT)
lambda=0.92;                                             % conductivité thermique du béton (d'après C. OBRECHT)
lambdasol=0.04;                                          % conductivité thermique du sol, ici gravier sec (d'après le site energieplus-lesite.be)
hauteurDalle=10;                                        % hauteur de la dalle (en cm)
largeurDalle=10;                                        % largeur de la dalle (en cm)
rayonConduite=1;                                        % rayon de l'élément chauffant 
hauteurConduite=(hauteurDalle+1)/2;                     % position du centre de l'élément chauffant par rapport au bas de la cellule modélisée
volume=hauteurDalle*largeurDalle-pi*rayonConduite^2;    % volume de la dalle
debit=100e-3/3600;                                      % débit du fluide caloporteur, en L/h
vitesse=debit/(pi*(rayonConduite*10^(-2)));             % vitesse de déplacement du fluide caloporteur dans le tube
mu=0.653e-3;                                            % viscosité dynamique de l'eau (cours de thermique, C. Obrecht)
rho_eau=1000;                                           % masse volumique de l'eau, untié S.I.
rho=2400;                                                % masse volumique du béton en kg.m^(-3) (d'après le site ciment.wikibis.com)
rhoisolant=25;                                          % masse volumique de l'isolant en kg.m^(-3) pour le polystyrène expansé (Guide des matériaux isolants, CAUE de la Haute-Loire)
rhomurs=2000;                                             % masse volumique des murs
rhoair=1.225;                                           % masse volumique de l'air
masse=rho*volume;                                       % masse de la dalle de béton
c_p=1e3;                                                % capacité thermique massique du béton (d'apès le site laterlite.fr)
c_p_eau=4178;                                           % capacité thermique massique de l'eau (cours de thermique, C. Obrecht)
c_p_isolant=1000;                                       % capacité thermique massique de l'isolant (polystyrène expansé)
c_p_murs=1000;                                          % capacité thermique massique des murs
c_p_air=1004;                                           % capacité thermique massique de l'air
eisolant=100e-2;                                         % epaisseur de la couche d'isolant sous dalle, en metres
esol=1;                                                 % epaisseur de la couche de sol sous isolant, en metres (tres importante pour grande isolation)
Re=(rho_eau*vitesse*(2*rayonConduite*10^(-2)))/mu;      % constante de Reynolds (cours de thermique, C. Obrecht)
Pr=mu*c_p_eau/lambdaeau;                                % constante de Prandtl (cours de thermique, C. Obrecht)
hc=(0.023*Re^(4/5)*Pr^(1/3))/(2*rayonConduite*10^(-2)); % coefficient d'échanges convectifs de l'eau
hcmurs=1e3;                                             % coefficient d'echanges convectifs des murs de la piece
hcairdalle=10;                                          % coefficient d'échanges convectifs entre l'air et la dalle **PAS SUR**
hcairmurs=10;                                           % coefficient d'échanges convectifs entre l'air intérieur et les murs
Tchauf=500+273.15;                                       % température de l'eau, constante (en K)
Tdepart=15+273.15;                                      % temperature de la piece
tmaxheures=2;                                           % temps maximal de la simulation, en heures
tmax=tmaxheures*3600;                                   % temps maximal de la simulation, en secondes
Text=10+273.15;                                          % temperature exterieure constante
Tsol=10+273.15;                                        % temperature du sol (sous la dalle)
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
%Tneuf=ones(noeudsHor*noeudsVert,1);                 % matrice colonne qui contient la température en chaque point de chaque cellule
Tneuf=initTemp(matCellule,Tdepart);
%Tneuf(:)=Tdepart;                                   % a changer
B=zeros(noeudsHor*noeudsVert,1);                    % matrice colonne
A=matriceA(noeudsHor,noeudsVert,matCellule,Tneuf, Text);  %
inA=inv(A);
i=dt; %BIZARRE COMME CONDITION

while i<tmax
    Tancien=Tneuf;
    B=matriceB(noeudsHor,noeudsVert,matCellule,Tancien, Text);
    Tneuf=inA*B;
    i=i+dt;
end
Tneuf(:)=Tneuf(:)-273.15; %conversion en degres celsius
T=reshape(Tneuf,noeudsVert,noeudsHor);
surf(T);
view(2);
%%