%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
% Cette fonction apporte les conditions aux limites en haut de la pièce en
% ne prenant en compte que les échanges dus à la conduction et à la
% convection. La condition étant en haut, on est à j=noeudsVert
% Les paramètres d'entrée sont :
% - A matrice A
% - L et l longueur et largeur du plancher chauffant
% - h hauteur de la pièce (hauteur d'air)
% - lambdaair et lambdamur les conductivités du mur
% - e épaisseur des murs et du plafond (idem en 1ère approximation)
% - hcair et hcmur coefficient d'échanges convectifs air et murs
% - Tpiece la temperature de la pièce considérée comme homogène mais qui
%   varie dans le temps
function A=conditionsEnHaut(A,L,l,h,lambdaair,lambdamur,e,hcair,hcmur,Tpiece)
%% Définition des résistances (comparaison électrique)
Rcondair=h/(L*l*lambdaair); % résistance de l'air à la conduction
Rconvair=1/(hcair*L*l); % résistance de l'air à la convection
Rcondmur=e/(L*l*lambdamur)+2*e/(h*l*lambdamur)+2*e/(h*L*lambdamur); % résistance des murs à la conduction
Rconvmur=1/(L*l*hcmur)+2/(h*l*hcmur)+2/(h*L*hcmur); % résistance des murs à la convection
%%