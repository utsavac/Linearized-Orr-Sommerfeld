function plotLaguerreGaussQuadrature(order)

    % Color Scheme:
    scolor{1} = 'ok';
    scolor{2} = 'db';
    scolor{3} = 'sr';
    scolor{4} = 'pm';
    scolor{5} = 'hg';
    
    num = size(order,1);
    
    for i=1:num; gaussQuad(i).data = makeLaguerreGQNodes(order(i,1)); end
    for i=1:num; x(i).data = i*ones(order(i)+1); end
    
    figure;
    subplot(1,2,1);
    for i=1:num
        col=char(strsplit(scolor{i}));
        plot(x(i).data,gaussQuad(i).data,...
            scolor{i},...
            'markersize',6,...
            'linewidth',2);           
        hold on;
    end
    ylabel('$y$','FontSize',16,'interpreter','latex');
    xlim([0.5 num+0.5]); set(gca,'XTick',[]);    
    ax=gca; ax.YGrid='on'; ax.GridLineStyle = '-';   
    
    subplot(1,2,2);
    for i=1:num
        plot(gaussQuad(i).data,...
            sprintf('-%s',scolor{i}),...
            'markersize',6,...
            'linewidth',2);             
        hold on;
    end
    ylabel('$y$','FontSize',16,'interpreter','latex');   
    ax=gca; ax.YGrid='on'; ax.GridLineStyle = '-';
    legend(sprintf('N = %d',order(1)),...
        sprintf('N = %d',order(2)),...
        sprintf('N = %d',order(3)));    

end