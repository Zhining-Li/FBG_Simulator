% This is a demo of apodisation effect

% Specify FBG Properties
Lg = 0.1;                           % length of the FBG grating in meters
n_eff = 1.4683;                     % effective index of the grating
c = 3e8;                            % Speed of light                               

% Pitch profile: Linear
pitch = 5.27821289927127e-07;             % pitch value to give a Bragg wavelength of around 1550nm
Pitch = pitch*linspace(0.9975,1.0025,1000);

% Kappa: un-apodised and apodised
Kappa1 = 10*ones([1,1000]);
window_func = 'rectangular';                   % Apodisation
Kappa1 = Kappa1.*select_wdw(window_func,1000);

Kappa2 = 10*ones([1,1000]);
window_func = 'blackman';                   % Apodisation
Kappa2 = Kappa2.*select_wdw(window_func,1000);

Kappa_new = [Kappa1,Kappa2];

% Phase: default
Phase = zeros([1,1000]);


f = nexttile;

for i = 1:2   
    Kappa = Kappa_new(1000*(i-1)+1:1000*i);
    [para_matrix, Lambda_B, Lambda, n, N] = pre_processing(Kappa, Pitch, Phase, n_eff, Lg);
    rho = get_rho_transfer_matrix(Lg,n_eff,para_matrix,Lambda); 
    P = abs(rho).^2;
    plot(f,Lambda*1e9,P);
    hold on
end

xlabel(f,'Incident Wavelength(nm)');
ylabel(f,'P');
title(f,'Reflected Power');
legend(f,'Un-apodised','Apodised-Blackman','location','southeast')


