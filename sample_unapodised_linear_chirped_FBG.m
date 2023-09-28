% This is an un-apodised linear chirped FBG sample


% Specify FBG Properties
Lg = 0.01;                           % length of the FBG grating in meters
n_eff = 1.4683;                     % effective index of the grating
c = 3e8;                            % Speed of light                               

% Pitch profile: Linear
pitch = 5.27821289927127e-07;             % pitch value to give a Bragg wavelength of around 1550nm
Pitch = pitch*linspace(0.9975,1.0025,1000); % chirped_pitch

% Kappa: un-apodised
Kappa = ones([1,1000]);
window_func = 'rectangular';                   % Apodisation
Kappa = Kappa.*select_wdw(window_func,1000);

% Phase: default
Phase = zeros([1,1000]);


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

% Ploting Group Delay
ax4 = nexttile;
plot_GD(ax4,rho,Lambda,n_eff);

title(f,sprintf('Performance of a linear chirped FBG, Lg = %.02fcm, Apodisation = %s', Lg*100, window_func));