% simulate two coupled non harmonic oscillators, van der pol (VDP)
% this code integrates the function: VDP_coupled.m
% parameters are passed on via global declaration
% the deviation from harmonic motion is controlled by mu, the relaxation
% parameter,
% the smaller the less harmonic, but also by omega which controls the main
% period of oscillation, for large (20) omega the harmonicity increases
%
% noise is included in the dynamics (Langevin)
% The integration is an Euler- Maruyama scheme (accurate for dt small)
% see Higham DJ 2001 An Algorithmic Introduction to Numerical Simulation of Stochastic Differential Equations
% SIAM Review, 43(3), 525-546
% param noise = sqrt(2*D).*randn(size(xdot)).*dt
% delta correlated, gaussian noise


global mu a eps omeg

tfin=3000;
tau = 0.01;

mu = 0.05;% Relaxation parameter
a = 1;% Non-uniformity parameter
eps = 0.2;% Strength of connections
omeg = 8;

%% initial conditions
V1 = 0.3;
V2 = V1 *(-1);% *(-1) for antiphase, *(1) for inphase
xin = [0 V1 0 V2];
%%
% integration parameters
dt = 0.006; % timestep
iters = 3200; %iterations
time = [0:dt:iters*dt];
% noise strength
D = [0.08];

y = [];
        y = xin; % Get Correct x & y as initial conditions        
        for ii = 1:length(time) % integrate over time            
            ydot = VDP_coupled(time(ii),y(ii,:)); ydot = ydot';            
            y(ii+1,:) = y(ii,:) + dt*ydot + sqrt(2*D)*randn(size(ydot))*dt;
        end % for ii
F_y_2 = y(:,1);
F_y_4 = y(:,3);

figure
subplot(321)
plot(y(:,1),y(:,2))
grid on
xlabel('position'), ylabel('velocity')
subplot(312)
plot(F_y_2,'b')
hold on
plot(F_y_4,'k')
xlabel('time'), ylabel('position')

vec_fre_length = floor(length(F_y_2(100:end))/15);% to take only a part of the DSP

subplot(325)
[vFrequency, vAmplitude] = fastfft(zscore(F_y_2(100:end)), 1/dt, [0]);% use quick and dirty fft based estimation of DSP
plot(vFrequency(1:vec_fre_length),vAmplitude(1:vec_fre_length))
grid on
xlabel('Freq(hz)'), ylabel('power amplitude')