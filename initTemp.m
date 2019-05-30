function T=initTemp(noeudsVert,noeudsHor,Tchauf,Tsol,Text,Tdepart)
% global Tchauf noeudsHor noeudsVert Tsol Text Tpiece
global matCellule
T=ones(noeudsHor*noeudsVert,1)*Tdepart;
for i=1:noeudsHor
    for j=1:noeudsVert
        %if matCellule(j,i)==1
        if matCellule(i,j)==1
            T(index(i,j))=Tchauf;
        end
        if j==1 %temperature de l'isolant idem que temperature du sol
            T(index(i,j))=Tsol;
        end
        if j==noeudsVert %temperature des murs, moyenne entre Text et Tpiece (Tpiece=Tdepart au debut)
            T(index(i,j))=(Text+Tdepart)/2;
        end
        
    end
end
end