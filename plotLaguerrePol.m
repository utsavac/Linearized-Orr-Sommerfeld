% Function to plot the Laguerre Polynomials for some random points...

function plotLaguerrePol (laguerrePol,xx)

    lw=1.5; 
    color{1} = 'k'; symb{1} = 'o';
    color{2} = 'r'; symb{2} = 's';
    color{3} = 'b'; symb{3} = 'p';
    color{4} = 'm'; symb{4} = 'd';
    color{5} = 'g'; symb{5} = '*';
    color{6} = 'c'; symb{6} = 'h';
    
    plotNum = size(laguerrePol,2);
    if(size(xx,1) == 1); xx=transpose(xx); end
    
    for i=1:plotNum
        plot(laguerrePol(:,i),xx,sprintf('-%s%s',symb{i},color{i}),...
            'MarkerIndices',1:100:size(laguerrePol,1),'linewidth',lw); 
        hold on;
    end
    
    hold off; grid on;
    ylabel('$y$','FontSize',16,'interpreter','latex'); 
    xlabel('$L_m(y)$','FontSize',16,'interpreter','latex');
    axis([-20 20 0 30]);
    legend('m = 0','m = 1','m = 2','m = 3','m = 4','m = 5','m = 6');
    title('Laguerre Polynomials','FontSize',17,'FontWeight','Normal');
    
end