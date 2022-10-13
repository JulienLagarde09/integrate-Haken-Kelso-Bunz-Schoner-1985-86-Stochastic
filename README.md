# integrate-Haken-Kelso-Bunz-1985-Stochastic
Matlab codes to integrate using Euler
Contains 3 systems: 1) HKB relative phase dynamics, 2) HKB coupled oscillators, and 3) one HKB single oscillator driven by a period force, the frequency (pulsation) of which increases in loops
% simulation (numerical integration) equation HKB relative phase dynamics
% euler integration with noise
% Langevin equation
% BTW: a local linearization is the classic Ornstein Uhlenbeck process
% b/a determines stability
% locally reduces to a linear FKP, hence a OU process
% antiphase stable: b/a = 1 to < 0.25 Hz
% deterministic case: bifurcation at a = 4 * b
% 
% use Euler integration with noise: + sqrt(2*D(kk))*randn(size(ydot))*dt
% Higham, D. J. (2001). An algorithmic introduction to numerical simulation of stochastic differential equations. SIAM review, 43(3), 525-546.
% Numerous textbooks (Riske, Platen, Gardiner, Kloeden, Haken)
%% This could be done in Julia: see https://diffeq.sciml.ai/stable/tutorials/sde_example/
% Noise: HKB driven equation becomes a Langevin equation (stochastic differential eq; SDE)
% Euler algo logic:
% starts with initial conditions of state (init; thus t = 1 thus y = init), pass it into the ODE to compute
% the derivatives of the 1 dimensions ydot
% compute the change in state for the next time step (time(i) with dt*ydot and add
% it to the initial y(i,:) and add the noise, to get the new y(i+1,:), NOTE the time is
% incrementing with the i loop
% you get the first y(1,:) with init, the next y(2,:) with the sequence described above, and you do the loop again:
% pass y(2,:) in the ODE to get ydot etc to get y(3,:)
