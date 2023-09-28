function plot_Phase(ax,n,Lg,N,Phase)
    % Plotting phase profile along a grating
    plot(ax,n*Lg/N,Phase)
    xlabel(ax,'Position (m)')
    ylabel(ax,'Phase')
    title(ax,'Phase (\phi)')
end