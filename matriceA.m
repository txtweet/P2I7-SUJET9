function A=matriceA(noeudsHor,noeudsVert,matCellule)
global B hc dx Tchauf lambdaair
A=zeros(noeudsHor*noeudsVert, noeudsHor*noeudsVert);
%A est une matrice de taille noeudsHor*noeudsVert+3. On rajoute 3 points
%correspondant a l'isolant de resistance tres elevee au sous-dalle
%(indice1), l'air au-dessus du plancher (indice N-2) et les murs (indice
%N-3)
%A=-h²Laplacien de T

for i=3:noeudsHor-3
    for j=3:noeudsVert-3
        %cas ou la case etudiee est solide
        if (matCellule(i,j)==0)
            [nb1,nb2,nb3,nb4] = DonneVoisins(i,j,matCellule);
            %cas ou les 4 voisins sont solides
            %if(nb1==0 && nb2==0 && nb3==0 && nb4==0)
            if(matCellule(i-1,j)==0 && matCellule(i+1,j)==0 && matCellule(i,j+1)==0 && matCellule(i,j-1)==0)
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=4;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j+1))=-1;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j-1))=-1;
                A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)=-1;
                A((i-1)*noeudsVert+j,(i)*noeudsVert+j)=-1;
            
            %cas ou le voisin de droite est liquide
            %elseif nb4==1
            elseif (matCellule(i,j+1)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dx*hc;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j-1)=-4;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j-2)=1;
                    B((i-1)*noeudsVert+j,1)=2*dx*hc*Tchauf;
                    
            %cas ou le voisin de gauche est liquide
            %elseif nb1==1
            elseif (matCellule(i,j-1)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dx*hc;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j+1)=-4;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j+2)=1;
                    B((i-1)*noeudsVert+j,1)=2*dx*hc*Tchauf;
                    
            %cas ou le voisin du bas est liquide
            %elseif nb3==1
            elseif (matCellule(i+1,j)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dx*hc;
                    A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)=-4;
                    A((i-1)*noeudsVert+j,(i-3)*noeudsVert+j)=1;
                    B((i-1)*noeudsVert+j,1)=2*dx*hc*Tchauf;
                    
            %cas ou le voisin du haut est liquide
            %elseif nb2==1
            elseif (matCellule(i-1,j)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dx*hc;
                    A((i-1)*noeudsVert+j,(i)*noeudsVert+j)=-4;
                    A((i-1)*noeudsVert+j,(i+1)*noeudsVert+j)=1;
                    B((i-1)*noeudsVert+j,1)=2*dx*hc*Tchauf;
            end 
            
        end
    end 
    
    %Condition aux limites periodiques 
    
    %Partie gauche de la cellule
    for j=2:noeudsVert-1
        A(j,j)=4;
        A(j,(j+1))=-1;
        A(j,(j-1))=-1;
        A(j,(noeudsHor-1)*noeudsVert+j)=-1;
        A(j,noeudsVert+j)=-1;
    end 
    
    %Partie droite de la cellule
    for j=2:noeudsVert-1
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
 
end
end