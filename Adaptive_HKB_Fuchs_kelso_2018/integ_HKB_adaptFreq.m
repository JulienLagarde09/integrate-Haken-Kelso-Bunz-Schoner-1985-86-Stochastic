
% integrate HKB coupled oscillators
% with adpative freq as in Nordham et al. 2018
% Nordham, C. A., Tognoli, E., Fuchs, A., & Kelso, J. S. (2018).
% How interpersonal coordination affects individual behavior 
% (and vice versa): experimental analysis and adaptive HKB model of
% social memory. Ecological Psychology, 30(3), 224-249.

% off/on/off coupling as in the Oullier et al. and Tognoli et al. experiment
% param HKB coupling and adaptive dyn turned off/on as a function of time in
% the ODE fct
% if t<1/3 length(time) , coupling and adapt stength = 0
% if t>=1/3<2/3length(time) , coupling and adapt stength = 1
% if t>=2/3 length(time) , coupling and adapt stength = 0
% The adaptation is proposed like this:
% CHI is turned on & off (1,0)
% xdot(5) = CHI * epsi1 * x(1)*x(4);
% xdot(6) = CHI * epsi2 * x(3)*x(2);
% solutions x(5) and x(6) are squared and serve in HKB as stiffness parameters: coef of
% position:
% For the first oscillator: [ - (x(5)^2) * x(2)], (x(5)^2) instead of a constant coef
% omega squared in original HKB


clear all
close all

time = [0 400];
global A1 A2 trial_duration epsi1 epsi2; % coupling parameters manipulated in
% Nordham et al. 2018 (labelled A1 and A2 in the paper, previous papers
% labelled alpha)
A1 = -2;
A2 = -2;
trial_duration = time(end);
epsi1 = 0.01; % strength of adaptive dynamics of freq
epsi2 = 0.01; % idem oscill 2
% initial conditions (x(n) and omega
omega1 = 1.75; % initial "freq param"
omega2 = 2; % idem oscill 2
init = [0.5 0.5 0.5 0.5 omega1 omega2];


[t,x] = ode45('coupled_hkb_ode_adaptFreq',time,init);

  scrsz = get(0,'ScreenSize'); 
figure('Position',[1 scrsz(4)/3 scrsz(3) scrsz(4)/2])
 
subplot(4,2,1);
 plot(x(:,2),x(:,1),'b.');
 hold on;
 plot(x(:,4),x(:,3),'.r');
 title('phase portrait');
 
 subplot(4,1,2);
 plot(t,x(:,2),'b.-');
 hold on;
 plot(t,x(:,4),'.r');
 title('time series positions');
 
 subplot(4,1,3);
 plot(t,phi(x(:,2),x(:,4)),'k.');
title('phase difference');
 
 subplot(4,1,4);
plot(t,x(:,5),'r')
hold on
plot(t,x(:,6),'k')
title('freq propre dynamics')
ylim([1.5 2.5])