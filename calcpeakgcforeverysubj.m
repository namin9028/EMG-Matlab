load('E:\EMG\Code\Code\PeriodAmp\peakandgaitcycledata\c1\chonepone.mat')
%load('E:\EMG\Code\Code\PeriodAmp\peakandgaitcycledata\c1\choneptwo.mat')
%load('E:\EMG\Code\Code\PeriodAmp\peakandgaitcycledata\c1\chonepthree.mat')
%one two and three are periods

AECmax = [AECmax1, AECmax2, AECmax3, AECmax4, AECmax5];
AECy = [AECy1, AECy2, AECy3, AECy4, AECy5];
Controlmax = [Controlmax1, Controlmax2, Controlmax3, Controlmax4, Controlmax5]
Controly = [Controly1, Controly2, Controly3, Controly4, Controly5];
PFDFmax = [PFDFmax1, PFDFmax2, PFDFmax3, PFDFmax4, PFDFmax5];
PFDFy = [PFDFy1, PFDFy2, PFDFy3, PFDFy4, PFDFy5];
PSDSmax = [PSDSmax1, PSDSmax2, PSDSmax3, PSDSmax4, PSDSmax5];
PSDSy = [PSDSy1, PSDSy2, PSDSy3, PSDSy4, PSDSy5];




AECpeak = mean2(AECmax)
AECstd = std2(AECmax)
AECgc = mean2(AECy./10)
AECgcstd = std2(AECy./10)

Controlpeak = mean2(Controlmax)
Controlpeakstd = std2(Controlmax)
Controlgc = mean2(Controly./10)
COntrolgcstd = std2(Controly./10)

PSDSpeak = mean2(PSDSmax)
PSDSstd = std2(PSDSmax)
PSDSgc = mean2(PSDSy./10)
PSDSgcstd = std2(PSDSy./10)

PFDFpeak = mean2(PFDFmax)
PFDFstd = std2(PFDFmax)
PFDFgc = mean2(PFDFy./10)
PFDFgcstd = std2(PFDFy./10)

filename = 'peakamp.xlsx';
A = {'NrmlPeak[C,S,AE6,F,AE8,AEC]','peakstd','Gait Cycle','gcstd'; Controlpeak , Controlpeakstd, Controlgc, COntrolgcstd; PSDSpeak' , PSDSstd, PSDSgc, PSDSgcstd ; PFDFpeak , PFDFstd, PFDFgc, PFDFgcstd; AECpeak, AECstd, AECgc, AECgcstd }
sheet = 1;
xlRange = 'A9';
xlswrite(filename,A,sheet,xlRange)
