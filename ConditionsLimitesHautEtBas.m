%%%%%%%%%%%%%%%%%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Remplissage de la matrice A aux conditions limites haut et bas %%%
%
% Les paramètres sont : 
% La variable renvoyée est : matrice A
function A=ConditionsLimitesHautEtBas(A,noeudsHor,noeudsVert,matCellule, Tavant, Text)
global B hc dx Tchauf lambdaair hcmurs hcairdalle hcairmurs lambda l rho c_p dt Tsol lambdaisolant lambdamurs lambdasol c_p_murs c_p_air rhomurs rhoair c_p_isolant rhoisolant eisolant esol
for i=1:noeudsHor
    %% Haut du plancher (N-2)
    j=noeudsVert-2;
    ksolidedalle=lambda*dt*dx*l/(rho*c_p*2*dx^2*l);
    kairdalle=hcairdalle*dt*dx*l/(rho*c_p*dx*l);
    %conduction
    if i>2 && i<(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+ksolidedalle;
    end
    if i==1
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-4*ksolidedalle;
        A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+ksolidedalle;
    end
    if i==2
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+ksolidedalle;
    end
    if i==noeudsHor
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-4*ksolidedalle;
        A(index(i,j),index(2,j))=A(index(i,j),index(2,j))+ksolidedalle;
    end
    if i==(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+ksolidedalle;
    end
    %retour dalle
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
    A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-4*ksolidedalle;
    A(index(i,j),index(i,j-2))=A(index(i,j),index(i,j-2))+ksolidedalle;
    % convection air
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kairdalle/2;
    A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-kairdalle;
    A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-kairdalle/2;
    
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1;
    
    %% Air 
    j=noeudsVert-1;
    kcondair=lambdaair*dt*dx*l/(rhoair*c_p_air*2*dx^2*l);
    kairdallecoteair=hcairdalle*dt*dx*l/(rhoair*c_p_air*dx*l);
    kairmur=hcairdalle*dt*dx*l/(rhoair*c_p_air*dx*l);
    if i>2 && i<(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondair;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondair;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondair;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondair;
    end
    if i==1
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-4*kcondair;
        A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))+kcondair;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondair;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondair;
    end
    if i==2
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondair;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+kcondair;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondair;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondair;
    end
    if i==noeudsHor
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondair;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondair;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-4*kcondair;
        A(index(i,j),index(2,j))=A(index(i,j),index(2,j))+kcondair;
    end
    if i==(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondair;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondair;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondair;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondair;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+kcondair;
    end
    %convection murs
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kairmur;
    A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-kairmur;
    % convection dalle
    A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-3*kairdallecoteair/2;
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kairdallecoteair;
    A(index(i,j),index(i,j-2))=A(index(i,j),index(i,j-2))+kairdallecoteair/2;
    
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1;
    
    %% Murs
    j=noeudsVert;
    kcondmur=lambdamurs*dt*dx*l/(rhomurs*c_p_murs*2*dx^2*l);
    kairmurcotemur=hcairdalle*dt*dx*l/(rhomurs*c_p_murs*dx*l);
    if i>2 && i<(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondmur;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondmur;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondmur;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondmur;
    end
    if i==1
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-4*kcondmur;
        A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))+kcondmur;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondmur;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondmur;
    end
    if i==2
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondmur;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+kcondmur;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondmur;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondmur;
    end
    if i==noeudsHor
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondmur;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondmur;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-4*kcondmur;
        A(index(i,j),index(2,j))=A(index(i,j),index(2,j))+kcondmur;
    end
    if i==(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondmur;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondmur;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondmur;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondmur;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+kcondmur;
    end
    %convection murs bas
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kairmurcotemur;
    A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-kairmurcotemur;
    % convection murs haut
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kairmurcotemur;
    
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1;
    
    %% Bas du plancher (j=2, interface avec isolant)
    j=2;
    %ksolidedalle a deja ete defini precedemment
    kisodallecotedalle=2*dt/(rho*c_p*((dx*dx/lambda)+(eisolant*dx/lambdaisolant)));
    if i>2 && i<(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+ksolidedalle;
    end
    if i==1
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-4*ksolidedalle;
        A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+ksolidedalle;
    end
    if i==2
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+ksolidedalle;
    end
    if i==noeudsHor
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-4*ksolidedalle;
        A(index(i,j),index(2,j))=A(index(i,j),index(2,j))+ksolidedalle;
    end
    if i==(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*ksolidedalle;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+ksolidedalle;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*ksolidedalle;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+ksolidedalle;
    end
    %haut (conduction dalle)
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*ksolidedalle;
    A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-4*ksolidedalle;
    A(index(i,j),index(i,j+2))=A(index(i,j),index(i,j+2))+ksolidedalle;
    %flux conduction avec isolant
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kisodallecotedalle;
    A(index(i,j),index(i,j-1))=A(index(i,j),index(i,j-1))-kisodallecotedalle;
    
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1;
    
    %% Isolant (j=1)
    j=1;
    kcondiso=lambdaisolant*dt*dx*l/(rhoisolant*c_p_isolant*2*dx^2*l);
    kisosol=2*dt/(rhoisolant*c_p_isolant*((esol*dx/lambdasol)+(eisolant*dx/lambdaisolant)));
    kisodallecoteiso=2*dt/(rhoisolant*c_p_isolant*((dx*dx/lambda)+(eisolant*dx/lambdaisolant)));
    if i>2 && i<(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondiso;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondiso;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondiso;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondiso;
    end
    if i==1
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))-4*kcondiso;
        A(index(i,j),index(noeudsHor-1,j))=A(index(i,j),index(noeudsHor-1,j))+kcondiso;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondiso;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondiso;
    end
    if i==2
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondiso;
        A(index(i,j),index(noeudsHor,j))=A(index(i,j),index(noeudsHor,j))+kcondiso;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondiso;
        A(index(i,j),index(i+2,j))=A(index(i,j),index(i+2,j))+kcondiso;
    end
    if i==noeudsHor
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondiso;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondiso;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))-4*kcondiso;
        A(index(i,j),index(2,j))=A(index(i,j),index(2,j))+kcondiso;
    end
    if i==(noeudsHor-1)
        %gauche
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i-1,j))=A(index(i,j),index(i-1,j))-4*kcondiso;
        A(index(i,j),index(i-2,j))=A(index(i,j),index(i-2,j))+kcondiso;
        %droite
        A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+3*kcondiso;
        A(index(i,j),index(i+1,j))=A(index(i,j),index(i+1,j))-4*kcondiso;
        A(index(i,j),index(1,j))=A(index(i,j),index(1,j))+kcondiso;
    end
    %flux conduction avec dalle
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kisodallecoteiso;
    A(index(i,j),index(i,j+1))=A(index(i,j),index(i,j+1))-kisodallecoteiso;
    %flux conduction avec sol
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+kisosol;
    
    A(index(i,j),index(i,j))=A(index(i,j),index(i,j))+1;
    
end

end