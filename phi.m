%fonction relative phase, transformée de hilbert, signal analytique
% p = phi(x,y);
function p = phi(x,y)

s1 = imag(hilbert(x));
s2 = imag(hilbert(y));
p= atan2(s1.*y-x.*s2,x.*y+s1.*s2);