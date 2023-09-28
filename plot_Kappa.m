function plot_Kappa(ax,n,Lg,N,Kappa)
    % Plot Couple Coefficient along a grating

    plot(ax,n*Lg/N,Kappa);
    xlabel(ax,'Position (m)');
    ylabel(ax,'\kappa');
    title(ax,'Coupling coefficient \kappa');
end