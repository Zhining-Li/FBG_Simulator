% This is a phase-shifted FBG sample

% Specify FBG Properties
Lg = 0.1;                           % length of the FBG grating in meters
n_eff = 1.4683;                     % effective index of the grating
c = 3e8;                            % Speed of light

% Pitch profile: unchirped
pitch = 5.27821289927127e-07;            
Pitch = pitch*ones([1,1000]);

% Kappa profile: un-apodised
Kappa = 10*ones([1,1000]); 
window_func = 'rectangular';
Kappa = Kappa.*select_wdw(window_func,1000);

% Phase profile: phase shift at the center of the grating
Phase = zeros([1,1000]);
Phase(500) = pi;


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
plot_Reflection(ax2,rho,Lambda);

% Plotting pitch characteristics
ax3 = nexttile;
plot_Pitch(ax3,n,Lg,N,Pitch);

% Ploting Phase
ax4 = nexttile;
plot(ax4,n*Lg/N,Phase);

title(f,sprintf('This is an unchirped, un-apodised pi-phase shifted FBG sample, Lg = %.02fcm', Lg*100));

