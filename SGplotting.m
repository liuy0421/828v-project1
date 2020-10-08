function SGplotting(fs,gs,title)
    %% norm of function over iterations
    figure;
    hold on;
    grid;
    niter = length(fs);
    plot((0:niter-2)',fs(1:niter-1),'Linewidth',2);
    fsz = 16;
    set(gca,'Fontsize',fsz);
    xlabel('k','Fontsize',fsz);
    ylabel('f','Fontsize',fsz);
    saveas(gcf, strcat(['f_' title '.png']))
    
    %% norm of gradient over iterations
    figure;
    hold on;
    grid;
    niter = length(gs);
    plot((0:niter-1)',gs(1:niter),'Linewidth',2);
    %set(gca,'YScale','log');
    fsz = 16;
    set(gca,'Fontsize',fsz);
    xlabel('k','Fontsize',fsz);
    ylabel('||g||','Fontsize',fsz);
    saveas(gcf, strcat(['g_' title '.png']))

end