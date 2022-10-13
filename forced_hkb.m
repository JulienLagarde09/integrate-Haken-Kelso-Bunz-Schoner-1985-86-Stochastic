function xdot = forced_hkb_ode(F,puls,t,x)
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
gamma = 1;% VDP
delta = 1;% Rayleigh
epsi = - 0.7;% negative linear damping
omega = 1.5;% freq
% driving param
cible = 1;%0.3/2*pi;% freq cible


xdot(1) = - delta * x(1)^3 - (omega^2) * x(2) - ...
    gamma * x(1) * x(2)^2 - epsi * x(1) + F*(sin(puls*x(3))); 

xdot(2) = x(1);

xdot(3) = cible;

xdot = xdot';

