function GenereMatrice()

global position_centre rayonConduiteNum matCellule matT

% 0 si beton, 1 si fluide
for i=position_centre(1)-rayonConduiteNum:position_centre(1)+rayonConduiteNum
    for j=position_centre(2)-rayonConduiteNum:position_centre(2)+rayonConduiteNum
        if sqrt((i-position_centre(1)).^2+(j-position_centre(2)).^2)<=rayonConduiteNum
            matCellule(i,j)=1;
            matT(i,j)=25+273.15;
        end
    end
end
end