clear all; close all;
pkg load control

% filter bandwidth in Hz
bw = 1;

% filter sample rate in Hz
sample_rate = 10;

% continuous time filter (infinite sample rate)
sys = tf(bw*2*pi,[1 bw*2*pi]);

% discrete time filter
sys_d = c2d(sys,1/sample_rate);

% frequencies to evaluate filter over
omega = linspace(.1, sample_rate*5*pi,50000);

% plot side-by-side view of transfer functions
figure;
bode(sys,sys_d,omega)
subplot(2,1,1)
legend('continuous','discrete','location','northwest')
subplot(2,1,2)
legend('continuous','discrete','location','northwest')

print -djpeg filter_aliasing_bode.jpg

% get filter reponse to 11 Hz sin wave sampled at 100 Hz
t = 0:0.01:1;
u = sin(11*2*pi*t+pi/2);
y = lsim(sys, u, t);

% get filter reponse to 11 Hz sin wave sampled at 10 Hz
t2 = 0:1/sample_rate:1;
u2 = sin(11*2*pi*t2+pi/2);
y2 = lsim(sys, u2, t2);

figure;
subplot(2,1,1)
plot(t,u)
hold all;
plot(t,y)
legend('signal', 'filtered signal','location','northwest')
title('continuous signal (no aliasing)')

subplot(2,1,2)
plot(t2,u2)
hold all;
plot(t2,y2)
legend('signal', 'filtered signal','location','northwest')
title('sampled signal (with aliasing)')

print -djpeg filter_aliasing_signal.jpg

