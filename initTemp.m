function T=initTemp(matCellule,Tdepart)
global Tchauf noeudsHor noeudsVert Tsol Text Tair
T=ones(noeudsHor*noeudsVert,1)*Tdepart;
for i=1:noeudsHor
    for j=1:noeudsVert
        %if matCellule(j,i)==1
        if matCellule(i,j)==1
            T(index(i,j))=Tchauf;
        end
        if j==1 %temperature de l'isolant moyenne entre temperature du sol et Tdalle
            T(index(i,j))=(Tsol+Tdepart)/2;
        end
        if j==noeudsVert %temperature des murs, moyenne entre Text et Tpiece (Tpiece=Tdepart au debut)
            T(index(i,j))=(Text+Tair)/2;
        end
        if j==noeudsVert-1
            T(index(i,j))=Tair;
        end
    end
end
end