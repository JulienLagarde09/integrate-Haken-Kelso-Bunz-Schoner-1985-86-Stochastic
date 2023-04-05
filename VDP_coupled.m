% % coupled vdp oscillators (from Izhikevich)
% Phase Dynamics and Synchronization of Relaxation Oscillators
% Sixth SIAM Conference on Applications of Dynamical Systems, Snowbird, Utah, May 2001  
% mu = 0.5;% Relaxation parameter
% a = 1;% Non-uniformity parameter
% eps = 0.2;% Strength of connections
% julien: written here after Liénard's transformation
% https://en.wikipedia.org/wiki/Van_der_Pol_oscillator
% of interest: https://bdtoolbox.org/ (Mickael Breakspear)

function xdot = VDP_coupled(t,x)
global mu a eps omeg

x1=x(1);
y1=x(2);
x2=x(3);
y2=x(4);

xdot = [(x1*(1-x1*x1/3)-(omeg*y1)+eps*x2)/mu; x1;(x2*(1-x2*x2/3)-(omeg*y2)+eps*x1)/mu; a*x2];
