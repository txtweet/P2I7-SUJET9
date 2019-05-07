%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Création de la géométrie du problème %%%
global position_centre rayonConduiteNum matCellule matT

%% Variables du probleme
resolution = 100;                                       %nombre de neuds par centimètre
hauteurDalle = 5;                                       %hauteur de la dalle (en cm)
largeurDalle = 5;                                       %largeur de la dalle (en cm)
rayonConduite = 0.5;                                    %rayon de l'element chauffant 
hauteurConduite = hauteurDalle/2;                       % position du centre de l'élément chauffant par rapport au bas de la céllule mdoélisée
masse = 500;                                            % masse de la dalle de béton
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;  % volume de la dalle
rho = masse/volume;                                     % masse volumique du béton
lambda = 0.92;                                          % conductivité thermique du béton
c_p = 2.5e6;                                            % capacité thermique du béton

%% Initialisation des paramètres
noeudsVert= resolution * hauteurDalle; %nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle; %nombre de neuds sur la largeur de la cellule
matCellule = zeros(noeudsVert,noeudsHor);
rayonConduiteNum = floor(rayonConduite*resolution);
matT = zeros(noeudsVert,noeudsHor);
%% parcourir la matrice à partir d'un point donné
position_centre = floor([noeudsHor/2 resolution*hauteurConduite]);
GenereMatrice();
%% Calcul température en chaque point (équation de la chaleur)

% for i=2:noeudsHor-1


%     for j=2:noeudsVert-1
%         % Dans le quart supérieur gauche
%         if i<noeudsHor/2 && j<noeudsVert/2
%             matT(i-1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j-1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         % Dans le quart supérieur droit
%         elseif i<noeudsHor/2 && j>noeudsVert/2
%             matT(i-1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j+1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         % Dans le quart inférieur gauche
%         elseif i>noeudsHor/2 && j<noeudsVert/2
%             matT(i+1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j-1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         % Dans le quart inférieur droit
%         elseif i>noeudsHor/2 && j>noeudsVert/2
%             matT(i+1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j+1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         end
%     end
% end