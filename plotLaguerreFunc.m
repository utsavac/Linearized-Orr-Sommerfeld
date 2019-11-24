% Function to plot the Laguerre Functions for some random points...

function plotLaguerreFunc (laguerreFunc,xx)

    lw=1.5; 
    color{1} = 'k'; symb{1} = 'o';
    color{2} = 'r'; symb{2} = 's';
    color{3} = 'b'; symb{3} = 'p';
    color{4} = 'm'; symb{4} = 'd';
    color{5} = 'g'; symb{5} = '*';
    color{6} = 'c'; symb{6} = 'h';
    
    plotNum = size(laguerreFunc,2);
    
    for i=1:plotNum
        plot(laguerreFunc(:,i),xx,sprintf('-%s%s',symb{i},color{i}),...
            'MarkerIndices',1:100:size(laguerreFunc,1),'linewidth',lw); 
        hold on;
    end
    
    hold off; grid on;
    ylabel('$y$','FontSize',16,'interpreter','latex'); 
    xlabel('$\hat{L}_m(y)$','FontSize',16,'interpreter','latex');
    axis([-1.1 1.1 0 30]);
    legend('m = 0','m = 1','m = 2','m = 3','m = 4','m = 5','m = 6');
    title('Laguerre Functions','FontSize',17,'FontWeight','Normal');
    
end