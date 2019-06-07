%%%%%%%%%%%%%%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Remplissage de la matrice T aux conditions initiales de temperature %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function T=initTemp(matCellule,Tdepart)
global Tchauf noeudsHor noeudsVert Tsol Text Tair
T=ones(noeudsHor*noeudsVert,1)*Tdepart;
for i=1:noeudsHor
    for j=1:noeudsVert
        if matCellule(j,i)==1 %condition pour le fluide calooporteur
            T(index(i,j))=Tchauf;
        end
        if j==1 %temperature de l'isolant moyenne entre temperature du sol et Tdalle
            T(index(i,j))=(Tsol+Tdepart)/2;
        end
        if j==noeudsVert %temperature des murs
            T(index(i,j))=Text;
        end
        if j==noeudsVert-1 %temperature de l'air
            T(index(i,j))=Text;
        end
    end
end
end