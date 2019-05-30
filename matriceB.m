%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
%%% Remplissage de la matrice B %%%
%
% Les paramètres sont :
% La variable renvoyée est : matrice B
function B=matriceB(dt,l,lambda,lambdaair,lambdaisolant,lambdasol,rho,rhomurs,rhoisolant,c_p,c_p_murs,c_p_isolant,hc,hcmurs,hcairmurs,noeudsHor,noeudsVert,dx,matCellule,Tchauf,Tsol,Tavant,Text)
% global  hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant l lambdasol rhomurs c_p_murs rhoisolant c_p_isolant hcairmurs
B=zeros(noeudsHor*noeudsVert, 1);
for i=2:noeudsHor-1
    %for j=2:noeudsVert-3
    for j=3:noeudsVert-3
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
                B(index(i,j),1)=Tavant(index(i,j),1);
                %%Voisins fluide
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
%% Condition aux limites periodiques 
%Partie gauche de la cellule
%for j=2:noeudsVert-3
for j=3:noeudsVert-3
    B(index(1,j),1)=Tavant(index(1,j),1);
end 
%Partie droite de la cellule
%for j=2:noeudsVert-3
for j=3:noeudsVert-3
    B(index(noeudsHor,j),1)=Tavant(index(noeudsHor,j),1);
end
%% Conditions en haut en la dalle
for i=1:noeudsHor
	%au point le plus haut de la dalle
	j=noeudsVert-2;
	%k1=noeudsVert*(i-1)+j;
	B(index(i,j))=Tavant(index(i,j));

    %au noeud d'air
    j=noeudsVert-1;
    %k2=noeudsVert*(i-1)+j;
    B(index(i,j))=Tavant(index(i,j));

    %au noeud de murs
    j=noeudsVert;
    %k3=noeudsVert*(i-1)+j;
    %B(index(i,j))=Tavant(index(i,j))+Text*lambda*dt/(rhomurs*c_p_murs*dx.^2)+Text*(hcmurs+lambdaair/dx);
    B(index(i,j))=Tavant(index(i,j))+Text*hcairmurs*dt/(rhomurs*c_p_murs);
%     if i>1 && i<noeudsHor
%         B(k3)=B(k3)+Tavant(k3);
%     end
%% Conditions en bas de la dalle
j=1;
B(index(i,j))=Tsol*(lambdasol+lambdaisolant)*dt/(rhoisolant*c_p_isolant*dx^2)+Tavant(index(i,j));
j=2;
B(index(i,j))=Tavant(index(i,j));
% k4=noeudsVert*(i-1)+j;
% B(k4)=B(k4)-Tsol*2*(lambdaisolant+lambdasol)/(rho*c_p*dx^2);
% %if i~=1 && i~=noeudsHor
%     B(k4)=B(k4)+Tavant(k4);
% %end
% B(index(i,2))=Tavant(index(i,2));
end
end