%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Remplissage de la matrice B %%%
% Cette fonction permet le remplissage de la matrice B.
function B=matriceB(noeudsHor,noeudsVert,matCellule, Tavant, Text)
global  hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant l lambdasol rhomurs c_p_murs rhoisolant c_p_isolant hcairmurs eisolant esol
B=zeros(noeudsHor*noeudsVert, 1);
for i=2:noeudsHor-1
    for j=3:noeudsVert-3
        % Cas où la case étudiée est solide
        if (matCellule(j,i)==0)
            Voisins = DonneVoisins(i,j,matCellule); % Nous utilisons la fonction DonneVoisins pour trouver la matière dont sont composés les quatre cellules voisines de la cellule considérée.
            % Cas où les 4 voisins sont solides
            if(max(Voisins)==0)
                B(index(i,j),1)=Tavant(index(i,j),1);
            else
                % Cas où au moins 1 voisin est fluide
                %% Conditions aux limites
                % Voisin solide
                B(index(i,j),1)=Tavant(index(i,j),1);
                % Voisin fluide
                kfluide = hc*l*dx*dt/(rho*c_p*dx*dx*l);
                if (Voisins(1,1)==1)
                    B(index(i,j),1) = B(index(i,j),1)+kfluide*Tchauf;
                end
                if (Voisins(1,2)==1)
                    B(index(i,j),1) = B(index(i,j),1)+kfluide*Tchauf;
                end 
                if (Voisins(1,3)==1)
                    B(index(i,j),1) = B(index(i,j),1)+kfluide*Tchauf;
                end
                if (Voisins(1,4)==1)
                    B(index(i,j),1) = B(index(i,j),1)+kfluide*Tchauf;
                end
            end 
        elseif(matCellule(j,i)==1)
            B(index(i,j),1)=Tchauf;
        end
    end 
end
%% Condition aux limites périodiques 
% Partie gauche de la cellule
for j=3:noeudsVert-3
    B(index(1,j),1)=Tavant(index(1,j),1);
end 
% Partie droite de la cellule
for j=3:noeudsVert-3
    B(index(noeudsHor,j),1)=Tavant(index(noeudsHor,j),1);
end
%% Conditions en haut en la dalle
for i=1:noeudsHor
	% Au point le plus haut de la dalle
	j=noeudsVert-2;
	B(index(i,j))=Tavant(index(i,j));
    % Au noeud d'air
    j=noeudsVert-1;
    B(index(i,j))=Tavant(index(i,j));
    % Au noeud de murs
    j=noeudsVert;
    B(index(i,j))=Tavant(index(i,j))+Text*hcairmurs*dt/(rhomurs*c_p_murs);
%% Conditions en bas de la dalle
j=1;
B(index(i,j))=Tsol*2*dt/(rhoisolant*c_p_isolant*((esol*dx/lambdasol)+(eisolant*dx/lambdaisolant)))+Tavant(index(i,j));
j=2;
B(index(i,j))=Tavant(index(i,j));
end
end