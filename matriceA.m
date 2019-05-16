function A=matriceA(noeudsHor,noeudsVert,matCellule, Tavant)
global B hc dx Tchauf lambdaair hcmurs lambda rho c_p dt 
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
                k=lambda/(rho*c_p*dx*dx);
                A((i-1)*noeudsVert+j,:)=A((i-1)*noeudsVert+j,:)*k;
            else
               %Cas où au moins 1 voisins est fluide
               A=ModifAVoisin(A,Voisins,i,j);
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
        k=lambda/(rho*c_p*dx*dx);
        A(j,:) = A(j,:).*k;
        
    end 
    
    %Partie droite de la cellule
    for j=2:noeudsVert-3
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+j)=4;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j+1))=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j-1))=-1;
        A((noeudsHor-1)*noeudsVert+j,j)=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-2)*noeudsVert+j)=-1;
        
        A((noeudsHor-1)*noeudsVert+j,:)=k.*A((noeudsHor-1)*noeudsVert+j,:);
        
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
     
    %Conditions en haut du plancher
    for i=1:noeudsHor
        %au niveau du haut du plancher (j=N-2)
        j=noeudsVert-2;
        k1=noeudsVert*(i-1)+j;
        A(k1,k1)=A(k1,k1)+hc+1+2*lambda*dt/(rho*c_p*dx.^2);
        A(k1,k1-1)=A(k1,k1-1)-lambdaair/(2*dx)-lambda*dt/(rho*c_p*dx.^2);
        A(k1,k1+1)=A(k1,k1+1)-hc+lambdaair/(2*dx)-lambda*dt/(rho*c_p*dx.^2);
        B(k1)=Tavant(k1);
        
        %au niveau de l'air (j=N-1) :
        j=noeudsVert-1;
        k2=noeudsVert*(i-1)+j;
        A(k2,k2)=A(k2,k2)+hc+hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
        A(k2,k2-1)=A(k2,k2-1)-lambdaair/(2*dx)-hc-lambda*dt/(rho*c_p*dx.^2);
        A(k2,k2+1)=A(k2,k2+1)+lambdaair/(2*dx)-hcmurs-lambda*dt/(rho*c_p*dx.^2);
        B(k2)=Tavant(k2);
        
        %au niveau des murs (j=N) :
        j=noeudsVert;
        k3=noeudsVert*(i-1)+j;
        A(k3,k3)=A(k3,k3)+lambdaair/dx+hcmurs+1-lambda*dt/(rho*c_p*dx.^2);
        B(k3)=Tavant(k3);
        A(k3,k3-1)=A(k3,k3)-lambdaair/dx-hcmurs+2*lambda*dt/(rho*c_p*dx.^2);
        A(k3,k3-2)=A(k3,k3-2)+lambda*dt/(rho*c_p*dx.^2);
        
        %au niveau du sous-sol (j=1) :
        j=1;
        k4=noeudsVert*(i-1)+j;
        A(k4,k4)=A(k4,k4)+hc-lambdaair/dx+1-lambda*dt/(rho*c_p*dx.^2);
        A(k4,k4+1)=A(k4,k4+1)+hc+lambdaair/dx+lambda*dt/(rho*c_p*dx.^2);
        A(k4,k4+2)=A(k4,k4+2)-lambda*dt/(rho*c_p*dx.^2);
        B(k4)=Tavant(k4);
    end
 
end
