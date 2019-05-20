%%%%%%% P2I7 - SUJET 9 %%%%%%%
%%% Fonction DonneVoisins %%%
% Cette fonction renseigne quels voisins sont des fluides
% Les paramètres sont : i coordonnée horizontale
%                       j coordonnée verticale
% Les variables renvoyées sont : nb1 (correspond au voisin de gauche)
%                                nb2 (correspond au du haut)
%                                nb3 (correspond au voisin du bas)
%                                nb4 (correspond au voisin de droite)
% Ces variables prennent la valeur : 0 si le voisin correspond au solide
%                                    1 si le voisin correspond au fluide
%                                    2 si le voisin est OutOfBounds
function D = DonneVoisins(i,j,matCellule)
[M,N]=size(matCellule);
nb1=2;
if( j>=1 && (i-1)>=1 && i<=M && j<=N)
    nb1=0;
    if(matCellule(j,i-1)==1)
        nb1=1;
    end
end
nb2=2;
if(i>=1 && (j-1)>=1 && i<=M && j<=N)
    nb2=0;
    if(matCellule(j-1,i)==1)
        nb2=1;
    end
end
nb3=2;
if(i<=M && i>=1 && j>=1 && (j+1)<=N)
    nb3=0;
    if(matCellule(j+1,i)==1)
        nb3=1;
    end
end
nb4=2;
if(j<=N && i>=1 && j>=1 && (i+1)<=M)
    nb4=0;
    if(matCellule(j,i+1)==1)
        nb4=1;
    end
end
D=[nb1 nb2 nb3 nb4];
end