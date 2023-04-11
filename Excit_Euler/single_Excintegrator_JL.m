% Integration of a single Excitator with noise (Langevin)
% Noise is additive, scaled by time step, and by variance
% in a regime with a stable fixed point, flow with separatrix
% perturbation by discrete input, the times of onset of which are specified.
% the discrete perturbation comes from the block.m function (step fct).
% Below see commented plotting with nullclines 
% Model from: Viktor Jirsa & Scott Kelso
% Jirsa, V. K., & Scott Kelso, J. A. (2005). The excitator 
% as a minimal model for the coordination dynamics of discrete
% and rhythmic movement generation. Journal of motor behavior, 37(1), 35-51.

clear all; close all
% Euler integration parameters
dt = 0.03; % timestep
iters = 10000; %path length
time = [0:dt:iters*dt];
% Model parameters
a = 0.5;
b = 1;
c = 3;
gamma = 1;
% Time points of perturbations
dt1 = 10; dt2 = 30; dt3 = 50; dt4 = 70; dt5 = 90; dt6 = 110;
dt7 = 130; dt8 = 150; dt9 = 170; dt10 = 190; dt11 = 210; dt12 = 230;
% Initial conditions (must be a column)
yin = [2 -0.8];
% Noise strength of the Langevin equation (see stochastic differential eq.)
D = [0.08 0];

% starts
y = yin; 

 for ii = 1:length(time) % integrate over time
     
            ydot = single_excitator_JL(time(ii),y(ii,:),a,b,c,gamma,dt1,dt2,dt3,...
                dt4,dt5,dt6,dt7,dt8,dt9,dt10,dt11,dt12);
            
               y(ii+1,:) = y(ii,:) + dt*ydot + sqrt(2*D).*randn(size(ydot)).*dt;
            
 end

% plotting from now on

figure(1)

% subplot(3,1,1);
% plot(y(:,1),y(:,2),'g')
% xlabel('x')
% ylabel('y')
% title('Excitator with noise')
subplot(2,2,1);
plot(y(:,1),'k')
ylabel('x')
xlabel('time')
subplot(2,2,2);
plot(y(:,2),'k')
ylabel('y')
xlabel('time')
subplot(2,2,3)
dat_gauche = [zscore(y(:,1)) y(:,2)];
hist3(dat_gauche,[100 100]);

% % if one wants to get max
% yy = Y(:,2);
% yy = yy * (-1);
% [PKS,LOCS]= findpeaks(yy,'minpeakheight',1,'minpeakdistance',50);
% % check:
% figure,plot(yy),hold on,plot(LOCS,PKS,'o')
%*******************************************************
%*******************************************************



% %SCALING AND PLOTTING 
% vv = evalin('base',str1); ww = evalin('base',str2);
% xpt= start:SampleRate:last; %instead of 1 to 500 as x take 500 points between the time span
% plot(xpt,ww,'r');                  % use that as x coordinate and plot sq1
% plot(xpt,vv,'c --')
% 
% 
%  bb1=0.5*block(t,dt1,0.5);plot(t,bb1,'r');
%  bb2=0.5*block(t,dt2,0.5);plot(t,bb2,'c--');


% % % % 
% % % % 
% % % % % nullclines
% % % %         
% % % % xmin=-2;xmax=-xmin;ymin=-2;ymax=-ymin;
% % % % x=[xmin:0.1:xmax];
% % % % z=-gamma*x+x.^3/3; 
% % % % hold on;plot(x,z,'r')
% % % % if abs(b) > 0
% % % %     z = -1/b*( x - a );
% % % % else
% % % %     btilde=0.0001; z = -1/btilde*( x - a );
% % % % end
% % % % plot(x,z,'g')
% % % % 
% % % % % S=-atan(10*x);
% % % % % plot(x,S,'r--');
% % % % 
% % % % xlabel('x')
% % % % ylabel('y')
% % % % title('Phase space diagram')
% % % % axis([1.1*xmin 1.1*xmax 1.1*ymin 1.1*ymax])
