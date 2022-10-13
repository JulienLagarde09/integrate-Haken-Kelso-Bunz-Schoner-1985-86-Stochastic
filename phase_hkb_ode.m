function phidot=laneqn(phi,a,b)

phidot(1,1) = -a*sin(phi)-2*b*sin(2*phi);
