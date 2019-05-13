%%%%%%%%%%% P2I7 - SUJET 9 %%%%%%%%%%
% Cette fonction apporte les conditions aux limites en haut de la pi�ce en
% ne prenant en compte que les �changes dus � la conduction et � la
% convection. La condition �tant en haut, on est � j=noeudsVert
% Les param�tres d'entr�e sont :
% - A matrice A
% - L et l longueur et largeur du plancher chauffant
% - h hauteur de la pi�ce (hauteur d'air)
% - lambdaair et lambdamur les conductivit�s du mur
% - e �paisseur des murs et du plafond (idem en 1�re approximation)
% - hcair et hcmur coefficient d'�changes convectifs air et murs
% - Tpiece la temperature de la pi�ce consid�r�e comme homog�ne mais qui
%   varie dans le temps
function A=conditionsEnHaut(A,L,l,h,lambdaair,lambdamur,e,hcair,hcmur,Tpiece)
%% D�finition des r�sistances (comparaison �lectrique)
Rcondair=h/(L*l*lambdaair); % r�sistance de l'air � la conduction
Rconvair=1/(hcair*L*l); % r�sistance de l'air � la convection
Rcondmur=e/(L*l*lambdamur)+2*e/(h*l*lambdamur)+2*e/(h*L*lambdamur); % r�sistance des murs � la conduction
Rconvmur=1/(L*l*hcmur)+2/(h*l*hcmur)+2/(h*L*hcmur); % r�sistance des murs � la convection
%%