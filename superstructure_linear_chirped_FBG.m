% Fibre Bragg Gratings Parameters
Lg = 0.01;                               % length of the grating
n_eff = 1.4683;                          % effective index
c = 3e8;                                 % Speed of light
N = 500;                                 % Number of points in the array

% Pitch
pitch = 5.27821289927127e-07;               % pitch value to give a Bragg wavelength of around 1550nm
Pitch = pitch*linspace(0.975,1.025,N);        % chirped Pitch for a broader bandwidth

% Coupling Coefficient:
window_func = 'blackman';                   % Apodisation
Kappa1 = ones([1,50]).*select_wdw(window_func,50);
Kappa2 = zeros([1,100]);
Kappa3 = cat(2,Kappa1,Kappa2,Kappa1,Kappa2,Kappa1,Kappa2,Kappa1);
Kappa4 = ones([1,80]).*select_wdw(window_func,80);
Kappa5 = zeros([1,130]);               
Kappa6 = cat(2,Kappa4,Kappa5,Kappa4,Kappa5,Kappa4);

% For plotting
Lambda_B = 2*n_eff*Pitch;
lambda = linspace(mean(Lambda_B)-5e-8,mean(Lambda_B)+5e-8,2*N);
n = 1:1:N;

f = tiledlayout(3,3);
% Plotting reflected power
ax1 = nexttile(f,[3,2]);
rho1 = get_rho_transfer_matrix(Lg,n_eff,Pitch,Kappa3,lambda); 
rho2 = get_rho_transfer_matrix(Lg,n_eff,Pitch,Kappa6,lambda); 
P1 = abs(rho1).^2;
P2 = abs(rho2).^2;
plot(ax1,lambda,P1,lambda,P2);
xlabel(ax1,'\lambda (m)')
ylabel(ax1,'P')
title(ax1,'Reflected Power')
%legend('With 4 peaks', 'With 3 peaks')

% Ploting group delay
phi1 = unwrap(angle(rho1));
ax2 = nexttile;
w = 2*pi*n_eff*(c./lambda);
group_delay = diff(phi1) ./ diff(w);
lambda = lambda(1:end-1);
plot(ax2,lambda,group_delay*1e12)
xlabel(ax2,'\lambda (m)')
ylabel(ax2,'Group delay (ps)')
title(ax2,'Group delay');

% Plot kappa characteristics
ax3 = nexttile;
plot(ax3,n*Lg/N*100,Kappa3,n*Lg/N*100,Kappa6);
xlabel(ax3,'Position (cm)')
ylabel(ax3,'\kappa')
title(ax3,'Coupling coefficient \kappa')

% Plotting pitch characteristics
ax4 = nexttile;
plot(ax4,n*Lg/N*100,Pitch)
xlabel(ax4,'Position (cm)')
ylabel(ax4,'\Lambda')
title(ax4,'Pitch \Lambda');

title(f,sprintf('Performance of a superstructure FBG, Lg = %.02fcm, Apodisation = %s', Lg*100, window_func));