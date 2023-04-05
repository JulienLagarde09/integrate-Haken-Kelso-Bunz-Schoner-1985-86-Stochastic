function phidot=laneqn(t,phi);
a = 1;
b = 0.5;
phidot(1,1) = -a*sin(phi)-b*sin(2*phi);

