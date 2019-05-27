function A=matriceA(noeudsHor,noeudsVert,matCellule, Tavant, Text)
global hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant
A=zeros(noeudsHor*noeudsVert, noeudsHor*noeudsVert);
%A est une matrice de taille noeudsHor*noeudsVert+3. On rajoute 3 points
%correspondant a l'isolant de resistance tres elevee au sous-dalle
%(indice 1), l'air au-dessus du plancher (indice N-2) et les murs (indice
%N)
%A=-h�Laplacien de T
%hc coefficient d'echange pour le sol
%hcmurs coefficient d'echange pour les murs
%Tavant est le vecteur temperature a la precedente iteration (cas
%instationnaire)
k=lambda*dt/(rho*c_p*dx*dx);
%k=1;
for i=2:noeudsHor-1
    for j=2:noeudsVert-3
    %for j=3:noeudsVert-3
        %cas ou la case etudiee est solide
        if (matCellule(j,i)==0)
            Voisins = DonneVoisins(i,j,matCellule);
            %cas ou les 4 voisins sont solides
            if(max(Voisins)==0)
                A(index(i,j),index(i,j))=4;
                A(index(i,j),index(i,j+1))=-1;
                A(index(i,j),index(i,j-1))=-1;
                A(index(i,j),index(i-1,j))=-1;
                A(index(i,j),index(i+1,j))=-1;
                A(index(i,j),:)=A(index(i,j),:)*k;
                A(index(i,j),index(i,j))= A(index(i,j),index(i,j))+1;
                %B(index(i,j),1)=Tavant(index(i,j),1);
            else
               %Cas o� au moins 1 voisins est fluide
              A=ModifAVoisin(A,Voisins,i,j,Tavant);
            end 
        elseif  (matCellule(j,i)==1)
            A(index(i,j),index(i,j))=1;
            %%B(index(i,j),1)=Tchauf;
        end
    end 
end
    
    %Condition aux limites periodiques 
    
    %Partie gauche de la cellule
    for j=2:noeudsVert-3
    %for j=3:noeudsVert-3
        A(index(1,j),index(1,j))=4;
        A(index(1,j),index(1,j+1))=-1;
        A(index(1,j),index(1,j-1))=-1;
        A(index(1,j),index(noeudsHor,j))=-1;
        A(index(1,j),index(2,j))=-1;
        A(index(1,j),:)= A(index(1,j),:).*k;
        A(index(1,j),index(1,j))=A(index(1,j),index(1,j))+1;
    end 
    
    %Partie droite de la cellule
    for j=2:noeudsVert-3
    %for j=3:noeudsVert-3
        
        A(index(noeudsHor,j),index(noeudsHor,j))=4;
        A(index(noeudsHor,j),index(noeudsHor,j+1))=-1;
        A(index(noeudsHor,j),index(noeudsHor,j-1))=-1;
        A(index(noeudsHor,j),index(1,j))=-1;
        A(index(noeudsHor,j),index(noeudsHor-1,j))=-1;
        A(index(noeudsHor,j),:)=k.*A(index(noeudsHor,j),:);
        A(index(noeudsHor,j),index(noeudsHor,j))= A(index(noeudsHor,j),index(noeudsHor,j))+1;
        
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
