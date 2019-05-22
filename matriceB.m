function B=matriceB(noeudsHor,noeudsVert,matCellule, Tavant, Text)
global  hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant
B=zeros(noeudsHor*noeudsVert, 1);


for i=2:noeudsHor-1
    for j=2:noeudsVert-1    %j=2:noeudsVert-3
        %cas ou la case etudiee est solide
        %%if (matCellule(j,i)==0)
            Voisins = DonneVoisins(i,j,matCellule);
            %cas ou les 4 voisins sont solides
            %%if(max(Voisins)==0)
                B(index(i,j),1)=Tavant(index(i,j),1);
            %%else
               %Cas où au moins 1 voisins est fluide
              %%B=ModifBVoisin(B,Voisins,i,j,Tavant);
            %%end 
        %%elseif  (matCellule(i,j)==1)
            %%B(index(i,j),1)=Tchauf;
        %%end
    end 
end
    
    %Condition aux limites periodiques 
    
    %Partie gauche de la cellule
    for j=2:noeudsVert-1    %j=2:noeudsVert-3
        B(index(1,j),1)=Tavant(index(1,j),1);
    end 
    %Partie droite de la cellule
    for j=2:noeudsVert-1    %j=2:noeudsVert-3
        B(index(noeudsHor,j),1)=Tavant(index(noeudsHor,j),1);
    end
    
    %Up&Down
    for i=1:noeudsHor
        %A(index(i,1),index(i,1))=1;
        B(index(i,1),1)=250;
        %A(index(i,noeudsVert),index(i,noeudsVert))=1;
        B(index(i,noeudsVert),1)=250;
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
%     A=ConditionsLimitesHautEtBas(A,noeudsHor,noeudsVert,matCellule, Tavant, Text);
 
end