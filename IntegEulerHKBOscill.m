% stochastic HKB model, 2 oscillators = 4D, and couplings
% initial conditions = antiphase, can change ligne 11
% integraton scheme = Euler method
% bifurcation parameter = omega for frequency
% omega_1 = 1; % antiphase stable
% try also omega_1 = 1.3;% jumps from antiphase to inphase due
% to noise and weaker stability

% use Euler integration with noise: + sqrt(2*D(kk))*randn(size(ydot))*dt
% Higham, D. J. (2001). An algorithmic introduction to numerical simulation of stochastic differential equations. SIAM review, 43(3), 525-546.
% Numerous textbooks (Riske, Platen, Gardiner, Kloeden, Haken)
%% This could be done in Julia: see https://diffeq.sciml.ai/stable/tutorials/sde_example/
% Noise: HKB driven equation becomes a Langevin equation (stochastic differential eq; SDE)
% Euler algo logic:
% starts with initial conditions of state (init; thus t = 1 thus y = init), pass it into the ODE to compute
% the derivatives of the 3 dimensions ydot(:) (dim = 3)
% compute the change in state for the next time step (time(i) with dt*ydot and add
% it to the initial y(i,:) and add the noise, to get the new y(i+1,:), NOTE the time is
% incrementing with the i loop
% you get the first y(1,:) with init, the next y(2,:) with the sequence described above, and you do the loop again:
% pass y(2,:) in the ODE to get ydot etc to get y(3,:)
% etc



%% initial conditions
V1 = 0.3;
V2 = V1 *(-1);% *(-1) for antiphase, *(1) for inphase
xin = [0 V1 0 V2];
%%
% integration parameters
dt = 0.008; % timestep
iters = 50000; %iterations
time = [0:dt:iters*dt];
% noise strength
D = [0.01;0.01;0.01;0.01];

y  = [];
%% parameter controlling frequency
omega_1 = 1.3;
omega_2 = omega_1;% simplest case = symmetric

        y = [];
        y = xin; % Get Correct x & y as initial conditions
        
        
        for ii = 1:length(time) % integrate over time
            
            ydot = coupled_hkb_ode(time(ii),y(ii,:),omega_1,omega_2); ydot = ydot';
            
            y(ii+1,:) = y(ii,:) + dt*ydot + sqrt(2*D(kk))*randn(size(ydot))*dt;

        end % for ii


F_y_2 = y(:,2);% change name, ancient version with filter
F_y_4 = y(:,4);

% estimating phases with Hilbert transform (gives a complex number and take
% the angle of it (in polar coordinate)
ncut = 100; % to get rid of crap due to the algo behing Hilbert(x)
ht = hilbert(F_y_2-mean(F_y_2));
phi1 = angle(ht);% estimation phase 1
phi1 = phi1(ncut:end-ncut);% virage début fin
ht = hilbert(F_y_4-mean(F_y_4));
phi2 = angle(ht);% estimation phase 2
phi2 = phi2(ncut:end-ncut);
phi1 = unwrap(phi1);
phi2 = unwrap(phi2);% unwrap phases

phi_rel = phi1 - phi2;

figure
subplot(3,1,1)
plot(F_y_2,'b')
hold on
plot(F_y_4,'k')
subplot(3,1,2)
% plot(unwrap(phi(y(:,2),y(:,4))));% unwrap phase relative
% hold on
plot(phi_rel,'k');
xlabel('\phi')
axis([0 length(time) -20 20 ])

bin = -7:0.05:7;

subplot(3,3,7)
hist(phi_rel,bin);% histo phase relative
title('phi filtrées')
xlabel('\phi')


phi2 = unwrap(phi2);% unwrap phases
synchroindex_filt = (mean(cos(phi1-phi2)))^2 + (mean(sin(phi1-phi2)))^2;