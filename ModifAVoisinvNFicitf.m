%% Réalisation du bilan de chaleur au point i,j
function A=ModifAVoisin(A, Voisin, i, j,Tavant)
global dx l rho c_p noeudsVert hc dt Tchauf B lambda
    coord =(i-1)*noeudsVert+j;                  %Index du noeud considéré dans la matrice A et B
    %ksolide=-lambda*dx*dx*dt*l/(rho*c_p*2*dx);     %Coefficient multiplicateur pour la derivée du solide
    %kfluide=dx*l*hc/(lambda);               %Coefficient multiplicateur pour la derivée dans le fluide
    
    %% Voisins solide
    if (Voisin(1,1)==0) %gauche
        
    end
    if (Voisin(1,2)==0) %haut
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j+1))=-1;
    end
    if (Voisin(1,3)==0) %bas
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j-1))=-1;
    end
    if(Voisin(1,4)==0) %droite
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j)=-1;
    end
    k=-lambda*dt/(rho*c_p*dx*dx);
    A((i-1)*noeudsVert+j,:)=A((i-1)*noeudsVert+j,:)*k;
    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)+1;
    B((i-1)*noeudsVert+j,1)=Tavant((i-1)*noeudsVert+j,1);
    %% Voisins fluide
    %k=(-lambda*dt)/(rho*c_p*dx*dx);
    if (Voisin(1,1)==1) %gauche
        A(coord,coord)= A(coord,coord)-(hc/2-lambda/dx)*k/(-lambda/dx-hc/2);
        B(coord,1) = B(coord,1)+(Tchauf*k)/(-lambda/dx-hc/2);
    end
    if (Voisin(1,2)==1) %haut
        A(coord,coord)= A(coord,coord)+(hc/2-lambda/dx)*k/(-lambda/dx-hc/2);
        B(coord,1) = B(coord,1)+(Tchauf*k)/(-lambda/dx-hc/2);
    end 
    if (Voisin(1,3)==1) %bas
        A(coord,coord)= A(coord,coord)-(hc/2-lambda/dx)*k/(-lambda/dx-hc/2);
        B(coord,1) = B(coord,1)+(Tchauf*k)/(-lambda/dx-hc/2);
    end
    if (Voisin(1,4)==1) %droite
        A(coord,coord)= A(coord,coord)+(hc/2-lambda/dx)*k/(-lambda/dx-hc/2);
        B(coord,1) = B(coord,1)+(Tchauf*k)/(-lambda/dx-hc/2);
    end

end