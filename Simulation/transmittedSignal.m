function [signal,t] = transmittedSignal(A,T,P,L)
% A = Amplitude of the signal.
% T = Time period.
% P = Pulse count.
% L = Signal length in seconds
%Generating the Original Signal
f=1/150;
t=0:f:L;
signal =[A*sin(2*pi*f*(0:f:P*T)) 0*sin(2*pi*f*(P*T+f:f:L))];
end
