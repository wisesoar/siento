function createfigure(figure1, X1, Y1, X2, Y2, Y3, Y4, Y5, X3, Y6, mHRV, sHRV, mEMG, sEMG)
%CREATEFIGURE(X1,Y1,X2,Y2,Y3,Y4,Y5,X3,Y6)
%  X1:  vector of x data - time
%  Y1:  vector of y data - raw ecg
%  X2:  vector of x data - freq
%  Y2:  vector of y data - Raw ecg FT
%  Y3:  vector of y data - Filt ECG
%  Y4:  vector of y data  - Filt ECG FT
%  Y5:  vector of y data - Filt EMG
%  X3:  vector of x data - Freq
%  Y6:  vector of y data - Filt EMG FT

%  Auto-generated by MATLAB on 07-May-2009 06:49:33

% Create figure
%figure1 = figure('PaperSize',[20.98 29.68]);

% Create subplot
subplot1 = subplot(3,2,1,'Parent',figure1);
%box('on');
%hold('all');

% Create plot
plot(X1,Y1,'Parent',subplot1);
drawnow

% Create title
title('ECG');

% Create xlabel
xlabel('Secs');
% Create ylabel
ylabel('ECG  (mVolts)');

% Create subplot
subplot2 = subplot(3,2,2,'Parent',figure1);
%box('on');
%hold('all');

% Create plot
plot(X2,Y2,'Parent',subplot2);
drawnow

% Create title
title('Single-Sided Amplitude Spectrum of y(t)');

% Create xlabel
xlabel('Frequency (Hz)');
% Create ylabel
ylabel('|Y(f)|');

% Create subplot
subplot3 = subplot(3,2,3,'Parent',figure1);
% box('on');
% hold('all');

% Create plot
plot(X1,Y3,'Parent',subplot3);
drawnow

% Create title
title('Filtered ECG');

% Create xlabel
xlabel('Secs');
% Create ylabel
ylabel('ECG  (mVolts)');

% Create subplot
subplot4 = subplot(3,2,4,'Parent',figure1);
% box('on');
% hold('all');

% Create plot
plot(X2,Y4,'Parent',subplot4);
drawnow

% Create title
title('Single-Sided Amplitude Spectrum of y(t)');

% Create xlabel
xlabel('Frequency (Hz)');
% Create ylabel
ylabel('|Y(f)|');

% Create subplot
subplot5 = subplot(3,2,5,'Parent',figure1);
% Uncomment the following line to preserve the X-limits of the axes
% xlim([0 30]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim([-5 5]);
% box('on');
grid('on');
% hold('all');

% Create plot
plot(X1,Y5,'Parent',subplot5);
drawnow

% Create title
title('Filtered EMG');

% Create xlabel
xlabel('Secs');

% Create ylabel
ylabel('EMG  (mVolts)');

% Create subplot
subplot6 = subplot(3,2,6,'Parent',figure1);
% box('on');
% hold('all');

% Create plot
plot(X3,Y6,'Parent',subplot6);
drawnow

% Create title
title('Single-Sided Amplitude Spectrum of y(t)');

% Create xlabel
xlabel('Frequency (Hz)');
% Create ylabel
ylabel('|Y(f)|');

% Create textbox
% HeartRate = 22;
% annotation(figure1,'textbox',[0.926 0.795 0.07692 0.05545],'String',{'HR' HR});
% annotation(figure1,'textbox',[0.926 0.195 0.07692 0.05545],'String',{'Mean' mEMG});

gcs1=axes('position',[0.926 0.795 0.07692 0.05545])
set(gcs1,'xtick',[])
set(gcs1,'ytick',[])
text(.01,.5,{'mHRV' mHRV}); %Mean Heart Rate Variability(HRV)
drawnow

gcs2=axes('position',[0.926 0.695 0.07692 0.05545])
set(gcs2,'xtick',[])
set(gcs2,'ytick',[])
text(.01,.5,{'sHRV' sHRV});  %Std Dev Heart Rate Variability(HRV)
drawnow

gcs3=axes('position',[0.926 0.195 0.07692 0.05545])
set(gcs3,'xtick',[])
set(gcs3,'ytick',[])
text(.01,.5,{'mEMG' mEMG}); %Mean EMG
drawnow

gcs4=axes('position',[0.926 0.095 0.07692 0.05545])
set(gcs4,'xtick',[])
set(gcs4,'ytick',[])
text(.01,.5,{'sEMG' sEMG}); %Std Dev EMG
drawnow


