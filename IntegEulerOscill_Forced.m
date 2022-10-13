clear all
close all
scrsz = get(0,'ScreenSize');

% integration of driven single oscillator HKB type
% the ODE is forced_hkb.m
% for 2 strength of forcing we vary the frequency of forcing
%
% use the function phi.m to estimate the relative phase
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
% INPUTS:
% drive strength (F), and pulsation (puls), then time of integration, and y(i,:)
% OUTPUTS: y(1:3):
% y(1) = velocity (y1 = dy2/dt; thus dy1/dt = acceleration thus integration gives y1 velocity)
% y(2) = position 
% y(3) = time given by integrating a constant, then used the puls*t, puls = pulsation
%
% figure: time series position and drive
% relative phase position-drive
% histogram of relative phase
% I took cos(puls*y(:,3)) for the drive CHECK if it is sin(y(3,:)) or
% cos(y(3,:)) or -cos(y(3,:))

% frequency (pulsation) of the drive
puls = 0.2*(2*pi);
% strength of the drive
F1 = 0.2; 
F2 = F1/2;
init = [0 -0.3 0];
dt = 0.01; % timestep
iters = 20000; %iterations
time = [0:dt:iters*dt];

D = [0.06;0;0;0]; %noise strength
y  = [];% reset in case
freq_range = linspace(0.2*(2*pi),0.3*(2*pi),30);

% _______________________________________________________________________
% with strength of forcing F1

for freq = 1:20 %

        y = [];
        y = init; % IC        
        puls = freq_range(freq);
        
        for i = 1:length(time) % integrate over time
            
            ydot = forced_hkb(F1,puls,time(i),y(i,:)); ydot = ydot';
            
            y(i+1,:) = y(i,:) + dt*ydot + sqrt(2*D(1))*randn(size(ydot))*dt;            

        end 
   phaserel = phi(y(1000:end-1000,2),sin(puls*y(1000:end-1000,3)));
   dispPhas_F1(freq) = (mean(cos(phaserel)))^2 + (mean(sin(phaserel)))^2;
   meanPhas_F1(freq) = atan2(mean(sin(phaserel)),mean(cos(phaserel)));

%    dispPhas_2(freq) = 1/length(phaserel)*abs(sum(exp(i*phaserel)));
% plottig while the freq loop is runing
% figure('Position',[500 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
% subplot(3,1,1);
% plot(y(:,1),'k');
% hold on;
% plot(sin(puls*y(:,3)),'r');
% subplot(3,1,2);
% plot(unwrap(phi(y(:,2),sin(puls*y(:,3)))));
% % axis([0 length(time) -5 5 ]);
% subplot(3,2,5);
% bin = -3.14:0.05:3.14;
% hist(phi(y(1000:end-1000,2),sin(puls*y(1000:end-1000,3))),bin);
% grid on
% pause(0.1)
% close
end

% _______________________________________________________________________
% with strength of forcing F2

for freq = 1:20

        y = [];
        y = init; % IC        
        puls = freq_range(freq);
        
        for i = 1:length(time) % integrate over time
            
            ydot = forced_hkb(F2,puls,time(i),y(i,:)); ydot = ydot';
            
            y(i+1,:) = y(i,:) + dt*ydot + sqrt(2*D(1))*randn(size(ydot))*dt;            

        end 
   phaserel = phi(y(1000:end-1000,2),sin(puls*y(1000:end-1000,3)));
   dispPhas_F2(freq) = (mean(cos(phaserel)))^2 + (mean(sin(phaserel)))^2;
   meanPhas_F2(freq) = atan2(mean(sin(phaserel)),mean(cos(phaserel)));
%    dispPhas_2(freq) = 1/length(phaserel)*abs(sum(exp(i*phaserel)));
   
% plottig while the freq loop is runing
figure('Position',[500 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
subplot(3,1,1);
plot(y(:,1),'k');
hold on;
plot(sin(puls*y(:,3)),'r');
subplot(3,1,2);
% plot(unwrap(phi(y(:,1),sin(puls*y(:,3)))));
plot((phi(y(:,2),sin(puls*y(:,3)))));

% axis([0 length(time) -5 5 ]);
subplot(3,2,5);
bin = -3.14:0.05:3.14;
hist(phi(y(1000:end-1000,2),sin(puls*y(1000:end-1000,3))),bin);
grid on
pause(0.3)
close
end

figure('Position',[500 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);
subplot(2,2,1)
plot(dispPhas_F1,'o')
hold on
plot(dispPhas_F2,'*')
grid on
xlabel('Frequency drive scaling')
ylabel('1 - dispersion phase')

title('Dispersion phase difference, O -> forcing = 1, * -> forcing = 0.5')
subplot(2,2,2)
plot(meanPhas_F1,'o')
hold on
plot(meanPhas_F2,'*')
grid on
xlabel('Frequency drive scaling')
ylabel('mean phase')
title('Mean phase difference, O -> forcing = 1, * -> forcing = 0.5')

