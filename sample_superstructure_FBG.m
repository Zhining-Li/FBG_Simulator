% This is a super_structure FBG sample

% Specify FBG Properties
Lg = 0.1;                           % length of the FBG grating in meters
n_eff = 1.4683;                     % effective index of the grating
c = 3e8;                            % Speed of light    

% Pitch profile: Linear
pitch = 5.27821289927127e-07;             % pitch value to give a Bragg wavelength of around 1550nm
Pitch = pitch*linspace(0.9975,1.0025,1000);


% Kappa: Super_structure, with between compressed to 0
window_func = 'rectangular';                   % Apodisation
Kappa1 = 10*ones([1,50]).*select_wdw(window_func,50);
Kappa = [zeros([1,150]),Kappa1,zeros([1,600]),Kappa1,zeros([1,150])];

% Phase: default
Phase = zeros([1,1000]);

% Plotting of reflection spectra
% Pre-processing of data
[para_matrix, Lambda_B, Lambda, n, N] = pre_processing(Kappa, Pitch, Phase, n_eff, Lg);

% Computing Reflection
rho = get_rho_transfer_matrix(Lg,n_eff,para_matrix,Lambda); 

f = tiledlayout(3,3);

% Plot kappa characteristics
ax1 = nexttile;
plot_Kappa(ax1,n,Lg,N,Kappa);

% Plotting reflected power
ax2 = nexttile(f,[3,2]);
P = abs(rho).^2;
semilogy(ax2,Lambda*1e9,P);
xlabel(ax2,'Incident Wavelength(nm)')
ylabel(ax2,'P')
title(ax2,'Reflected Power')

% Plotting pitch characteristics
ax3 = nexttile;
plot_Pitch(ax3,n,Lg,N,Pitch);

% Ploting Phase
ax4 = nexttile;
plot(ax4,n*Lg/N,Phase);

title(f,sprintf('This is a superstructure FBG sample, Lg = %.02fcm', Lg*100));

