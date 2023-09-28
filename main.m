% This is the main function to implement the simulation of Fibre Bragg Gratings

% Specify FBG Properties
Lg = ;                           % length of the FBG grating in meters
n_eff = ;                        % effective index of the grating
c = ;                            % Speed of light

% Specify parameters along the Fibre Bragg Gratings:
Pitch = ;
% Pitch = pitch*linspace(0.9975,1.0025,1000);
% Pitch = pitch*ones([1,1000]);

Kappa = ;
% Kappa = [linspace(0,7.8,100) linspace(7.8,10,750) linspace(10,0,150)];
% Kappa = 10*ones([1,1000]); 
% window_func = 'rectangular';
% Kappa = Kappa.*select_wdw(window_func,1000);

% Phase
Phase = ;
% Phase(500) = pi;
% Phase(450) = pi;
% Phase(550) = pi;
% Phase(300) = pi;

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

title(f,sprintf('Performance of a Fibre Bragg Grating, Lg = %.02fcm, Apodisation = %s', Lg*100, window_func));