function xdot = coupled_hkb_ode(t,x,omega_1,omega_2)
% bimanual rhythmic HKB

% notation matricielle
% x(2) est la dérivée de x(1),
% la dérivée de x(1) est la dérivée
% seconde de x(2)
% donc ds équation diff d'ordre 2 initiale,
% x(2) correspond à la position

% global K;
% global omega;

% oscillator parameters
gamma = 1;% VDP, epsi in Fuchs', == 1
delta = 1;% Rayleigh, also delta in Fuchs' book notation
epsi = - 0.7;% negative linear damping,  gamma in Fuchs
% omega_1 = 1.5;% freq
% omega_2 = 1.5;% freq
% coupling parameters
alpha = - 0.2;
beta = 0.3;


xdot(1) = - delta * x(1)^3 - (omega_1^2) * x(2) - ...
    gamma * x(1) * x(2)^2 - epsi * x(1) + ((x(1) - x(3)) * (alpha + beta * (x(2) - x(4))^2)); 

xdot(2) = x(1);


xdot(3) = - delta * x(3)^3 - (omega_2^2) * x(4) - ...
    gamma * x(3) * x(4)^2 - epsi * x(3) + ((x(3) - x(1)) * (alpha + beta * (x(4) - x(2))^2)); 

xdot(4) = x(3);



xdot = xdot';