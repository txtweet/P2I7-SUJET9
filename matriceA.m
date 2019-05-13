function A=matriceA(noeudsHor,noeudsVert,matCellule)
global B hc dx Tchauf lambdaair hcmurs
A=zeros(noeudsHor*noeudsVert, noeudsHor*noeudsVert);
%A est une matrice de taille noeudsHor*noeudsVert+3. On rajoute 3 points
%correspondant a l'isolant de resistance tres elevee au sous-dalle
%(indice 1), l'air au-dessus du plancher (indice N-2) et les murs (indice
%N)
%A=-h²Laplacien de T
%hc coefficient d'echange pour le sol
%hcmurs coefficient d'echange pour les murs

for i=3:noeudsHor-3
    for j=3:noeudsVert-3
        Voisins = DonneVoisins(i,j,matCellule);
        %cas ou la case etudiee est solide
        if (matCellule(i,j)==0)
            %cas ou les 4 voisins sont solides
            %if(nb1==0 && nb2==0 && nb3==0 && nb4==0)
            if(matCellule(i-1,j)==0 && matCellule(i+1,j)==0 && matCellule(i,j+1)==0 && matCellule(i,j-1)==0)
               A=ModifAVoisin(A, Voisins, i, j)
            end 
            
        end
    end 
end
    
    %Condition aux limites periodiques 
    
    %Partie gauche de la cellule
    for j=3:noeudsVert-3
        A(j,j)=4;
        A(j,(j+1))=-1;
        A(j,(j-1))=-1;
        A(j,(noeudsHor-1)*noeudsVert+j)=-1;
        A(j,noeudsVert+j)=-1;
    end 
    
    %Partie droite de la cellule
    for j=3:noeudsVert-3
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+j)=4;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j+1))=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j-1))=-1;
        A((noeudsHor-1)*noeudsVert+j,j)=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-2)*noeudsVert+j)=-1;
    end 
    
    %Ligne du haut du plancher : j=noeudsVert-2
    j=noeudsVert-2;
    for i=3:noeudsHor-3
        A(i,j)=1;
        A(i,j-1)=-lambdaair/(2*dx);
        A(i,j+1)=-hc+lambdaair/(2*dx);
    end
    
    %Conditions sur l'air : j=noeudsVert-1
    j=noeudsVert-1;
    for i=3:noeudsHor-3
        
        
    end
    
    %Conditions en haut du plancher
    for i=1:noeudsHor
        %au niveau du haut du plancher (j=N-2)
        j=noeudsVert-2
        k1=noeudsHor*(i-1)+j;
        A(k1,k1)=hc;
        A(k1,k1-1)=-lambdaair/(2*dx);
        A(k1,k1+1)=-hc+lambdaair/(2*dx);
        
        %au niveau de l'air (j=N-1) :
        j=noeudsVert-1;
        k2=noeudsHor*(i-1)+j;
        A(k2,k2)=hc+hcmurs;
        A(k2,k2-1)=-lambdaair/(2*dx)-hc;
        A(k2,k2+1)=lambdaair/(2*dx)-hcmurs;
        
        %au niveau des murs (j=N) :
        j=noeudsVert;
        k3=noeudsHor*(i-1)+j;
        A(k3,k3)=lambdaair/dx+hcmurs;
        A(k3,k3-1)=-lambdaair/dx-hcmurs;
        
    end
 
end
