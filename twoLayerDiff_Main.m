%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% twoLayerDiff_Main
%
%
% Author: Austin J. Scholp, MS
% Last Updated: 6/30/2021
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close;clc
%% Define Constants

t = 120; %time in minutes
C0 = 66; %original concentration in mu_mol per cm^3
L = 0.068; %sample epithelial length cm
D1 = linspace(1e-4,.02,100); %diffusion constants to test cm^2/minute
D2 = D1;

depth = [0.0057	0.0307	0.0557	0.0807	0.1057	0.1307	0.1557	0.1807];%cm

xVars = cell(1,size(D1,2)); 
yVars = cell(size(D2,2),1);
for i = 1:size(D1,2)
    xVars{i} = strcat('D1= ', num2str(D1(i)));
    yVars{i} = strcat('D2= ', num2str(D2(i)));
end

%% Comparison Values

five = [59	52	39	20	11	1	1E-13	1.00E-13];
fifteen = [63	62	48	49	46	40	30	36];
thirty = [66	65	68	64	61	58	42	44];
sixty = [64	64	66	69	69	67	67	64];
onetwenty = [66	65	64	66	65	65	62	60];

%% Equations
N = 501; %number of summations
F1 = zeros(N,1);
filename = ('Data_120-min.xlsx');
C2 = zeros(size(D1,2),size(D2,2),size(depth,2));

for a = 1:size(D1,2)
    for b = 1:size(D2,2)
        for d = 1:size(depth,2)
            for n = 1:N
                F1(n) = (((1-(sqrt(D1(a)/D2(b))))/(1+(sqrt(D1(a)/D2(b)))))...
                    ^(n-1)*(erfc(((((2*(n-1))+1)*L)+((sqrt(D1(a)/D2(b)))...
                    *depth(d)))/(2*sqrt(D1(a)*t)))));
                F2 = sum(F1);
            end
            C2(a,b,d) = abs((((2*(sqrt(D1(a)/D2(b)))*C0)/...
                ((sqrt(D1(a)/D2(b)))+1))*F2))-onetwenty(d);
            
        end
    end
end


%% Write data to Excel 
for d = 1:size(depth,2)
    sheet = d;
    Tab = array2table(C2(:,:,d),'VariableNames',xVars,'RowName',yVars);
    writetable(Tab,filename,'sheet',sheet,'Range','A1')
end

%% Find Lowest Difference

 Sheet9 = sum(C2,3);
 [~,I] = min(abs(Sheet9),[],1);
