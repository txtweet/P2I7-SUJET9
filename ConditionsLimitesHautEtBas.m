function A=ConditionsLimitesHautetBas(A,noeudsHor,noeudsVert,matCellule, Tavant, Text)

global B hc dx Tchauf lambdaair hcmurs lambda rho c_p dt Tsol lambdaisolant

 %Conditions en haut du plancher
    for i=1:noeudsHor
        %au niveau du haut du plancher (j=N-2)
        j=noeudsVert-2;
        k1=noeudsVert*(i-1)+j;
        A(k1,k1)=A(k1,k1)+hc+1+2*lambda*dt/(rho*c_p*dx.^2);
        A(k1,k1-1)=A(k1,k1-1)-lambdaair/(2*dx)-lambda*dt/(rho*c_p*dx.^2);
        A(k1,k1+1)=A(k1,k1+1)-hc+lambdaair/(2*dx)-lambda*dt/(rho*c_p*dx.^2);
        B(k1)=Tavant(k1);
        
        %au niveau de l'air (j=N-1) :
        j=noeudsVert-1;
        k2=noeudsVert*(i-1)+j;
        A(k2,k2)=A(k2,k2)+hc+hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
        A(k2,k2-1)=A(k2,k2-1)-lambdaair/(2*dx)-hc-lambda*dt/(rho*c_p*dx.^2);
        A(k2,k2+1)=A(k2,k2+1)+lambdaair/(2*dx)-hcmurs-lambda*dt/(rho*c_p*dx.^2);
        B(k2)=Tavant(k2);
        
        %au niveau des murs (j=N) :
        j=noeudsVert;
        k3=noeudsVert*(i-1)+j;
        A(k3,k3)=A(k3,k3)+2*lambdaair/dx+2*hcmurs+1+2*lambda*dt/(rho*c_p*dx.^2);
        B(k3)=Tavant(k3)+Text*lambda*dt/(rho*c_p*dx.^2)+Text*(hcmurs+lambdaair/dx);
        A(k3,k3-1)=A(k3,k3-1)-lambdaair/dx-hcmurs-lambda*dt/(rho*c_p*dx.^2);
        %A(k3,k3-2)=A(k3,k3-2)+lambda*dt/(rho*c_p*dx.^2);
        
        %au niveau du sous-sol (j=1) :
        j=1;
        %ca marche pas mal en fait
%         k4=noeudsVert*(i-1)+j;
%         A(k4,k4)=A(k4,k4)+hc-lambdaair/dx+1-lambda*dt/(rho*c_p*dx.^2);
%         A(k4,k4+1)=A(k4,k4+1)+hc+lambdaair/dx+lambda*dt/(rho*c_p*dx.^2);
%         A(k4,k4+2)=A(k4,k4+2)-lambda*dt/(rho*c_p*dx.^2);
%         B(k4)=Tavant(k4);


        %Temp cste
        k4=noeudsVert*(i-1)+j;
        A(k4,k4)=A(k4,k4)+1+2*lambdaisolant*dt/(rho*c_p*dx.^2);
        A(k4,k4+1)=A(k4,k4+1)-lambdaisolant*dt/(rho*c_p*dx.^2);
        B(k4)=Tavant(k4)+Tsol*lambdaisolant*dt/(rho*c_p*dx.^2);
        
        %avec egalite des flux
%         A(k4,k4)=lambda/dx+lambdaisolant/dx;
%         A(k4,k4+1)=-lambda/dx;
%         B(k4)=Tsol*lambdaisolant/dx;
    end
end