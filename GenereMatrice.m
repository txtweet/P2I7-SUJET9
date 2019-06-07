%%%%%%%%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%%%%%%%%%
%%% Remplissage d'une matrice circulaire pour le fluide %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function GenereMatrice()
global position_centre rayonConduiteNum matCellule matT Tchauf
% Les coefficients de la matrice matCelulle prennent la valeur 0 s'il
% s'agit de béton, 1 s'il s'agit du fluide
for i=position_centre(1)-rayonConduiteNum:position_centre(1)+rayonConduiteNum
    for j=position_centre(2)-rayonConduiteNum:position_centre(2)+rayonConduiteNum
        if sqrt((i-position_centre(1)).^2+(j-position_centre(2)).^2)<=rayonConduiteNum
            matCellule(i,j)=1; %Mise à jour du masque
        end
    end
end
end