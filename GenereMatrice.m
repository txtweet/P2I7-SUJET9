function GenereMatrice()

global position_centre rayonConduiteNum matCellule

for i=position_centre(1)-rayonConduiteNum:position_centre(1)+rayonConduiteNum
    for j=position_centre(2)-rayonConduiteNum:position_centre(2)+rayonConduiteNum
        if sqrt((i-position_centre(1)).^2+(j-position_centre(2)).^2)<=rayonConduiteNum
            matCellule(i,j)=1;
        end
    end
end