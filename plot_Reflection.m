function plot_Reflection(ax,rho,lambda)
    % Plotting reflected power along a grating
    P = abs(rho).^2;
    plot(ax,lambda*1e9,P);
    xlabel(ax,'Incident Wavelength(nm)')
    ylabel(ax,'P')
    title(ax,'Reflected Power')
end