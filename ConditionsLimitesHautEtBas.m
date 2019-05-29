function A=ConditionsLimitesHautetBas(A,noeudsHor,noeudsVert,matCellule, Tavant, Text)

global B hc dx Tchauf lambdaair hcmurs hcairdalle hcairmurs lambda rho c_p dt Tsol lambdaisolant lambdamurs lambdasol c_p_murs c_p_air rhomurs rhoair c_p_isolant rhoisolant

 %Conditions en haut du plancher
    for i=1:noeudsHor
        %% Au niveau du haut du plancher (j=N-2)
        j=noeudsVert-2;
        k1=noeudsVert*(i-1)+j;
%         A(k1,k1)=A(k1,k1)+hc+1+2*lambda*dt/(rho*c_p*dx.^2);
%         A(k1,k1-1)=A(k1,k1-1)-lambdaair/(2*dx)-lambda*dt/(rho*c_p*dx.^2);
%         A(k1,k1+1)=A(k1,k1+1)-hc+lambdaair/(2*dx)-lambda*dt/(rho*c_p*dx.^2);
        %B(k1)=Tavant(k1);
        
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+3*hcairdalle*dt/(2*rho*c_p)-3*lambda*dt/(rho*c_p*dx^2);
        A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))+2*lambda*dt/(rho*c_p*dx^2)-hcairdalle*dt/(rho*c_p);
        A(index(i,j),index(i,j-2))=A(index(i,j),index(i,j-2))-lambda*dt/(rho*c_p*dx^2);
        A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-hcairdalle*dt/(rho*c_p);
        if i>2 && i<(noeudsHor-1)
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
%             A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+hcairdalle*dt/(rho*c_p)+lambda*dt/(rho*c_p*dx^2);
        end
        %conditions periodiques et pas de derivee decentree
        if i==2
            %A(index(1,j),index(2,j))=A(index(1,j),index(2,j))-lambda*dt/(rho*c_p*dx^2);
            %A(index(1,j),index(noeudsHor,j))=A(index(1,j),index(noeudsHor,j))-lambda*dt/(rho*c_p*dx^2);
            %A(index(1,j),index(1,j))=A(index(1,j),index(1,j))+1+hcairdalle*dt/(rho*c_p)+2*lambda*dt/(rho*c_p*dx^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
        end
        if i==1
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
        end
        %conditions periodiques et pas de derivee decentree
        if i==noeudsHor-1
            %A(index(noeudsHor,j),index(noeudsHor-1,j))=A(index(noeudsHor,j),index(noeudsHor-1,j))-lambda*dt/(rho*c_p*dx^2);
            %A(index(noeudsHor,j),index(noeudsHor,j))=A(index(noeudsHor,j),index(noeudsHor,j))+1+hcairdalle*dt/(rho*c_p)+lambda*dt/(rho*c_p*dx^2);
            %A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambda*dt/(rho*c_p*dx^2);
        end
        if i==noeudsHor
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambda*dt/(rho*c_p*dx^2);
        end
        
        %% Au niveau de l'air (j=N-1) :
        j=noeudsVert-1;
        k2=noeudsVert*(i-1)+j;
%         A(k2,k2)=A(k2,k2)+hc+hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
%         A(k2,k2-1)=A(k2,k2-1)-lambdaair/(2*dx)-hc-lambda*dt/(rho*c_p*dx.^2);
%         A(k2,k2+1)=A(k2,k2+1)+lambdaair/(2*dx)-hcmurs-lambda*dt/(rho*c_p*dx.^2);

%          B(k2)=Tavant(k2);

        
        A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-3*hcairdalle*dt/(2*rhoair*c_p_air);
        A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-hcairmurs*dt/(rhoair*c_p_air);
        A(index(i,j),index(i,j-2))=A(index(i,j),index(i,j-2))+hcairdalle*dt/(rhoair*c_p_air);
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+hcairdalle*dt/(rhoair*c_p_air)+hcairmurs*dt/(rhoair*c_p_air)-2*lambdaair*dt/(rhoair*c_p_air*dx^2);
        if i>2 && i<(noeudsHor-1)
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        if i==2
            %A(index(1,j),index(1,j))=A(index(1,j),index(i,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            %A(index(1,j),index(2,j))=A(index(1,j),index(2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            %A(index(1,j),index(noeudsHor,j))=A(index(1,j),index(noeudsHor,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        if i==1
            A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        if i==noeudsHor-1
            %A(index(noeudsHor,j),index(noeudsHor,j))=A(index(noeudsHor,j),index(noeudsHor,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            %A(index(noeudsHor,j),index(noeudsHor-1,j))=A(index(noeudsHor,j),index(noeudsHor-1,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            %A(index(noeudsHor,j),index(1,j))=A(index(noeudsHor,j),index(1,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        if i==noeudsHor
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end

         %B(k2)=Tavant(k2);

        
        %% Au niveau des murs (j=N) :
        j=noeudsVert;
        k3=noeudsVert*(i-1)+j;
        %A(k3,k3)=A(k3,k3)+2*lambdaair/dx+2*hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1-2*lambdamurs*dt/(rhomurs*c_p_murs*dx^2)-hcairmurs*dt/(rhomurs*c_p_murs)-hcairmurs*dt/(rhomurs*c_p_murs);
        A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))+hcairmurs*dt/(rhomurs*c_p_murs);
        %B(k3)=Tavant(k3)+Text*lambda*dt/(rho*c_p*dx.^2)+Text*(hcmurs+lambdaair/dx);
        %A(k3,k3-1)=A(k3,k3-1)-lambdaair/dx-hcmurs-lambda*dt/(rho*c_p*dx.^2);
        %A(k3,k3-2)=A(k3,k3-2)+lambda*dt/(rho*c_p*dx.^2);
        
        %conduction dans les murs (horizontalement)
        if i>2 && i<(noeudsHor-1)
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            %B(k3)=B(k3)+Tavant(k3);
        end
        
       if i==2
            %A(index(1,j),index(1,j))=A(index(1,j),index(1,j))+1+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            %A(index(1,j),index(2,j))=A(index(1,j),index(2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            %A(index(1,j),index(noeudsHor,j))=A(index(1,j),index(noeudsHor,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
        end
        if i==1
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
        end
        
       if i==noeudsHor-1
            %A(index(noeudsHor,j),index(noeudsHor,j))=A(index(noeudsHor,j),index(noeudsHor,j))+1+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            %A(index(noeudsHor,j),index(1,j))=A(index(noeudsHor,j),index(1,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            %A(index(noeudsHor,j),index(noeudsHor-1,j))=A(index(noeudsHor,j),index(noeudsHor-1,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
        end
        if i==noeudsHor
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
        end
        
        %% Au niveau du sous-sol (j=1) :
%         j=1;
        %ca marche pas mal en fait
%         k4=noeudsVert*(i-1)+j;
%         A(k4,k4)=A(k4,k4)+hc-lambdaair/dx+1-lambda*dt/(rho*c_p*dx.^2);
%         A(k4,k4+1)=A(k4,k4+1)+hc+lambdaair/dx+lambda*dt/(rho*c_p*dx.^2);
%         A(k4,k4+2)=A(k4,k4+2)-lambda*dt/(rho*c_p*dx.^2);
%         B(k4)=Tavant(k4);


        %Temp cste
%         k4=noeudsVert*(i-1)+j;
%         A(k4,k4)=A(k4,k4)+1+2*lambdaisolant*dt/(rho*c_p*dx.^2);
%         A(k4,k4+1)=A(k4,k4+1)-lambdaisolant*dt/(rho*c_p*dx.^2);
%         B(k4)=Tavant(k4)+Tsol*lambdaisolant*dt/(rho*c_p*dx.^2);
        
        %avec egalite des flux
%         A(k4,k4)=lambda/dx+lambdaisolant/dx;
%         A(k4,k4+1)=-lambda/dx;
%         B(k4)=Tsol*lambdaisolant/dx;
        
        %avec resistances et bilan des flux au niveau de l'isolant
        j=1;
        k4=noeudsVert*(i-1)+j;
        %A(k4,k4)=A(k4,k4)-(1/(lambdaisolant+lambdasol)+1/(lambdaisolant+lambda));
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*(lambda+lambdaisolant)*dt/(rhoisolant*c_p_isolant*dx^2)+2*(lambdasol+lambdaisolant)*dt/(rhoisolant*c_p_isolant*dx^2)-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
        %A(k4,k4+1)=A(k4,k4+1)+1/(lambdaisolant+lambda);
        A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-2*(lambda+lambdaisolant)*dt/(rhoisolant*c_p_isolant*dx^2);
        %B(k4)=B(k4)-Tsol/(lambdaisolant+lambdasol);
        %conditions de conduction horizontale pour l'isolant
        if i>2 && i<(noeudsHor-1)
            %A(k4,k4)=A(k4,k4)+1+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %A(k4+1,k4)=A(k4+1,k4)-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %A(k4-1,k4)=A(k4-1,k4)-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            %B(k4)=B(k4)+Tavant(k4);
        end
        if i==2
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
        end
        if i==1
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2); 
        end
        if i==noeudsHor-1
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
       end
        if i==noeudsHor
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
        end

        %AUTRE VERSION 
        %A(k4,k4)=
        
        %% Au niveau du bas du plancher (j=2)
        j=2;
        A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))+2*lambda*dt/(rho*c_p*dx^2);
        A(index(i,j),index(i,j+2))=A(index(i,j),index(i,j+2))-lambda*dt/(rho*c_p*dx^2);
        A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-2*(lambda+lambdaisolant)*dt/(rho*c_p*dx^2);
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1-3*lambda*dt/(rho*c_p*dx^2)+2*(lambda+lambdaisolant)*dt/(rho*c_p*dx^2);
        %conduction dans la dalle
        if i>2 && i<(noeudsHor-1)
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*lambda*dt/(rho*c_p*dx^2)-lambda*dt/(rho*c_p*dx^2)+2*(lambda+lambdaisolant)*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
        end
        if i==2
            A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*lambda*dt/(rho*c_p*dx^2)-lambda*dt/(rho*c_p*dx^2)+2*(lambda+lambdaisolant)*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambda*dt/(rho*c_p*dx^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambda*dt/(rho*c_p*dx^2);
        end
        if i==1
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambda*dt/(rho*c_p*dx^2);
        end
        
        if i==noeudsHor-1
            %A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1+2*lambda*dt/(rho*c_p*dx^2)-lambda*dt/(rho*c_p*dx^2)+2*(lambda+lambdaisolant)*dt/(rho*c_p*dx^2);
            %A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambda*dt/(rho*c_p*dx^2);
            %A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-lambda*dt/(rho*c_p*dx^2);
            
            A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
        end
        if i==noeudsHor
            A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
            A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
        end
    end
    
    %% CONDITIONS PERIODIQUES
%     %% Au niveau du haut du plancher (j=N-2)
%     j=noeudsVert-2;
%     i=2;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
%     i=1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
%     i=noeudsHor-1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambda*dt/(rho*c_p*dx^2);
%     i=noeudsHor;
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambda*dt/(rho*c_p*dx^2);
%     %% Au niveau de l'air (j=N-1)
%     j=noeudsVert-1;
%     i=2;
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     i=1;
%     A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     i=noeudsHor-1;
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     i=noeudsHor;
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
%     A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambdaair*dt/(rhoair*c_p_air*dx^2);
%     %% Au niveau des murs (j=N)
%     j=noeudsVert;
%     i=2;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     i=1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     i=noeudsHor-1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     i=noeudsHor;
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
%     %% Au niveau du sous-sol (j=1)
%     j=1;
%     i=2;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     i=1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2); 
%     i=noeudsHor-1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     i=noeudsHor;
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx^2);
%     %% Au niveau du bas du plancher (j=2)
%     j=2;
%     i=2;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-lambda*dt/(rho*c_p*dx^2);
%     i=1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))-lambda*dt/(rho*c_p*dx^2);
%     i=noeudsHor-1;
%     A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
%     i=noeudsHor;
%     A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(2,j))=A(index(i,j),index(2,j))-lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))+2*lambda*dt/(rho*c_p*dx^2);
%     A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))-lambda*dt/(rho*c_p*dx^2);
%     
end