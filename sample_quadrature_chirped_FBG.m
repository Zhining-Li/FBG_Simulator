% This is a quadratured chirped FBG that gives a top-hat reflectivity
% profile.

% Specify FBG Properties
Lg = 0.1;                           % length of the FBG grating in meters
n_eff = 1.4683;                     % effective index of the grating
c = 3e8;                            % Speed of light

% Pitch Profile: quadrature chirped
pitch = 5.27821289927127e-07;  
x = linspace(0.05,0.1,1000);
Pitch = pitch*(1-x.^2);
diff_mean1 = mean(Pitch)-pitch;
Pitch = Pitch - diff_mean1;

% Kappa: Bespoke
Kappa = [linspace(0,7.8,100) linspace(7.8,10,750) linspace(10,0,150)];

% Phase: Default
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

% Ploting Phase
ax4 = nexttile;
plot(ax4,n*Lg/N,Phase);

title(f,sprintf('Performance of a quadrature chirped FBG, Lg = %.02fcm, Apodisation = %s', Lg*100, window_func));