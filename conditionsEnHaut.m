function A=conditionsEnHaut(A,L,l,h,lambdaair,lambdamur,e,hcair,hcmur,Tpiece)
%A matrice A
%L et l longueur et largeur du plancher chauffant
%h hauteur de la piece (hauteur d'air)
%lambdaair et lambdamur les conductivites du mur
%e epaisseur des murs et du plafond (idem en 1ere approx)
%hcair et hcmur coefficient d'echanges convectifs air et murs
%Tpiece la temperature de la piece consideree comme homogene mais qui varie
%dans le temps

%cette fonction apporte les conditions aux limites en haut de la piece en
%ne prenant en compte que les echanges dus a la conduction et a la
%convection. La condition etant en haut, on est a j=noeudsVert

%% definition des resistances (comparaison electrique)
Rcondair=h/(L*l*lambdaair); %resistance de l'air a la conduction
Rconvair=1/(hcair*L*l); %resistance de l'air a la convection
Rcondmur=e/(L*l*lambdamur)+2*e/(h*l*lambdamur)+2*e/(h*L*lambdamur); %resistance des murs a la conduction
Rconvmur=1/(L*l*hcmur)+2/(h*l*hcmur)+2/(h*L*hcmur); %resistance des murs a la convection

%% 