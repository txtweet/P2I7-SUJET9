%% Réalisation du bilan de chaleur au point i,j
function A=ModifAVoisin(A, Voisin, i, j,Tavant)
global dx l rho c_p noeudsVert hc dt Tchauf B lambda
    coord =(i-1)*noeudsVert+j;                  %Index du noeud considéré dans la matrice A et B
    ksolide=-lambda*dx*l*dt/(rho*c_p*dx*dx*l*2*dx);     %Coefficient multiplicateur pour la derivée du solide
    kfluide=dx*dt*l*hc/(rho*c_p*dx*dx*l);               %Coefficient multiplicateur pour la derivée dans le fluide
    
    %% Voisins solide
    if (Voisin(1,1)==0) %Voisin de droite
        A(coord,coord)= A(coord,coord)-3/(2*dx);
        A(coord,coord+noeudsVert) = 4/(2*dx);
        A(coord,coord+2*noeudsVert) = -1/(2*dx);         
    end
    
    if (Voisin(1,2)==0)
        %Voisin du haut
        A(coord,coord)= A(coord,coord)+3/(2*dx);
        A(coord,coord-1) = -4/(2*dx);
        A(coord,coord-2) = 1/(2*dx);
    end 
    if (Voisin(1,3)==0)     
        %Voisin du bas 
        A(coord,coord)= A(coord,coord)-3/(2*dx);
        A(coord,coord+1) = 4/(2*dx);
        A(coord,coord+2) = -1/(2*dx);
    end
    if (Voisin(1,4)==0)     
        %Voisin de gauche
        A(coord,coord)= A(coord,coord)+3/(2*dx);
        A(coord,coord-noeudsVert) = -4/(2*dx);
        A(coord,coord-2*noeudsVert) = 1/(2*dx);
    end
    A(coord,:)=ksolide.*A(coord,:);
    A(coord,coord)=A(coord,coord)-1; %??
    B(coord,1)=-Tavant(coord,1);
    %% Voisins fluide
    kfluide = -hc*l*dx*dt/(rho*c_p*dx*dx*l);
    if (Voisin(1,1)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord+noeudsVert) = A(coord,coord+noeudsVert)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf;
    end
    
    if (Voisin(1,2)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord+1) = A(coord,coord+1)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf;
    end 
    if (Voisin(1,3)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord-1) = A(coord,coord-1)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf;
    end
    if (Voisin(1,4)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord-noeudsVert) = A(coord,coord-noeudsVert)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf;
    end

end