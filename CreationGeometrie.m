%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Cr�ation de la g�om�trie du probl�me %%%

%% Variables du probleme
resolution = 10;    %nombre de neuds par centim�tre
hauteurDalle = 20;  %hauteur de la dalle (en cm)
largeurDalle = 25;  %largeur de la dalle (en cm)
rayonConduite = 1;  %rayon de l'element chauffant 
hauteurConduite = hauteurDalle/2; % position du centre de l'�l�ment chauffant par rapport au bas de la c�llule mdo�lis�e


%% Initialisation des param�tres
noeudsVert= resolution * hauteurDalle; %nombre de neuds sur la hauteur de la cellule
neudsHor = resolution * largeurDalle; %nombre de neuds sur la largeur de la cellule
matCellule = zeros(noeudsVert,neudsHor);
rayonConduiteNum = floor(rayonConduite*resolution);

%% parcourir la matrice � partir d'un point donn�
position_centre = floor([noeudsHor/2 resolution*hauteurConduite]);
for i=position_centre(1)-rayonConduiteNum:position_centre(1)+rayonConduiteNum
    for j=position_centre(2)-rayonConduiteNum:position_centre(2)+rayonConduiteNum
%         
    end
end