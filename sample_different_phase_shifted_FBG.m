% This is a arbitrary phase-shifted FBG sample

% Specify FBG Properties
Lg = 0.025;                         % length of the FBG grating in meters
n_eff = 1.45;                       % effective index of the grating
c = 3e8;                            % Speed of light

% Pitch profile: unchirped
pitch = 5.33e-07;            
Pitch = pitch*ones([1,1000]);

% Kappa profile: un-apodised
Kappa = 30*ones([1,1000]); 
window_func = 'rectangular';
Kappa = Kappa.*select_wdw(window_func,1000);

% Phase profile: phase shift at the center of the grating
Phase = zeros([1,1000]);
Phase_shift = [pi/2,pi,3*pi/2];

f = nexttile;

for i = 1:3
    Phase(500) = Phase_shift(i);
    [para_matrix, Lambda_B, Lambda, n, N] = pre_processing(Kappa, Pitch, Phase, n_eff, Lg);
    rho = get_rho_transfer_matrix(Lg,n_eff,para_matrix,Lambda); 
    P = abs(rho).^2;
    plot(f,Lambda*1e9,1-P);

    hold on
end
xlabel(f,'Incident Wavelength(nm)');
ylabel(f,'P');
title(f,'Transmitted Power');
legend(f,'Phase-shift = pi/2','Phase-shift= pi','Phase-shift = 3*pi/2','location','southeast');



