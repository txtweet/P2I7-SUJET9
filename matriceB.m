function B=matriceB(noeudsHor,noeudsVert,matCellule, Tavant, Text)
global  hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant
B=zeros(noeudsHor*noeudsVert, 1);

for i=2:noeudsHor-1
    for j=2:noeudsVert-3
        %cas ou la case etudiee est solide
        if (matCellule(j,i)==0)
            Voisins = DonneVoisins(i,j,matCellule);
            %cas ou les 4 voisins sont solides
            if(max(Voisins)==0)
                B(index(i,j),1)=Tavant(index(i,j),1);
            else
                %Cas où au moins 1 voisins est fluide
                %% Conditions aux limites
                %%Voisins solide
                B(index(i,j),1)=-Tavant(index(i,j),1);
                %%Voisins fluide
                kfluide = -hc*l*dx*dt/(rho*c_p*dx*dx*l);
                if (Voisin(1,1)==1)
                    B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
                end
                if (Voisin(1,2)==1)
                    B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
                end 
                if (Voisin(1,3)==1)
                    B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
                end
                if (Voisin(1,4)==1)
                    B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
                end
            end 
        elseif(matCellule(i,j)==1)
            B(index(i,j),1)=Tchauf;
        end
    end 
end
    
    %Condition aux limites periodiques 
    
    %Partie gauche de la cellule
    for j=2:noeudsVert-3
        B(index(1,j),1)=Tavant(index(1,j),1);
    end 
    %Partie droite de la cellule
    for j=2:noeudsVert-3
        B(index(noeudsHor,j),1)=Tavant(index(noeudsHor,j),1);
    end
    

end