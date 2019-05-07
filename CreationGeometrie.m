%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Cr�ation de la g�om�trie du probl�me %%%
global position_centre rayonConduiteNum matCellule matT

%% Variables du probleme
resolution = 100;                                       %nombre de neuds par centim�tre
hauteurDalle = 5;                                       %hauteur de la dalle (en cm)
largeurDalle = 5;                                       %largeur de la dalle (en cm)
rayonConduite = 0.5;                                    %rayon de l'element chauffant 
hauteurConduite = hauteurDalle/2;                       % position du centre de l'�l�ment chauffant par rapport au bas de la c�llule mdo�lis�e
masse = 500;                                            % masse de la dalle de b�ton
volume = hauteurDalle*largeurDalle-pi*rayonConduite^2;  % volume de la dalle
rho = masse/volume;                                     % masse volumique du b�ton
lambda = 0.92;                                          % conductivit� thermique du b�ton
c_p = 2.5e6;                                            % capacit� thermique du b�ton

%% Initialisation des param�tres
noeudsVert= resolution * hauteurDalle; %nombre de neuds sur la hauteur de la cellule
noeudsHor = resolution * largeurDalle; %nombre de neuds sur la largeur de la cellule
matCellule = zeros(noeudsVert,noeudsHor);
rayonConduiteNum = floor(rayonConduite*resolution);
matT = zeros(noeudsVert,noeudsHor);
%% parcourir la matrice � partir d'un point donn�
position_centre = floor([noeudsHor/2 resolution*hauteurConduite]);
GenereMatrice();
%% Calcul temp�rature en chaque point (�quation de la chaleur)

% for i=2:noeudsHor-1


%     for j=2:noeudsVert-1
%         % Dans le quart sup�rieur gauche
%         if i<noeudsHor/2 && j<noeudsVert/2
%             matT(i-1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j-1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         % Dans le quart sup�rieur droit
%         elseif i<noeudsHor/2 && j>noeudsVert/2
%             matT(i-1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j+1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         % Dans le quart inf�rieur gauche
%         elseif i>noeudsHor/2 && j<noeudsVert/2
%             matT(i+1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j-1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         % Dans le quart inf�rieur droit
%         elseif i>noeudsHor/2 && j>noeudsVert/2
%             matT(i+1,j) = (lambda/(rho*c_p))*((matT(i+1,j)-2*matT(i,j)+matT(i-1,j))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%             matT(i,j+1) = (lambda/(rho*c_p))*((matT(i,j+1)-2*matT(i,j)+matT(i,j-1))/((hauteurDalle/resolution)*(largeurDalle/resolution)));
%         end
%     end
% end