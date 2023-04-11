function xdot = coupled_hkb_ode_adaptFreq(t,x)
% bimanual rhythmic HKB

% variables d'états des oscillateurs :
% explication pour le premier des oscillateurs (eq (1 & 2))
% L'équation initiale est du second ordre (accélération)
% on utilise une nouvelle variable, x(2)
% définit par eq(2) : xdot(2) = x(1)
% qui permet de réécrire HKB avec seulement des dérivées de premier ordre
% x(1) est la dérivée de x(2), donc
% la dérivée de x(1) est la dérivée
% seconde de x(2), càd : dx1/dt = accélération = "xdot(1)"
% xdot(1) = accélération
% xdot(2) = vitesse = aussi x(1)
% càd : x(1) = vitesse
% x(2) = position
% paramètres :
% delta = coef de Raleigh = facteur (x(1)cubic) dans Nordham et al. 2018 beta
% gamma = coef de VDP = facteur(x(1).x(2)carré) Nordham et al. 2018 alpha
% epsi = coef de raideur = facteur x(1) Nordham et al. 2018 gamma
%

% Adaptation fréquences :
% on agit sur le paramètre identifié classiquement par "omega"
% Nb: L'usage de cette lettre vient de l'équation d'onde
% dans laquelle omega est la pulsation (rad/sec)
% x(t) = A.cos(omega.t +phi)
% pour avoir l'accélération (origine = système mécanique, d'où on a inertie
% et  forces, donc accélération seconde loi Newton) :
% on dérive cos() et on multiplie par omega (dérivation fct composées
% dérivée de F(G(x) : la fct F contient la fct G qui est fct de x, ici
% (Nb : dans l'équation d'onde notre x est le temps noté t)
% F = cos()
% G = omega.t + phi
% dérivée de F(G(x) = dérivée de G par rapport à t * dérivée de F par rapport à G
% Vitesse: dx/dt = - omega.A.sin(omega.t+phi)
% rebelote :
% Accélération: d2x/dt2 = omega.omega.A*(cos.t+phi)
% d'où l'apparition d'un omega carré

% oscillator parameters
gamma = 2;% VDP
delta = 1;% Rayleigh
epsi = 2;% negative linear damping
% Second coupling parameter
B = 0.5;

global A1 A2 trial_duration epsi1 epsi2;

if t < 1/3*trial_duration
    CHI = 0;
else if t >= 1/3*trial_duration && t < 2/3*trial_duration
        CHI = 1;
    else CHI = 0;  
    end % if condition : CHI changes with time
end

% CHI = 1;

xdot(1) = - delta * x(1)^3 - (x(5)^2) * x(2) - gamma * x(1) * x(2)^2 ...
+ epsi * x(1) + CHI  * (A1 + B * (x(2) - x(4))^2)*(x(1) - x(3)); % eq (1)

xdot(2) = x(1); % eq(2)


xdot(3) = - delta * x(3)^3 - (x(6)^2) * x(4) - gamma * x(3) * x(4)^2 ...
    + epsi * x(3) + CHI  * (A2 + B * (x(4) - x(2))^2)*(x(3) - x(1)); 

xdot(4) = x(3);

xdot(5) = CHI * epsi1 * x(1)*x(4);
xdot(6) = CHI * epsi2 * x(3)*x(2);


xdot = xdot';

