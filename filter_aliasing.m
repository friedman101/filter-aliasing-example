clear all; close all;
pkg load control

% filter bandwidth in Hz
bw = 1;

% filter sample rate in Hz
sample_rate = 100;

% continuous time filter (infinite sample rate)
sys = tf(bw*2*pi,[1 bw*2*pi]);

% discrete time filter
sys_d = c2d(sys,1/sample_rate,'tustin');

% frequencies to evaluate filter over
omega = linspace(.1, 10*2*pi,50000);

% plot side-by-side view of transfer functions
figure;
bode(sys_d,omega)
print -djpeg filter_bode.jpg

% show reponse to a 10 Hz signal
freq = 10;
t = 0:1/sample_rate:2/freq;
u = sin(2*pi*freq*t);
y = zeros(size(u));

for i = 2:length(t)
	y(i) = 0.03046*u(i) + 0.03046*u(i-1) + 0.9391*y(i-1);
end

figure;
plot(t,u)
hold all;
plot(t,y)
legend('u','y')
title('filter response to 10 Hz signal')
print -djpeg filter_10Hz.jpg

% show reponse to a 99.9 Hz signal (which will alias to 0.1 Hz)
freq = 99.9;
t = 0:1/sample_rate:10;
u = sin(2*pi*freq*t);
y = zeros(size(u));

for i = 2:length(t)
	y(i) = 0.03046*u(i) + 0.03046*u(i-1) + 0.9391*y(i-1);
end

figure;
plot(t,u)
hold all;
plot(t,y)
legend('u','y')
title('filter response to 99.9 Hz signal')
print -djpeg filter_99_9Hz.jpg