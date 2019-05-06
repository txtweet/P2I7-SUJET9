function A=matriceA(noeudsHor,noeudsVert,matCellule)
global B hc dx dy Tchauf
A=zeros(noeudsHor*noeudsVert, noeudsHor*noeudsVert);
%A=-h²Laplacien de T

    for i=2:noeudsHor-1
    for j=2:noeudsVert-1
        if (matCellule(i,j)==0)
            if(matCellule(i-1,j)==0 && matCellule(i+1,j)==0 && matCellule(i,j+1)==0 && matCellule(i,j-1)==0)
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=4;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j+1))=-1;
                A((i-1)*noeudsVert+j,(i-1)*noeudsVert+(j-1))=-1;
                A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)=-1;
                A((i-1)*noeudsVert+j,(i)*noeudsVert+j)=-1;
            elseif (matCellule(i,j+1)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dy*hc;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j-1)=-4;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j-2)=1;
                    B((i-1)*noeudsVert+j,1)=2*dy*hc*Tchauf;
            elseif (matCellule(i,j-1)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dy*hc;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j+1)=-4;
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j+2)=1;
                    B((i-1)*noeudsVert+j,1)=2*dy*hc*Tchauf;
            elseif (matCellule(i+1,j)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dx*hc;
                    A((i-1)*noeudsVert+j,(i-2)*noeudsVert+j)=-4;
                    A((i-1)*noeudsVert+j,(i-3)*noeudsVert+j)=1;
                    B((i-1)*noeudsVert+j,1)=2*dx*hc*Tchauf;
            elseif (matCellule(i-1,j)==1)
                    A((i-1)*noeudsVert+j,(i-1)*noeudsVert+j)=3-2*dx*hc;
                    A((i-1)*noeudsVert+j,(i)*noeudsVert+j)=-4;
                    A((i-1)*noeudsVert+j,(i+1)*noeudsVert+j)=1;
                    B((i-1)*noeudsVert+j,1)=2*dx*hc*Tchauf;
            end 
        end
    end 
        
    for j=2:noeudsVert-1
        A(j,j)=4;
        A(j,(j+1))=-1;
        A(j,(j-1))=-1;
        A(j,(noeudsHor-1)*noeudsVert+j)=-1;
        A(j,noeudsVert+j)=-1;
    end 
    for j=2:noeudsVert-1
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+j)=4;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j+1))=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-1)*noeudsVert+(j-1))=-1;
        A((noeudsHor-1)*noeudsVert+j,j)=-1;
        A((noeudsHor-1)*noeudsVert+j,(noeudsHor-2)*noeudsVert+j)=-1;
    end 
 
end
    