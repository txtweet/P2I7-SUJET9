function T=initTemp(matCellule,Tdepart)
global Tchauf noeudsHor noeudsVert
T=ones(noeudsHor*noeudsVert,1)*Tdepart;
for i=1:noeudsHor
    for j=1:noeudsVert
        if matCellule(j,i)==1
            T(index(i,j))=Tchauf;
        end
    end
end
end