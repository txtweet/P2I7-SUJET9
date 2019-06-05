%% Réalisation du bilan de chaleur au point i,j
function A=ModifAVoisinBis(A, Voisin, i, j,Tavant)
global dx l rho c_p noeudsVert hc dt Tchauf B lambda
    ksolide=-lambda*dx*l*dt/(rho*c_p*dx*dx*l);      %Coefficient multiplicateur pour la derivée du solide
    kfluide=-dx*dt*l*hc/(rho*c_p*dx*dx*l);               %Coefficient multiplicateur pour la derivée dans le fluide
    
    %% Voisins solide
    if (Voisin(1,1)==0) %Voisin de gauche
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*ksolide/(2*dx);
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+4*ksolide/(2*dx);
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-ksolide/(2*dx);         
    end
    
    if (Voisin(1,2)==0)
        %Voisin du haut
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*ksolide/(2*dx);
        A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))+4*ksolide/(2*dx);
        A(index(i,j),index(i,j-2))=A(index(i,j),index(i,j-2))-ksolide/(2*dx);
    end 
    if (Voisin(1,3)==0)     
        %Voisin du bas 
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))-3*ksolide/(2*dx);
        A(index(i,j),index(i,j+1)) =A(index(i,j),index(i,j+1))+4*ksolide/(2*dx);
        A(index(i,j),index(i,j+2)) =A(index(i,j),index(i,j+2))-ksolide/(2*dx);
    end
    if (Voisin(1,4)==0)     
        %Voisin de droite
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*ksolide/(2*dx);
        A(index(i,j),index(i+1,j)) = A(index(i,j),index(i+1,j))+4*ksolide/(2*dx);
        A(index(i,j),index(i+2,j)) =A(index(i,j),index(i+2,j))-ksolide/(2*dx);
    end
    %A(index(i,j),:)=ksolide.*A(index(i,j),:);
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1; %??
    %B(index(i,j),1)=-Tavant(index(i,j),1);
    %% Voisins fluide
    if (Voisin(1,1)==1)
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*kfluide/2;
        A(index(i,j),index(i+1,j)) = A(index(i,j),index(i+1,j))+kfluide/2;
        %B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
    end
    
    if (Voisin(1,2)==1)
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*kfluide/2;
        A(index(i,j),index(i,j+1)) = A(index(i,j),index(i,j+1))+kfluide/2;
        %B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
    end 
    if (Voisin(1,3)==1)
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*kfluide/2;
        A(index(i,j),index(i,j-1)) = A(index(i,j),index(i,j-1))+kfluide/2;
        %B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
    end
    if (Voisin(1,4)==1)
        A(index(i,j),index(i,j))= A(index(i,j),index(i,j))-3*kfluide/2;
        A(index(i,j),index(i-1,j)) = A(index(i,j),index(i-1,j))+kfluide/2;
        %B(index(i,j),1) = B(index(i,j),1)-kfluide*Tchauf;
    end

end