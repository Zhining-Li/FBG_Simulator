function plot_Pitch(ax,n,Lg,N,Pitch)
    % Plot Pitch Profile Along a grating
    plot(ax,n*Lg/N,Pitch);
    xlabel(ax,'Position (m)');
    ylabel(ax,'\Lambda');
    title(ax,'Pitch \Lambda');
end