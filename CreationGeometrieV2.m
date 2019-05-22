%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Cr�ation de la g�om�trie du probl�me %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx hc Tchauf lambdaair hcmurs lambda rho c_p dt l noeudsVert noeudsHor lambdaisolant Tsol lambdamurs lambdasol c_p_murs rhomurs c_p_isolant rhoisolant
%% Variables du probleme
resolution=5;                                           % nombre de noeuds par centim�tre
dt=1;                                                   % pas de temps (discr�tisation du temps)
l=1;                                                    % discr�tisation de l'espace
lambdaair=0.0262;                                       % conductivite thermique de l'air (d'apr�s Cours de thermique, C. Obrecht)
lambdaisolant=0.04;                                     % conductivite thermique de l'isolant du bas
lambdamurs=0.04;                                        % conductivit� thermique de l'isolant des murs
lambdaeau=0.6;                                          % conductivit� thermique de l'eau (d'apr�s le site ekopedia.fr)
lambda=0.142;                                           % conductivit� thermique du b�ton (d'apr�s le site laterlite.fr)
lambdasol=0.4;                                         % conductivit� thermique du sol, ici gravier sec (d'apr�s le site energieplus-lesite.be)
hauteurDalle=10;                                        % hauteur de la dalle (en cm)
largeurDalle=10;                                        % largeur de la dalle (en cm)
rayonConduite=1;                                        % rayon de l'�l�ment chauffant 
hauteurConduite=(hauteurDalle+1)/2;                     % position du centre de l'�l�ment chauffant par rapport au bas de la cellule mod�lis�e
volume=hauteurDalle*largeurDalle-pi*rayonConduite^2;    % volume de la dalle
debit=100e-3/3600;                                      % d�bit du fluide caloporteur, en L/h
vitesse=debit/(pi*(rayonConduite*10^(-2)));             % vitesse de d�placement du fluide caloporteur dans le tube
mu=0.653e-3;                                            % viscosit� dynamique de l'eau (cours de thermique, C. Obrecht)
rho_eau=1000;                                           % masse volumique de l'eau, unti� S.I.
rho=600;                                                % masse volumique du b�ton en kg.m^(-3) (d'apr�s le site laterlite.fr)
rhoisolant=20;                                         % masse volumique de l'isolant en kg.m^(-3) pour le polystyr�ne expans� (Guide des mat�riaux isolants, CAUE de la Haute-Loire)
rhomurs=20;                                            % masse volumique des murs
masse=rho*volume;                                       % masse de la dalle de b�ton
c_p=1e3;                                                % capacit� thermique massique du b�ton (d'ap�s le site laterlite.fr)
c_p_eau=4178;                                           % capacit� thermique massique de l'eau (cours de thermique, C. Obrecht)
c_p_isolant=1400;                                       % capacit� thermique massique de l'isolant (polystyr�ne expans�)
c_p_murs=1400;                                          % capacit� thermique massique des murs
Re=(rho_eau*vitesse*(2*rayonConduite*10^(-2)))/mu;      % constante de Reynolds (cours de thermique, C. Obrecht)
Pr=mu*c_p_eau/lambdaeau;                                % constante de Prandtl (cours de thermique, C. Obrecht)
hc=(0.023*Re^(4/5)*Pr^(1/3))/(2*rayonConduite*10^(-2)); % coefficient d'�changes convectifs de l'eau
hcmurs=1e3;                                             % coefficient d'echanges convectifs des murs de la piece
Tchauf=40+273.15;                                       % temp�rature de l'eau, constante (en K)
Tdepart=15+273.15;                                      % temperature de la piece
tmax=10;                                                % temps maximal de la simulation, en secondes
Text=3+273.15;                                          % temperature exterieure constante
Tsol=589+273.15;                                        % temperature du sol (sous la dalle)
%% Initialisation des param�tres
noeudsVert=resolution * hauteurDalle;               % nombre de neuds sur la hauteur de la cellule
noeudsHor =resolution * largeurDalle;               % nombre de neuds sur la largeur de la cellule
dx=1/resolution;                                    % discr�tisation spatiale de la dalle selon la verticale
matCellule=zeros(noeudsVert,noeudsHor);             % matrice dont chaque coefficient repr�sente une cellule de la dalle
rayonConduiteNum=floor(rayonConduite*resolution);   % valeur enti�re prise pour le rayon de la zone contenant l'eau
matT=zeros(noeudsVert,noeudsHor);                   % matrice dont chaque coefficient correspond � la temp�rature du point de la dalle correspondant
%% Parcours de la matrice � partir d'un point donn�
position_centre=floor([(noeudsHor+1)/2 resolution*hauteurConduite]);  % coordonn�es du centre du tube contenant le fluide caloporteur
% ATTENTION : pour une faible r�solution et des dimensions de la dalle
% paires, la position du centre est d�centr�e vers le haut � gauche.
GenereMatrice();    % matCellule et matT sont remplies selon la g�om�trie du probl�me
%% R�solution du probl�me
Tancien=zeros(noeudsHor*noeudsVert,1);              % matrice colonne qui contient la temp�rature en chaque point de chaque cellule
Tneuf=ones(noeudsHor*noeudsVert,1);                 % matrice colonne qui contient la temp�rature en chaque point de chaque cellule
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