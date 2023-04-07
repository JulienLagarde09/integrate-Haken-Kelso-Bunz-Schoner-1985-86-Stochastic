

init = [0 0.3 0 0.3];


xin = init;
dt = 0.01; % timestep
iters = 10000; %iterations
time = [0:dt:iters*dt];

D = [0.5;0.5;0.5;0.5]; %noise strength

y  = [];

for kk = 1%:length(D) % For each value of noise

        y=[];
        y = xin; % Get Correct x & y as initial conditions
        
        
        for ii = 1:length(time) % integrate over time
            
%             if ii == 10
%                 pert = 0.1;
%             else pert = 0;
%             end
            ydot = coupled_hkb_ode_ED08(time(ii),y(ii,:)); ydot = ydot';
            
            y(ii+1,:) = y(ii,:) + dt*ydot + sqrt(2*D(kk))*randn(size(ydot))*dt + pert ;
            
            %Just a check to define boundary
%             if y(ii,2) > -4
%                 break
%             end %if y > -4
        end % for ii
%         Y(ii,:) = y;
        

end % for kk %


% filtre passe bande

[vFrequency, vAmplitude] = fastfft(y(:,2), 1, [0]);
[C,I] = max(vAmplitude);
F_max_amp = vFrequency(I);
W1 = F_max_amp - (F_max_amp * (15/100));
W2 = F_max_amp + (F_max_amp * (15/100));

n = 1; Wn = [W1 W2]/0.5;

[a,b] = butter(n,Wn);

F_y_2=filtfilt(a,b,y(:,2));

[vFrequency, vAmplitude] = fastfft(y(:,4), 1, [0]);
[C,I] = max(vAmplitude);
F_max_amp = vFrequency(I);
W1 = F_max_amp - (F_max_amp * (15/100));
W2 = F_max_amp + (F_max_amp * (15/100));

n = 1; Wn = [W1 W2]/0.5;

[a,b] = butter(n,Wn);

F_y_4=filtfilt(a,b,y(:,4));


% visu
figure;

subplot(3,1,1)
plot(y(:,2),'b')
hold on
plot(y(:,4),'r')
hold on
plot(F_y_2,'c')
hold on
plot(F_y_4,'m')
legend('brut_1', 'brut_2', 'filt_1', 'filt_2')

subplot(3,1,2)
plot(unwrap(phi(y(:,2),y(:,4))));% unwrap phase relative
hold on
plot(unwrap(phi(F_y_2,F_y_4)),'c');%
legend('brut', 'filt')
 axis([0 length(time) -20 20 ])
subplot(3,3,7)
bin = -3.14:0.05:3.14;
hist(phi(y(:,2),y(:,4)),bin);% histo phase relative
title('phi brutes')
subplot(3,3,8)
hist(phi(F_y_2,F_y_4),bin);% histo phase relative
title('phi filtrées')
subplot(3,6,17)
fastfft(y(:,2),1,[1]);
xlim([-0.004112 0.01254]);
ylim([-100.9 2394]);
subplot(3,6,18)
fastfft(F_y_2,1,[1]);
xlim([-0.004112 0.01254]);
ylim([-100.9 2394]);


ncut=100;

ht=hilbert(y(:,2)-mean(y(:,2)));
phi1=angle(ht);% estimation phase 1
phi1=phi1(ncut:end-ncut);% virage début fin
ht=hilbert((y(:,4)-mean(y(:,4))));
phi2=angle(ht);% estimation phase 2
phi2=phi2(ncut:end-ncut);
phi1 = unwrap(phi1);
phi2 = unwrap(phi2);% unwrap phases
% maybe some use
% A statistical index of the strength of synchronization/ coordination
% = variance estimate for circular (angles) data
% = index of dispersion
synchroindex_brut = (mean(cos(phi1-phi2)))^2 + (mean(sin(phi1-phi2)))^2

ht=hilbert(F_y_2-mean(F_y_2));
phi1=angle(ht);% estimation phase 1
phi1=phi1(ncut:end-ncut);% virage début fin
ht=hilbert(F_y_4-mean(F_y_4));
phi2=angle(ht);% estimation phase 2
phi2=phi2(ncut:end-ncut);
phi1 = unwrap(phi1);
phi2 = unwrap(phi2);% unwrap phases
synchroindex_filt = (mean(cos(phi1-phi2)))^2 + (mean(sin(phi1-phi2)))^2