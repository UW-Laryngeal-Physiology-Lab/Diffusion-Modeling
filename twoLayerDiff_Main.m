%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% twoLayerDiff_Main
%
% 
%
% Author: Austin J. Scholp, MS
% Last Updated: 3/29/2021
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Constants
D1 = 0;
D2 = 0;
k = sqrt(D1/D2);
alpha = (1-k)/(1+k);
C0 = 0;
L=0;

%% Equation 1

syms n x t

%((((2*n)+1)*L)+x)
%((((2*n)+1)*L)-x)
%(2*sqrt(D1*t))

F1=symsum(alpha^n*(erfc(((((2*n)+1)*L)+x)/(2*sqrt(D1*t)))-alpha*...
    erfc(((((2*n)+1)*L)-x)/(2*sqrt(D1*t)))),n,0,Inf);

C1=C0*F1;

%% Equation 2


syms n x t

%((((2*n)+1)*L)+(k*x))
%(2*sqrt(D1*t))

F2=symsum(alpha^n*(erfc(((((2*n)+1)*L)+(k*x))/(2*sqrt(D1*t)))));

C2=((2*k*C0)/(k+1))*F2;




