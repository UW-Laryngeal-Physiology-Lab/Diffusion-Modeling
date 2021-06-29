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

t = 5; %minutes
C0 = 66; % mu_mol per cm^3
L = 0.068; %cm
D1 = linspace(1e-4,1,100); %cm^2/minute
D2 = D1;
k = zeros(size(D1,2));
alpha = zeros(size(D1,2));
depth = [0.0057	0.0307	0.0557	0.0807	0.1057	0.1307	0.1557	0.1807]; %cm

for x = 1:size(D1,2)
    for y = 1:size(D2,2)
        k(x,y) = sqrt(D1(x)/D2(y));
    end
end

k = reshape(k.',1,[]);
k = unique(k);

for i = 1:size(k,2)
    alpha(i) = (1-k(i))/(1+k(i));
end

clear x y i j

%% Equations
N = 10;
F1 = zeros(N,1);

for a = 1:size(D1,2)
    for b = 1:size(alpha,2)
        for c = 1:size(k,2)
            for d = 1:size(depth,2)
                for n = 1:N
                    F1(n) = (alpha(b)^n*(erfc(((((2*n)+1)*L)+(k(c)*depth(d)))/(2*sqrt(D1(a)*t)))));
                    F2 = sum(F1);
                end
                C2(a,b,c,d) = ((2*k(c)*C0)/(k(c)+1))*F2;
            end
            
        end
    end
end





