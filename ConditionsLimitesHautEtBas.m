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
%         %B(k1)=Tavant(k1);
        
        A(k1,k1-1)=2*lambda*dt/(rho*c_p*dx^2);
        A(k1,k1-2)=-lambda*dt/(rho*c_p*dx^2);
        A(k1,k1+1)=hcairdalle*dt/(rho*c_p);
        if i>1 && i<noeudsVert
            A(k1+1,k1)=-lambda*dt/(rho*c_p*dx^2);
            A(k1-1,k1)=-lambda*dt/(rho*c_p*dx^2);
            A(k1,k1)=1-hcairdalle*dt/(rho*c_p)+lambda*dt/(rho*c_p*dx^2);
        end
        if i==1
            A(k1+1,k1)=2*lambda*dt/(rho*c_p*dx^2);
            A(k1+2,k1)=-lambda*dt/(rho*c_p*dx^2);
            A(k1,k1)=1-hcairdalle*dt/(rho*c_p)-2*lambda*dt/(rho*c_p*dx^2);
        end
        if i==noeudsVert
            A(k1-1,k1)=2*lambda*dt/(rho*c_p*dx^2);
            A(k1,k1)=1-hcairdalle*dt/(rho*c_p)-2*lambda*dt/(rho*c_p*dx^2);
            A(k1-2,k1)=-lambda*dt/(rho*c_p*dx^2);
        end
        
        %% Au niveau de l'air (j=N-1) :
        j=noeudsVert-1;
        k2=noeudsVert*(i-1)+j;
%         A(k2,k2)=A(k2,k2)+hc+hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
%         A(k2,k2-1)=A(k2,k2-1)-lambdaair/(2*dx)-hc-lambda*dt/(rho*c_p*dx.^2);
%         A(k2,k2+1)=A(k2,k2+1)+lambdaair/(2*dx)-hcmurs-lambda*dt/(rho*c_p*dx.^2);
%          B(k2)=Tavant(k2);

        
        A(k2,k2-1)=-hcairdalle*dt/(rhoair*c_p_air);
        A(k2,k2+1)=hcairmurs*dt/(rhoair*c_p_air);
        if i>1 && i<noeudsVert
            A(k2,k2)=1+hcairdalle*dt/(rhoair*c_p_air)-hcairmurs*dt/(rhoair*c_p_air)+2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(k2+1,j)=-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(k2-1,j)=lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        if i==1
            A(k2,k2)=1+hcairdalle*dt/(rhoair*c_p_air)-hcairmurs*dt/(rhoair*c_p_air)-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(k2+1,j)=2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(k2+2,j)=-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        if i==noeudsVert
            A(k2,k2)=1+hcairdalle*dt/(rhoair*c_p_air)-hcairmurs*dt/(rhoair*c_p_air)-lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(k2-1,j)=2*lambdaair*dt/(rhoair*c_p_air*dx^2);
            A(k2-2,j)=-lambdaair*dt/(rhoair*c_p_air*dx^2);
        end
        
        %% Au niveau des murs (j=N) :
        j=noeudsVert;
        k3=noeudsVert*(i-1)+j;
        %A(k3,k3)=A(k3,k3)+2*lambdaair/dx+2*hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
        A(k3,k3)=A(k3,k3)+2*lambdaair/dx+2*hcmurs;
        A(k3,k3-1)=A(k3,k3-1)-lambdaair/dx;
        %B(k3)=Tavant(k3)+Text*lambda*dt/(rho*c_p*dx.^2)+Text*(hcmurs+lambdaair/dx);
        %A(k3,k3-1)=A(k3,k3-1)-lambdaair/dx-hcmurs-lambda*dt/(rho*c_p*dx.^2);
        %A(k3,k3-2)=A(k3,k3-2)+lambda*dt/(rho*c_p*dx.^2);
        
        %conduction dans les murs (horizontalement)
        if i>1 && i<noeudsHor
            A(k3,k3)=A(k3,k3)+1-2*lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(k3+1,k3)=A(k3+1,k3)-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            A(k3-1,k3)=A(k3-1,k3)-lambdamurs*dt/(rhomurs*c_p_murs*dx.^2);
            %B(k3)=B(k3)+Tavant(k3);
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
        A(k4,k4)=A(k4,k4)-(1/(lambdaisolant+lambdasol)+1/(lambdaisolant+lambda));
        A(k4,k4+1)=A(k4,k4+1)+1/(lambdaisolant+lambda);
        %B(k4)=B(k4)-Tsol/(lambdaisolant+lambdasol);
        %conditions de conduction horizontale pour l'isolant
        if i~=1 && i~=noeudsHor
            A(k4,k4)=A(k4,k4)+1-2*lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            A(k4+1,k4)=A(k4+1,k4)-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            A(k4-1,k4)=A(k4-1,k4)-lambdaisolant*dt/(rhoisolant*c_p_isolant*dx.^2);
            %B(k4)=B(k4)+Tavant(k4);
        end
        

        %AUTRE VERSION 
%         A(k4,k4)=
    end
end