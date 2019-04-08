% Fonction donne voisins
% Dit quels voisins sont des fluides
% i coord en horizontal
% j coord en vertical
% nb1 voisin de gacuhe
% nb2 voisin du haut
% nb3 voisin du bas
% nb4 voisin de droite
% 0 si solide
% 1 si fluide
% 2 si OutOfBounds

function [nb1,nb2,nb3,nb4] = DonneVoisins(i,j,matCellule)
[M,N]=size(matCellule);
nb1=2;
if((j-1)>=1 && i>=1 && i<=M && j<=N)
    nb1=0;
    if(matCellule(i,j-1)==1)
        nb1=1;
    end
end
nb2=2;
if((i-1)>=1 && j>=1 && i<=M && j<=N)
    nb2=0;
    if(matCellule(i-1,j)==1)
        nb2=1;
    end
end

nb3=2;
if((i+1)<=M && i>=1 && j>=1 && j<=N)
    nb3=0;
    if(matCellule(i+1,j)==1)
        nb3=1;
    end
end
nb4=2;
if((j+1)<=N && i>=1 && j>=1 && i<=M)
    nb4=0;
    if(matCellule(i,j+1)==1)
        nb4=1;
    end
end
end