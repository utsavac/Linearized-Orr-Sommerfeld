function plotChebyPol (chebyPol,xx)

    lw=1.5; 
    color{1} = 'k'; symb{1} = 'o';
    color{2} = 'r'; symb{2} = 's';
    color{3} = 'b'; symb{3} = 'p';
    color{4} = 'm'; symb{4} = 'd';
    color{5} = 'g'; symb{5} = '*';
    color{6} = 'c'; symb{6} = 'h';
    
    plotNum = size(chebyPol,2);
    if(size(xx,1) == 1); xx=transpose(xx); end
    
    figure;
    for i=1:plotNum
        plot(chebyPol(:,i),xx,sprintf('-%s%s',symb{i},color{i}),...
            'MarkerIndices',1:100:size(chebyPol,1),'linewidth',lw); 
        hold on;
    end
    
    hold off; grid on;
    ylabel('$y$','FontSize',16,'interpreter','latex'); 
    xlabel('$T_m(y)$','FontSize',16,'interpreter','latex');
    axis([-1.1 1.1 -1 1]);
    legend('m = 0','m = 1','m = 2','m = 3','m = 4','m = 5','m = 6');
    title('Chebyshev Polynomials','FontSize',17,'FontWeight','Normal');
    
end