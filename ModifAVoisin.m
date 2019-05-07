function A=ModifAVoisin(A, B, Voisin, i, j)
global dx l rho cp noeudsVert hc dt Tchauf
    if (Voisin(1,1)=1)
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j)= -1*hc/2;
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)= 1*hc/2;
        B((i-1)*noeudsVert+j)=+hc*dt*dx*Tchauf;
    else
        k=-dx*dt*l/(lambda*cp*dv*2h);
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)= -4*k;
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j)= 3*k;
        A((i-1)*noeudsVert+j,(i+1)*noeudsVert+j)= -1*k;
    end
    if (Voisin(1,2)=1)
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=1 ;
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j+1)=-1;
        %B((i-1)*noeudsVert+j)= Ti ;
    else
        k=-dx*dt*l/lambda*cp*dv;
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j)= -4*k;
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j-1)= 3*k;
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j-2)= -1*k;
    end 
    if (Voisin(1,3)=1)
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=1 ;
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=-1;
        B((i-1)*noeudsVert+j)= ;
    else
        k=-dx*dt*l*lambda/rho*cp*dv;
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j)= -4*k;
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j+1)= 3*k;
        A((i-1)*noeudsVert+j,(i)*noeudsVert+j+2)= -1*k; 
    end
    if (Voisin(1,4)=1)
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=1 ;
        A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)=-1;
        B((i-1)*noeudsVert+j)= ;
    else
        k=-dx*dt*l*lambda/rho*cp*dv;
        A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)= -4*k;
        A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)= 3*k;
        A((i-1)*noeudsVert+j,(i-3)*noeudsVert+j)= -1*k; 
    end   

end