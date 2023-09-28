function plot_GD(ax,Rho,Lambda,n_eff)
    % Plotting the group velocity profile along a grating
    c = 3e8;
    phi = unwrap(angle(Rho));
    w = 2*pi*n_eff*(c./Lambda);
    group_delay = diff(phi) ./ diff(w);
    LambdaGD = Lambda(1:end-1);
    plot(ax,LambdaGD,group_delay*1e12)
    xlabel(ax,'\lambda (m)')
    ylabel(ax,'Group delay (ps)')
    title(ax,'Group delay');
end