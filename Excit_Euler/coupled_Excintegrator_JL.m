% Integration of two coupled Excitator with noise (Langevin).
% This goes beyond the continuous HKB model, as the model, excitator,
% like Fitzhugh Naguno model (FN), contains limit cycle or fixed point + separatrix flows
% dynamics, depending on parameters. This is a model of convergence of
% flows in phase space, that can be quantified by an Euclidean distance
% (See Jirsa Kelso 2005).
% In the fixed point regime a perturbation can make the dynamics crossing
% the separatrix, and return to the fixed point produces an "action
% potential" (FN) or a discrete movement.
% Noise is additive, scaled by time step, and by variance.
% Model from: Viktor Jirsa & Scott Kelso
% Jirsa, V. K., & Scott Kelso, J. A. (2005). The excitator 
% as a minimal model for the coordination dynamics of discrete
% and rhythmic movement generation. Journal of motor behavior, 37(1), 35-51.
% Very nice test of the model's prediction: Philip Fink et al.
% Fink, P. W., Kelso, J. S., & Jirsa, V. K. (2009). 
% Perturbation-induced false starts as a test of 
% the Jirsa-Kelso Excitator model. 
% Journal of motor behavior, 41(2), 147-157.

clear all; close all
% Euler integration parameters
dt = 0.03; % timestep
iters = 10000; %path length
time = [0:dt:iters*dt];
% Model parameters
a = 0.6;
b = 1;
c = 3;
gamma = 1;
% hkb like coupling:
alpha = 0;%-0.2;
beta = 0;%0.5;
% Time points of perturbations
dt1 = 10; dt2 = 30; dt3 = 50; dt4 = 70; dt5 = 90; dt6 = 110;
dt7 = 130; dt8 = 150; dt9 = 170; dt10 = 190; dt11 = 210; dt12 = 230;
% Initial conditions (must be a column)
yin = [2 -0.8 2 -0.8];
% Noise strength of the Langevin equation (stochastic differential eq.)
D = [0.01 0 -0.01 0];

% starts
y = yin; 

 for ii = 1:length(time) % integrate over time
     
            ydot = coupled_excitator_JL(time(ii),y(ii,:),a,b,c,alpha,beta,gamma,dt1,dt2,dt3,...
                dt4,dt5,dt6,dt7,dt8,dt9,dt10,dt11,dt12);
            
               y(ii+1,:) = y(ii,:) + dt*ydot + sqrt(2*D).*randn(size(ydot)).*dt;
            
 end


figure(2)

subplot(3,1,1);
plot(y(:,1),y(:,2),'g')
hold on
plot(y(:,3),y(:,4),'k.')
xlabel('x')
ylabel('y')
title('Excitator with noise')
subplot(3,1,2);
plot(y(:,1),'g.')
hold on
plot(y(:,3),'k.')
ylabel('x')
xlabel('time')




