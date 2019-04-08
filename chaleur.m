%% Variables
T0=0;        %Température initiale (en degré Celsius)
D=1;         %Coefficient de diffusivité (en m^2/s)
tf=1;        %Temps de simulation (en secondes)
dt=0.01;     %Pas de temps (en secondes)
Nt=tf/dt;    %Nombre d'itérations de temps

%% Paramètres
dr=0.1;
r=0:dr:10;
dtheta=2*pi/100;
theta=0:dtheta:2*pi;
[X,Y]=ChangeCoordEnCart(r,theta);
[dx,dy]=ChangeCoordEnCart(dr,dtheta);
Nx=floor(10/dx);            %Nombre d'itérations d'espace
Ny=floor(10/dy);
Tp=zeros(Nx+1,Nt+1); %Température en polaire
Tp(:,1)=T0;
Tc=zeros(Nx+1,floor((Nt+1)*(2*pi/dtheta))); %Température en cartésien
Tc(:,1)=T0;
b=10*sin(pi*X').^2; %Taille Nx+1
b(1)=30;
b(Nx+1)=b(Nx+1)+20/dx;
A=diag(ones(1,Nx+1)*(2/(dx^2)))+diag(ones(1,Nx)*(-1/(dx^2)),1)+diag(ones(1,Nx)*(-1/(dx^2)),-1);
A(1,1)=1;
A(1,2)=0;
A(Nx+1,Nx)=-2/(dx^2);

%% Simulation
%figure()
j=1;
for theta=0:dtheta:2*pi
for i=1:Nt
    Tp(:,i+1)=Tp(:,i)+dt*(b-A*Tp(:,i));    %Schéma d'Euler explicite
    Tc(:,j)=Tp(:,i+1);
    j=j+1;
%     plot(X,T(:,i+1));
%     axis([0 1 30 42])
%     drawnow
%     pause(0.01)
end
end

%% Affichage
% figure
% plot(X,T);
% title('Température du matériau à chaque pas de temps en fonction de la position dans la poutre')
% xlabel('Position dans la poutre'),ylabel('Température')
