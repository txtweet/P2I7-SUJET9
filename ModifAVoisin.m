function A=ModifAVoisin(A, Voisin, i, j)
global dx l rho c_p noeudsVert hc dt Tchauf B lambda
    coord =(i-1)*noeudsVert+j;
    %ksolide=-lambda*dx*dt*l/(rho*c_p*2*dx);
    %kfluide=dx*dt*l*hc/(rho*c_p);
    ksolide=1;
    kfluide=1;
    
    %% Voisins solide
    if (Voisin(1,1)==0)
        A(coord,coord)= A(coord,coord)+3;
        A(coord,coord-noeudsVert) = -4;
        A(coord,coord-2*noeudsVert) = 1;
    end
    
    if (Voisin(1,2)==0)
        A(coord,coord)= A(coord,coord)+3;
        A(coord,coord-1) = -4;
        A(coord,coord-2) = 1;
    end 
    if (Voisin(1,3)==0)
        A(coord,coord)= A(coord,coord)-3;
        A(coord,coord+1) = 4;
        A(coord,coord+2) = -1;
    end
    if (Voisin(1,4)==0)
        A(coord,coord)= A(coord,coord)-3;
        A(coord,coord+noeudsVert) = 4;
        A(coord,coord+2*noeudsVert) = -1;
    end
    A(coord,:)=ksolide/(2*dx).*A(coord,:);
    %% Voisins fluide
    if (Voisin(1,1)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord-noeudsVert) = A(coord,coord-noeudsVert)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf*dt;
    end
    
    if (Voisin(1,2)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord-1) = A(coord,coord-1)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf*dt;
    end 
    if (Voisin(1,3)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord+1) = A(coord,coord+1)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf*dt;
    end
    if (Voisin(1,4)==1)
        A(coord,coord)= A(coord,coord)+kfluide*(-3/2);
        A(coord,coord+noeudsVert) = A(coord,coord+noeudsVert)+kfluide*1/2;
        B(coord,1) = B(coord,1)-kfluide*Tchauf*dt;
    end

end