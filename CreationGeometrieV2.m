%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%
%%% Cr�ation de la g�om�trie du probl�me %%%
clear all
global position_centre rayonConduiteNum matCellule matT B dx hc hcairdalle hcairmurs Tchauf lambdaair hcmurs lambda rho c_p dt l noeudsVert noeudsHor lambdaisolant Tsol Text Tair lambdamurs lambdasol c_p_air c_p_murs rhomurs rhoair c_p_isolant rhoisolant eisolant esol
%% Variables du probleme
resolution=3;                                           % nombre de noeuds par centim�tre
dt=150;                                                  % pas de temps (discr�tisation du temps)
l=1;                                                    % discr�tisation de l'espace
lambdaair=0.0262;                                       % conductivite thermique de l'air (d'apr�s Cours de thermique, C. Obrecht)
lambdaisolant=0.038;                                    % conductivite thermique de l'isolant du bas
lambdamurs=0.042;                                        % conductivit� thermique de l'isolant des murs
lambdaeau=0.6;                                          % conductivit� thermique de l'eau (d'apr�s C. OBRECHT)
lambda=11;                                             % conductivit� thermique du mat�riau de la dalle (ici : b�ton, d'apr�s C. OBRECHT)
lambdasol=0.04;                                         % conductivit� thermique du sol, ici gravier sec (d'apr�s le site energieplus-lesite.be)
hauteurDalle=10;                                        % hauteur de la dalle (en cm)
largeurDalle=10;                                        % largeur de la dalle (en cm)
rayonConduite=1;                                        % rayon de l'�l�ment chauffant 
hauteurConduite=(hauteurDalle+1)/2;                     % position du centre de l'�l�ment chauffant par rapport au bas de la cellule mod�lis�e
volume=hauteurDalle*largeurDalle-pi*rayonConduite^2;    % volume de la dalle
debit=100/3600;                                      % d�bit du fluide caloporteur, en L/h
vitesse=debit/(pi*(rayonConduite*10^(-2)));             % vitesse de d�placement du fluide caloporteur dans le tube
mu=0.653e-3;                                            % viscosit� dynamique de l'eau (cours de thermique, C. Obrecht)
rho_eau=1000;                                           % masse volumique de l'eau, unti� S.I.
rho=2400;                                               % masse volumique du mat�riau de la dalle en kg.m^(-3) (ici : b�ton, d'apr�s le site ciment.wikibis.com)
rhoisolant=25;                                          % masse volumique de l'isolant en kg.m^(-3) pour le polystyr�ne expans� (Guide des mat�riaux isolants, CAUE de la Haute-Loire)
rhomurs=(35+13)/2;                                           % masse volumique des murs
rhoair=1.225;                                           % masse volumique de l'air
masse=rho*volume;                                       % masse de la dalle
c_p=0.88e3;                                                % capacit� thermique massique du mat�riau de la dalle (ici : b�ton, d'ap�s le site laterlite.fr)
c_p_eau=4178;                                           % capacit� thermique massique de l'eau (cours de thermique, C. Obrecht)
c_p_isolant=1000;                                       % capacit� thermique massique de l'isolant (polystyr�ne expans�)
c_p_murs=(1800+1000)/2;                                          % capacit� thermique massique des murs
c_p_air=1004;                                           % capacit� thermique massique de l'air
eisolant=100e-2;                                        % �paisseur de la couche d'isolant sous dalle, en m�tres
esol=1;                                                 % �paisseur de la couche de sol sous isolant, en m�tres (tres importante pour grande isolation)
Re=(rho_eau*vitesse*(2*rayonConduite*10^(-2)))/mu;      % constante de Reynolds (cours de thermique, C. Obrecht)
Pr=mu*c_p_eau/lambdaeau;                                % constante de Prandtl (cours de thermique, C. Obrecht)
hc=lambdaeau*(0.023*Re^(4/5)*Pr^(1/3))/(2*rayonConduite*10^(-2)); % coefficient d'�changes convectifs de l'eau
hcmurs=1e3;                                             % coefficient d'echanges convectifs des murs de la piece
hcairdalle=10;                                          % coefficient d'�changes convectifs entre l'air et la dalle (pour le b�ton ici)
hcairmurs=10;                                           % coefficient d'�changes convectifs entre l'air int�rieur et les murs
Tchauf=50+273.15;                                      % temp�rature de l'eau, constante (en K)
Tdepart=15+273.15;                                      % temp�rature de la dalle
Tair=5+273.15;                                          % temperature de la piece
tmaxheures=3500;                                          % temps maximal de la simulation, en heures
tmax=tmaxheures*3600;                                  % temps maximal de la simulation, en secondes
%tmax=2*dt;
Text=0+273.15;                                          % temp�rature ext�rieure constante
Tsol=0+273.15;                                          % temp�rature du sol (sous la dalle)
dtprisedevue=1800;                                       % Temps entre 2 prises de vue de l'animation

%% Initialisation des param�tres
noeudsVert=resolution * hauteurDalle;               % nombre de neuds sur la hauteur de la cellule
noeudsHor =resolution * largeurDalle;               % nombre de neuds sur la largeur de la cellule
dx=1/resolution;                                    % discr�tisation spatiale de la dalle selon la verticale
matCellule=zeros(noeudsVert,noeudsHor);             % matrice dont chaque coefficient repr�sente une cellule de la dalle
rayonConduiteNum=floor(rayonConduite*resolution);   % valeur enti�re prise pour le rayon de la zone contenant l'eau
matT=zeros(noeudsVert,noeudsHor);                   % matrice dont chaque coefficient correspond � la temp�rature du point de la dalle correspondant
myVideo = VideoWriter('SimuLaine.avi');
myVideo.Quality = 100;                               % Default 75
open(myVideo);
%% Parcours de la matrice � partir d'un point donn�
position_centre=floor([(noeudsHor+1)/2 resolution*hauteurConduite]);  % coordonn�es du centre du tube contenant le fluide caloporteur
% ATTENTION : pour une faible r�solution et des dimensions de la dalle
% paires, la position du centre est d�centr�e vers le haut � gauche.
GenereMatrice();    % matCellule et matT sont remplies selon la g�om�trie du probl�me
%% R�solution du probl�me
Tancien=zeros(noeudsHor*noeudsVert,1);              % matrice colonne qui contient la temp�rature en chaque point de chaque cellule
%Tneuf=ones(noeudsHor*noeudsVert,1);                 % matrice colonne qui contient la temp�rature en chaque point de chaque cellule
Tneuf=initTemp(matCellule,Tdepart);
%Tneuf(:)=Tdepart;                                   % a changer
B=zeros(noeudsHor*noeudsVert,1);                    % matrice colonne
A=matriceA(noeudsHor,noeudsVert,matCellule,Tneuf, Text);  %
inA=inv(A);
i=dt; %BIZARRE COMME CONDITION
p=dt;   % A COMMENTER
q=dt;
Tair_aff=zeros(floor(tmax/(2*3600))-1,1);
Heures_aff=zeros(floor(tmax/(2*3600))-1,1);
z=1;
% E=EvolutionTemperaturePiece(tmax,i);
while i<tmax
    Tancien=Tneuf;
    B=matriceB(noeudsHor,noeudsVert,matCellule,Tancien, Text);
    Tneuf=inA*B;
    if p>=2*3600
        Tair_aff(z)=EvolutionTemperaturePiece(Tneuf);
        Heures_aff(z)=i/3600;
        z=z+1;
        p=0;
    end
    if q>=dtprisedevue
        q=0;
        T=reshape(Tneuf,noeudsVert,noeudsHor);
        surf(T);
        view(2);
        shading flat;
        writeVideo(myVideo,getframe);
    end
    i=i+dt;
    p=p+dt;
    q=q+dt;
end
close(myVideo);
%% Affichage
Tneuf(:)=Tneuf(:)-273.15; %conversion en degres celsius
T=reshape(Tneuf,noeudsVert,noeudsHor);
surf(T);
view(2);

%% Mise en �vidence du noeud d'air
figure();
Tair=zeros(size(T(noeudsVert-1,:)));
Tair(:)=T(noeudsVert-1,:);
plot(Tair);
%% Affichage de l'�volution de la temp�rature de la pi�ce en fonction du temps
figure()
plot(Heures_aff,Tair_aff);
title('Evolution de T(air) en fonction du temps de fonctionnement du plancher');
xlabel('Duree de fonctionnement du plancher chauffant (heures)');
ylabel('Temp�rature moyenne de la pi�ce (�C)');
%%