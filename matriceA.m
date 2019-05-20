function A=matriceA(noeudsHor,noeudsVert,matCellule, Tavant, Text)
global B hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant
A=zeros(noeudsHor*noeudsVert, noeudsHor*noeudsVert);
%A est une matrice de taille noeudsHor*noeudsVert+3. On rajoute 3 points
%correspondant a l'isolant de resistance tres elevee au sous-dalle
%(indice 1), l'air au-dessus du plancher (indice N-2) et les murs (indice
%N)
%A=-h²Laplacien de T
%hc coefficient d'echange pour le sol
%hcmurs coefficient d'echange pour les murs
%Tavant est le vecteur temperature a la precedente iteration (cas
%instationnaire)

for i=2:noeudsHor-1
    for j=2:noeudsVert-3
        %cas ou la case etudiee est solide
        if (matCellule(i,j)==0)
            Voisins = DonneVoisins(i,j,matCellule);
            %cas ou les 4 voisins sont solides
            if(max(Voisins)==0)
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=4;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j+1))=-1;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j-1))=-1;
                A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)=-1;
                A((i-1)*noeudsVert+j,(i)*noeudsVert+j)=-1;
                k=-lambda*dt/(rho*c_p*dx*dx);
                A((i-1)*noeudsVert+j,:)=A((i-1)*noeudsVert+j,:)*k;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)= A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)+1;
                B((i-1)*noeudsVert+j,1)=Tavant((i-1)*noeudsVert+j,1);
            else
               %Cas où au moins 1 voisins est fluide
               A=ModifAVoisin(A,Voisins,i,j,Tavant);
            end 
        elseif  (matCellule(i,j)==1)
            A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=1;
            B((i-1)*noeudsVert+j,1)=Tchauf;
        end
    end 
end
    
    %Condition aux limites periodiques 
    
    %Partie gauche de la cellule
    for j=2:noeudsVert-3
        A(j,j)=4;
        A(j,(j+1))=-1;
        A(j,(j-1))=-1;
        A(j,(noeudsHor-1)*noeudsVert+j)=-1;
        A(j,noeudsVert+j)=-1;
        k=lambda*dt/(rho*c_p*dx*dx);
        A(j,:)= A(j,:).*k;
        A(j,j)=A(j,j)+1;
    end 
    
    %Partie droite de la cellule
    for j=2:noeudsVert-3
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+j)=4;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j+1))=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j-1))=-1;
        A((noeudsHor-1)*noeudsVert+j,j)=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-2)*noeudsVert+j)=-1;
        A((noeudsHor-1)*noeudsVert+j,:)=k.*A((noeudsHor-1)*noeudsVert+j,:);
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+j)= A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+j)+1;
        
    end 
    
    %Ligne du haut du plancher : j=noeudsVert-2
%     j=noeudsVert-2;
%     for i=3:noeudsHor-3
%         A(i,j)=1;
%         A(i,j-1)=-lambdaair/(2*dx);
%         A(i,j+1)=-hc+lambdaair/(2*dx);
%     end
    
    % Conditions sur l'air : j=noeudsVert-1
%     j=noeudsVert-1;
%     for i=3:noeudsHor-3
%     end
     
   A=ConditionsLimitesHautEtBas(A,noeudsHor,noeudsVert,matCellule, Tavant, Text);
 
end
