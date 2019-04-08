function [R,theta]=ChangeCoordEnCyl(x,y)

R=sqrt(x.^2+y.^2);
theta=arctan(y/x);
end