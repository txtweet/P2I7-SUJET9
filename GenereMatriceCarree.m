%%%%%%%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%%%%%%%
%%% Remplissage d'une matrice carr�e pour le fluide %%%%
%%%          (utilis� pour le debuggage)            %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cette fonction remplit le matrice masque de notre probl�me 
% si l'on consid�re que notre element chauffant est un carr�. 

function GenereMatriceCarree()
global position_centre rayonConduiteNum matCellule matT Tchauf
% Les coefficients de la matrice matCelulle prennent la valeur 0 s'il
% s'agit de b�ton, 1 s'il s'agit du fluide
for i=position_centre(1)-rayonConduiteNum:position_centre(1)+rayonConduiteNum
    for j=position_centre(2)-rayonConduiteNum:position_centre(2)+rayonConduiteNum
            matCellule(i,j)=1;  %Mise � jour du masque
    end
end
end