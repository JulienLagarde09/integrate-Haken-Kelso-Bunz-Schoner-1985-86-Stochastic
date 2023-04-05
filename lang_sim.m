close all
clear all

%% integrate the order parameter HKB equation, phi rel
%% calls laneqn.m
%% this is a Langevin equation (or SDE)

D = [0.4];% noise variance
%% Integration
dt = 0.014; % timestep
freq = 1/dt;
iters = 65000; %path length
time = [0:dt:iters*dt];
xinit = [pi];% initial conditions

x = [];
x = xinit; 
 for ii = 1:length(time)
                 xdot = laneqn(time(ii),x(ii)); xdot = xdot';
                 x(ii+1) = x(ii) + dt*xdot + sqrt(2*D).*randn(size(xdot)).*dt;                   
 end

 x(end) = [];

 figure(1)
subplot(3,1,1);
plot(time,x)
title('time series phi rel HKB')
xlabel('time'),ylabel('phi rel HKB (order parameter')
grid on
subplot(3,2,4);
histogram(x)
% xlabel('phi rel'), ylabel('counts')
xlabel(strcat('\phi','(rad.)'))

%  n = histc(y,[-1:0.1:7.3]);
%  subplot(3,1,2);plot([-1:0.1:7.3],n/sum(n));hold on
%  subplot(3,1,3); bar([-1:0.1:7.3],n/sum(n));hold on