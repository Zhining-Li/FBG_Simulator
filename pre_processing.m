function [para_matrix, Lambda_B, lambda, n, N] = pre_processing(Kappa, Pitch, Phase,n_eff, Lg)
    % This function takes a para_matrix as an input, extract information
    % regarding kappa, pitch and phase to pass into the get_rho functions

    % The para_matrix consists of:
    %   para_matrix(1): Kappa of the FBG
    %   para_matrix(2): Pitch of the FBG
    %   para-matrix(3): Phase of the FBG

    try
        numColsKappa = size(Kappa,2);
        numColsPitch = size(Pitch,2);
        numColsPhase = size(Phase,2);

        if numColsKappa == numColsPitch && numColsPitch == numColsPhase
            disp('Input parameters are compatible');
        else
            error('Please enter vectors for Kappa, Pitch, Phase again, ensuring they are of same length');
        end
    catch ME
        disp(ME.message)
    end

    N = numColsPhase;
    n = 1:1:N;
    para_matrix = [Kappa; Pitch; Phase];
    Lambda_B = 2*n_eff*Pitch;
    
    lambda_B = mean(Lambda_B);

    fprintf('\n')
    disp(['Length of the grating: ',num2str(Lg*100) ,'cm'])
    disp(['Effective index of the grating: ', num2str(n_eff)])
    disp(['The Central Bragg Wavelength is: ', num2str(lambda_B*1e9),'nm']);
    fprintf('\n')
    
        % Determine range of lambda/detuing parameters for plotting
    if numel(unique(Pitch)) == 1
        lambda = linspace(pi*lambda_B/(pi+5000*lambda_B),pi*lambda_B/(pi-lambda_B.*5000),1000);
        fprintf('Plotting reflection spectra for UNCHIRPED grating');

    else
        lambda = linspace(pi*lambda_B/(pi+10000*lambda_B),pi*lambda_B/(pi-lambda_B.*10000),1000);
        disp('Plotting reflection spectra for CHIRPED grating');
    end
end
