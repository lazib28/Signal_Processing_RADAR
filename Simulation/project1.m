%DEFINING THE VARIABLES
%x=transmitted signal
%tstep2 defines the t-axis for x
%d=distance between radar and target
%v=velocity of signal in air
%t_delay=time taken for signal to go to and fro bwtween radar and target
%A= Attenuation factor
%SNR= Signal to Noise ratio
%ax= attenuated signal with delay too
%t_ax=time axis for attenuated signal with delay
%SP=Signal Power
%NP=Noise Power
%noise
%y=recieved signal
%corr= o/p of xcorr
%corrid indices of corr




%MAKING THE TRANSMITTED SIGNAL

%making a signal called x1 which will be a sinusoid with a period=150 secs and will run from 0<t<300
Am=5;
T=150;
f=1/150;
tstep=0:f:300
x1=Am*sin(2*pi*f*tstep)
% making a signal called x2 which will be a sinusoid of 0 amplitude and
% will run from 300+f <t<1000
tstep1= (300+f):f:1000
x2=0*sin(2*pi*f*tstep1)
%transmitted signal 'x'=x1+x2 and will run from 0<t<1000
tstep2=0:f:1000
x=[x1 x2]

%MAKING THE RECEIVED SIGNAL

%calculating the time delay
d=165*1000;
v=330;
t_delay=((2*d)/v)
%attenuation factor and SNR
A=0.9;
SNR=-35;
%making a variable tstep3 which will run from 0 to 1000 secs with 1/150
%increments
tstep3=0:f:t_delay
%setting up the attenuated and delayed signal (ax) and its its time axis (t_ax)
t_ax=[tstep3 tstep2+t_delay]
ax =[zeros(1,length(tstep3)) x.*A];
% calculating signal and noise power
SP=sum(ax.^2)/length(ax);
NP=SP/10^(SNR/10);
%noise signal
noise=sqrt(NP)*randn(1,length(ax));
% recieved signal= Attenuated and Delayed Signal + Noise signal
y=ax+noise;

%CORRELATION 

% correlation between transmiited signal (x) and recieved signal (y)
corr=xcorr(x,y)
corrid=f*(1:length(corr))
subplot (4,1,4), plot(corrid,corr)

%GRAPHS

%plotting the graphs
legend1=sprintf('Final Received Signal with Delay= %ds,Attenuation=%.1f and Noise=%ddB',t_delay,A,SNR)
legend2=sprintf('Signal with Delay=%ds and Attenuation=%.1f',t_delay,A)

subplot(4,1,1),plot(tstep2,x), xlabel('Time (s)'), ylabel('Amplitude'),title('Transmitted Signal')
subplot(4,1,2),plot(t_ax,ax), xlabel('Time (s)'), ylabel('Amplitude'),title(legend2),grid on
subplot(4,1,3), plot(t_ax,y) , xlabel('Time (s)'), ylabel('Amplitude'),title(legend1),grid on
subplot (4,1,4), plot(corrid,corr), xlabel('Time (s)'),title('Cross correlation between Transmitted Signal and Recieved Signal')




