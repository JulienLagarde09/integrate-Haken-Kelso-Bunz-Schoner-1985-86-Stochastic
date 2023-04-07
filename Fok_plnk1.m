
phi=0:.01:2*pi;
Q=5;
b=4;
V=-cos(phi)-b*cos(2*phi);
F=exp((2*cos(phi)+2*b*cos(2*phi))/Q);
figure;
% subplot(3,3,9)
plot(phi,F);hold on;plot(phi,V,'r')
hold on;
