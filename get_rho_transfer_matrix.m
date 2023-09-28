function Rho = get_rho_transfer_matrix(Lg,n_eff,para_matrix,lambda)
    % This function obtains the reflection power of a FBG
    % using a Transfer Matrix Approach, the time complexity is O(MN)

    %   Parameters are:
    %   Name            Type                Desc
    %   Lg              int                 Length of the grating
    %   n_eff           int                 Effective index
    %   para_matrix     3xN matrix          Wrapped matrix containing parameters along the FBG
    %   lambda          1xM array           Range of incident wavelengths


    % Unwrapping the para_matrix
    Kappa = para_matrix(1,:);
    Pitch = para_matrix(2,:);
    Phase = para_matrix(3,:);
    
    N = size(Pitch,2);           
    Lambda_B = 2*n_eff*Pitch;    % Array of Bragg wavelength
    Beta = 2*pi*n_eff./Lambda_B; % Propagation constant
    Deltal = Lg/N;               % Length of each segment - length of fibre for phase correction 
    
    % Array of Pitch0 for phase correction
    Pitch = Pitch.*(Deltal./Pitch-fix(Deltal./Pitch));   

    Phi = 1i*Pitch.*Beta;
    % Initialising a matrix to store the reflection coefficient
    Rho = zeros(1,length(lambda));

    for i=1:length(lambda)
        T = eye(2);                 
        for j = 1:N
            dBeta = 2*pi*n_eff/lambda(i)-Beta(j);
            gamma=sqrt(Kappa(j)^2-dBeta^2);
            % Obtaining corrected r_eff and t_eff for each segment
            r_eff = 1i*Kappa(j)*sinh(-gamma*Deltal)/(-dBeta*sinh(gamma*Deltal)+1i*gamma*cosh(gamma*Deltal));
            t_eff = 1i*gamma*exp(-1i*Beta(j)*Deltal)/(-dBeta*sinh(gamma*Deltal)+1i*gamma*cosh(gamma*Deltal));
            t = t_eff*exp(Phi(j));
            rl = r_eff;
            rr = r_eff*exp(2*Phi(j));
            % Assembling the transfer matrix
            T_11 = 1/t;
            T_12 = -rr/t;
            T_21 = rl/t;
            T_22 = t-rr*rl/t;
            T_new = [T_11 T_12; T_21 T_22];
            T = T*T_new;
            % Assembly Phase Matrix;
            P_new = [1 0; 0 exp(1i*Phase(j))];
            T = T*P_new;
        end
        Rho(i) = -(T(2,1)/T(2,2)); 
    end  
end