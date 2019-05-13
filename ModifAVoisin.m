function A=ModifAVoisin(A, Voisin, i, j)
global dx l rho cp noeudsVert hc dt Tchauf B
    index =(i-1)*noeudsVert+j;
    %ksolide=-lambda*dx*dt*l/(rho*cp*2*dx);
    %kfluide=dx*dt*l*hc*/(rho*cp);
    ksolide=1;
    kfluide=1;
    %% Voisins solide
    if (Voisin(1,1)==0)
        A(index,index)= 3;
        A(index,index-noeudsVert) = -4;
        A(index,index-2*noeudsVert) = 1;
    end
    
    if (Voisin(1,2)==0)
        A(index,index)= 3;
        A(index,index-1) = -4;
        A(index,index-2) = 1;
    end 
    if (Voisin(1,3)==0)
        A(index,index)= -3;
        A(index,index-1) = 4;
        A(index,index-2) = -1;
    end
    if (Voisin(1,4)==0)
        A(index,index)= -3;
        A(index,index+noeudsVert) = 4;
        A(index,index+2*noeudsVert) = -1;
    end
    
    A(index,:)=A(index,:)*ksolide/(2*dx);
    %% Voisins fluide
    if (Voisin(1,1)==1)
        A(index,index)= kfluide*-3/2;
        A(index,index-noeudsVert) = kfluide*1/2;
        B(index,index) = B(index,index)-kfluide*Tchauf*dt;
    end
    
    if (Voisin(1,2)==1)
        A(index,index)= kfluide*-3/2;
        A(index,index-1) = kfluide*1/2;
        B(index,index) = B(index,index)-kfluide*Tchauf*dt;
    end 
    if (Voisin(1,3)==1)
        A(index,index)= kfluide*-3/2;
        A(index,index+1) = kfluide*1/2;
        B(index,index) = B(index,index)-kfluide*Tchauf*dt;
    end
    if (Voisin(1,4)==1)
        A(index,index)= kfluide*-3/2;
        A(index,index+noeudsVert) = kfluide*1/2;
        B(index,index) = B(index,index)-kfluide*Tchauf*dt;
    end

end